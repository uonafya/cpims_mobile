import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaseLoadService {
  static const String _caseLoadLastSavePrefKey = 'caseload_last_save';

  static Future<void> saveCaseLoadLastSave(int timestamp) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(_caseLoadLastSavePrefKey, timestamp);
  }

  static Future<int> getCaseLoadLastSave() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt(_caseLoadLastSavePrefKey) ?? 0;
  }

  Future<void> fetchCaseLoadData({
    required BuildContext context,
    required bool isForceSync,
    required String deviceID,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final int caseloadLastSave = await CaseLoadService.getCaseLoadLastSave();
    final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    final int diff = currentTimestamp - caseloadLastSave;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    if (!(isForceSync || diff > 2592000000)) {
      // Todo: 30 days - 2592000000 milliseconds
      print("CaseLoadService not sync");
      Navigator.of(context).pop();
      return;
    }
    print("CaseLoadService sync");

    final dio = Dio();
    final options = BaseOptions(
      baseUrl: cpimsApiUrl,
      headers: {
        'Authorization': 'Bearer ${preferences.getString('access')}',
      },
    );
    dio.options = options;
    dio.interceptors.add(LogInterceptor());

    try {
      final Response response = await dio
          .get('api/caseload', queryParameters: {'deviceID': deviceID});
//TO DO: REMOVE 252
      if (response.statusCode == 200 || response.statusCode == 252) {
        final List<CaseLoadModel> caseLoadModelList = (response.data as List)
            .map((json) => CaseLoadModel.fromJson(json))
            .toList();

        if (kDebugMode) {
          print("CaseLoadService count: ${caseLoadModelList.length}");
        }
        await LocalDb.instance.deleteAllCaseLoad();
        // Insert the list of CaseLoadModel instances in a single batch
        await LocalDb.instance.insertMultipleCaseLoad(caseLoadModelList);

        final int timestamp = DateTime.now().millisecondsSinceEpoch;
        await CaseLoadService.saveCaseLoadLastSave(timestamp);
        await preferences.setBool("hasUserSetup", true);
      } else if (response.statusCode == 254) {
        if (context.mounted) {
          Get.snackbar(
            "Error",
            "You are not authorized to access this resource",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        if (kDebugMode) {
          print("We have an issue");
          await preferences.setBool("hasUserSetup", false);
        }
        if (context.mounted) {
          await preferences.setBool("hasUserSetup", false);
        }
      }
    } catch (e) {
      await preferences.setBool("hasUserSetup", false);
      if (context.mounted) {
        errorSnackBar(context, e.toString());
      }
    } finally {
      Navigator.of(context).pop(); // Dismiss the loading indicator
    }
  }

  Future<void> updateCaseLoadData({
    required BuildContext context,
    required String deviceID,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final dio = Dio();
    final options = BaseOptions(
      baseUrl: cpimsApiUrl,
      headers: {
        'Authorization': 'Bearer ${preferences.getString('access')}',
      },
    );
    dio.options = options;
    dio.interceptors.add(LogInterceptor());

    try {
      final Response response =
          await dio.get('caseload', queryParameters: {'deviceID': deviceID});

      if (response.statusCode == 200) {
        final List<CaseLoadModel> caseLoadModelList = (response.data as List)
            .map((json) => CaseLoadModel.fromJson(json))
            .toList();

        if (kDebugMode) {
          print("CaseLoadService count: ${caseLoadModelList.length}");
        }

        // Update the list of CaseLoadModel instances in a single batch
        await LocalDb.instance.updateMultipleCaseLoad(caseLoadModelList);
      } else {
        if (kDebugMode) {
          print("We have an issue");
        }
      }
    } catch (e) {
      if (context.mounted) {
        errorSnackBar(context, e.toString());
      }
    }
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../screens/cpara/model/cpara_model.dart';
class CaseLoadService {
  Future<bool> fetchCaseLoadData({
    required BuildContext context,
    required bool isForceSync,
    required String deviceID,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final int caseloadLastSave = preferences.getInt('caseload_last_save') ?? 0;
    final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    final int diff = currentTimestamp - caseloadLastSave;
    dio.interceptors.add(LogInterceptor());

    if (!(isForceSync || diff > 2592000000)) {
      // Todo: 30 days - 2592000000 milliseconds
      print("CaseLoadService not sync");
      return false; // Indicate that synchronization was not performed
    }
    print("CaseLoadService sync");

    try {
      final accessToken = preferences.getString('access');
      Response response = await dio.get(
        '${cpimsApiUrl}caseload?deviceID=$deviceID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200) {
<<<<<<< HEAD
        // LocalDb.instance.deleteAllCaseLoad(); TODO: Handle this when updating caseload
        for (int i = 0; i < jsonDecode(response.body).length; i++) {
=======
        for (int i = 0; i < jsonDecode(response.data).length; i++) {
>>>>>>> cpims/merge-fixes
          CaseLoadModel caseLoadModel = CaseLoadModel.fromJson(
            jsonDecode(response.data)[i],
          );
          if (kDebugMode) {
            print(caseLoadModel.caregiverNames);
          }
          LocalDb.instance.insertCaseLoad(caseLoadModel);
        }
        final int timestamp = DateTime.now().millisecondsSinceEpoch;
        await preferences.setInt('caseload_last_save', timestamp);
        return true; // Indicate that synchronization was successful
      } else {
        if (kDebugMode) {
          print("We have an issue");
        }
      }
    } catch (e) {
      if (context.mounted) {
        debugPrint(e.toString());
        errorSnackBar(context, "An error occurred while synchronizing data");
      }
    }
    return false;
  }
}



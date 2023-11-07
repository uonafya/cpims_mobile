import 'dart:async';
import 'dart:convert';

import 'package:cpims_mobile/Models/caseplan_form_model.dart';
import 'package:cpims_mobile/Models/form_1_model.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class Form1Service {
  final StreamController<int> _formCountController =
      StreamController<int>.broadcast();
  Stream<int> get formCountStream => _formCountController.stream;

  // save form to local storage
  static _saveValues(String formType, formData, metadata, uuid) async {
//save the form data that is in the form of a map to  a local database
    final db = LocalDb.instance;
    try {
      await db.insertForm1Data(formType, formData, metadata, uuid);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

// delete a form from local storage
  static Future<bool> _deleteValue(String formType, int id) async {
    final db = LocalDb.instance;
    try {
      await db.deleteForm1Data(formType, id);
      return true;
    } catch (e) {
      debugPrint("An error on deleteValue ${e.toString()}");
    }
    return false;
  }

  static Future<void> updateFormOneLocalDateSync(
      String formType, int id) async {
    final db = LocalDb.instance;
    try {
      db.updateForm1DataDateSync(formType, id);
    } catch (e) {
      debugPrint("An error on updateFormLocalDateSync ${e.toString()}");
    }
  }

// get all forms from local storage
  static _getAllValues(String formType) async {
    final db = LocalDb.instance;
    try {
      List<Map<String, dynamic>> maps = await db.queryAllForm1Rows(formType);
      List<Form1DataModel> forms = [];
      for (var map in maps) {
        forms.add(Form1DataModel.fromJson(map));
      }
      debugPrint("_getAllValues: $forms");
      return forms;
    } catch (e) {
      if (kDebugMode) {
        print("An error on getallValues ${e.toString()}");
      }
    }
    return [];
  }

  static countCparaUnsyncedForms() async {
    final db = LocalDb.instance;
    try {
      final count = await db.getUnsyncedCparaFormCount();
      debugPrint("Form count: $count");
      if (count != null) {
        return count;
      } else {
        return 0;
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error on getFormCount: ${e.toString()}");
      }
    }
    return 0; // Return 0 if there is an error.
  }

  static ovcSubCount() async {
    final db = LocalDb.instance;
    try {
      final count = await db.countOvcSubpopulationDataWithNullDateSynced();
      debugPrint("Form count ovc_sub_populatuion: $count");
      if (count != null) {
        return count;
      } else {
        return 0;
      }
    } catch (e) {
      if (kDebugMode) {
        print(
            "An error on getFormCount for ovc sub population: ${e.toString()}");
      }
    }
    return 0; // Return 0 if there is an error.
  }

  static Future<int?> getFormCount(String formType) async {
    final db = LocalDb.instance;
    try {
      final count = await db.queryForm1UnsyncedForms(formType);
      debugPrint("Form count: $count");
      if (count != null) {
        return count;
      } else {
        return 0;
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error on getFormCount: ${e.toString()}");
      }
    }
    return 0; // Return 0 if there is an error.
  }

  Future<void> updateFormCount(String formType) async {
    try {
      final db = LocalDb.instance;
      Stream<int> unsyncedFormsStream =
          await db.queryForm1UnsyncedFormsStream(formType);

      unsyncedFormsStream.listen((count) {
        _formCountController.add(count);
      }, onError: (error) {
        _formCountController.addError(error);
      });
    } catch (e) {
      if (kDebugMode) {
        print("An error on updateFormCount: ${e.toString()}");
      }
      _formCountController.addError(e);
    }
  }

  static Future<Response> _postForm(
      formData, String formEndpoint, String authToken) async {
    var data = jsonEncode(formData);

    final dio = Dio();
    dio.interceptors.add(LogInterceptor());
    dio.options.headers['Authorization'] =
        'Bearer $authToken'; // Add Bearer token
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';

    try {
      final response = await dio.post(formEndpoint, data: data);
      if (response.statusCode == 201) {
        debugPrint("Data posted  successfully to server is $data");
        return response;
      } else {
        debugPrint("Failed to form one data to server ${response.statusCode}");
      }
      return response;
    } catch (e) {
      debugPrint("Failed to post form one data: ${e.toString()}");
      return Response(
          data: "An error occurred: ${e.toString()}",
          statusCode: 500,
          requestOptions: RequestOptions(path: formEndpoint));
    }
  }

  static Future<dynamic> saveFormLocal(
      String formType, formData, metadata, uuid) {
    return _saveValues(formType, formData, metadata, uuid);
  }

  static Future<bool> deleteFormLocal(String formType, int id) {
    return _deleteValue(formType, id);
  }

  static Future<void> updateFormLocalDateSync(String formType, int id) async {
    final db = LocalDb.instance;
    try {
      db.updateForm1DataDateSync(formType, id);
    } catch (e) {
      debugPrint("An error on updateFormLocalDateSync ${e.toString()}");
    }
  }

  static getAllForms(String formType) {
    return _getAllValues(formType);
  }

  static Future<int?> getCountAllFormOneA() {
    return getFormCount("form1a");
  }

  static Future<int?> getCountAllFormOneB() async {
    return await getFormCount("form1b");
  }

  //count cpara forms
  static Future<int?> getCountAllFormCpara() async {
    return await countCparaUnsyncedForms();
  }

  // send form to server
  static Future<Response> postFormRemote(
      formData, String formType, String authToken) async {
    String formEndpointMobile = "${cpimsApiUrl}mobile/form/$formType/";
    return _postForm(formData, formEndpointMobile, authToken);
  }
}

class CasePlanService {
  // save form to local storage
  static saveCasePlanLocal(formData) async {
//save the form data that is in the form of a map to  a local database
    final db = LocalDb.instance;
    try {
      await db.insertCasePlanNew(formData);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

// delete a form from local storage
//   static deleteCasePlanLocal(String ovcCpimsId) async {
//     final db = LocalDb.instance;
//     try {
//       await db.deleteCasePlan(ovcCpimsId);
//       return true;
//     } catch (e) {
//       print(e);
//     }
//     return false;
//   }

// get all forms from local storage
  static getCasePlanRecordLocal(ovcCpimsId) async {
    final db = LocalDb.instance;
    try {
      CasePlanModel? casePlanRecord = await db.getCasePlanById(ovcCpimsId);
      Map<String, dynamic>? casePlanMap = casePlanRecord?.toJson();
      List<Map<String, dynamic>?> casePlanList = [];
      casePlanList.add(casePlanMap);

      return casePlanList;
    } catch (e) {
      if (kDebugMode) {
        print(">>>>>>>>>>>>>>>>>>>>>>>>>$e");
      }
    }
    return [];
  }

  static getAllCasePlans() async {
    final db = LocalDb.instance;
    try {
      List<CasePlanModel> casePlans = await db.getAllUnsyncedCasePlans();
      List<Map<String, dynamic>> casePlanList = [];
      for (var casePlan in casePlans) {
        casePlanList.add(casePlan.toJson());
      }
      return casePlanList;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching caseplan fom db $e");
      }
    }
  }

  static postCasePlanRemote(
      CasePlanModel casePlanRecord, String formEndpoint) async {
    var data = casePlanRecord.toJson();
    try {
      http.Response response =
          await ApiService().postSecData(data, formEndpoint);
      if (kDebugMode) {
        print(response.body);
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return http.Response("error", 500);
  }

  static getCaseplanUnsyncedCount() async {
    final db = LocalDb.instance;
    try {
      final count = await db.getUnsyncedCasePlanCount();
      if (count != null) {
        return count;
      } else {
        return 0;
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error on getCaseplanUnsyncedCount: ${e.toString()}");
      }
    }
    return 0; // Return 0 if there is an error.
  }
}

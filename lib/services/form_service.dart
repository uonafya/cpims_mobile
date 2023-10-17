import 'dart:convert';

import 'package:cpims_mobile/Models/caseplan_form_model.dart';
import 'package:cpims_mobile/Models/form_1_model.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/models/interceptor_contract.dart';

import '../constants.dart';

class Form1Service {
  // save form to local storage
  static _saveValues(String formType, formData) async {
//save the form data that is in the form of a map to  a local database
    final db = LocalDb.instance;
    try {
      await db.insertForm1Data(formType, formData);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

// delete a form from local storage
  static _deleteValue(String formType, int id) async {
    final db = LocalDb.instance;
    try {
      await db.deleteForm1Data(formType, id);
      return true;
    } catch (e) {
      debugPrint("An error on deleteValue ${e.toString()}");
    }
    return false;
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
      print("An error on getallValues ${e.toString()}");
    }
    return [];
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
      if (response.statusCode == 200) {
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

  static Future<dynamic> saveFormLocal(String formType, formData) {
    return _saveValues(formType, formData);
  }

  static Future<bool> deleteFormLocal(String formType, int id) {
    return _deleteValue(formType, id);
  }

  static getAllForms(String formType) {
    return _getAllValues(formType);
  }

  // send form to server
  static Future<Response> postFormRemote(
      formData, String formType, String authToken) async {
    String formOneEndpoint = "${cpimsApiUrl}form/${formType}";
    return _postForm(formData, formOneEndpoint, authToken);
  }
}

class CasePlanService {
  // save form to local storage
  static saveCasePlanLocal(formData) async {
//save the form data that is in the form of a map to  a local database
    final db = LocalDb.instance;
    try {
      await db.insertCasePlan(formData);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

// delete a form from local storage
  static deleteCasePlanLocal(String ovcCpimsId) async {
    final db = LocalDb.instance;
    try {
      await db.deleteCasePlan(ovcCpimsId);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

// get all forms from local storage
  static getCasePlanRecordLocal(ovcCpimsId) async {
    final db = LocalDb.instance;
    try {
      CasePlanModel? casePlanRecord = await db.getCasePlan(ovcCpimsId);
      Map<String, dynamic>? casePlanMap = casePlanRecord?.toJson();
      List<Map<String, dynamic>?> casePlanList = [];
      casePlanList.add(casePlanMap);

      return casePlanList;
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>>>>>>>>$e");
    }
    return [];
  }

  static postCasePlanRemote(
      CasePlanModel casePlanRecord, String formEndpoint) async {
    var data = casePlanRecord.toJson();
    try {
      http.Response response =
          await ApiService().postSecData(data, formEndpoint);
      print(response.body);
      return response;
    } catch (e) {
      print(e);
    }
    return http.Response("error", 500);
  }
}

import 'package:cpims_mobile/Models/caseplan_form_model.dart';
import 'package:cpims_mobile/Models/form_1_model.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/services/api_service.dart';
import 'package:http/http.dart' as http;


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
      print(e);
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
      return forms;
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>>>>>>>> $e");
    }
    return [];
  }


  static _postForm(formData, String formEndpoint) async {
    var data = formData.toMap();
    try {
      http.Response response = await ApiService().postSecData(data, formEndpoint);
      print(">>>>>>>>>>>>>>>>>>>>>>>>>> ${response.body}");
      return response;
    } catch (e) {
      print(e);
    }
    return http.Response("error", 500);
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
  static Future<http.Response> postFormRemote(formData, String formType) {
    String formEndpoint = "$formType/";
    return _postForm(formData, formEndpoint);
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

  static postCasePlanRemote(CasePlanModel casePlanRecord, String formEndpoint) async {
    var data = casePlanRecord.toJson();
    try {
      http.Response response = await ApiService().postSecData(data, formEndpoint);
      print(response.body);
      return response;
    } catch (e) {
      print(e);
    }
    return http.Response("error", 500);
  }
}
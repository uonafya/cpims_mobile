import 'dart:convert';

import 'package:cpims_mobile/Models/form_1a.dart';
import 'package:cpims_mobile/helpers/database.dart';
import 'package:cpims_mobile/services/api_service.dart';
import 'package:http/http.dart' as http;
import '../Models/form_1b.dart';
import '../constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// save form to local storage
saveValues(String formType, Form1AData form1A) async {
//save the form data that is in the form of a map to  a local database
  final db = DatabaseHelper();
  try {
    await db.init();
    await db.insertForm1Data(formType, form1A);
    print(">>>>>>>>>>>>>>>>>>>>form saved<<<<<<<<<<<<<<<<");
    return true;
  } catch (e) {
    print(e);
  }
  return false;
}

// delete a form from local storage
deleteValue(String formType, int id) async {
  final db = DatabaseHelper();
  try {
    await db.init();
    await db.deleteForm1AData(formType, id);
    print(">>>>>>>>>>>>>>>>form deleted<<<<<<<<<<<<<<<<<");
    return true;
  } catch (e) {
    print(e);
  }
  return false;
}

// get all forms from local storage
getAllValues(String formType) async {
  final db = DatabaseHelper();
  try {
    await db.init();
    if (formType == 'form1a') {
      List<Map<String, dynamic>> maps = await db.queryAllRows(formType);
      List<Form1AData> forms = [];
      for (var map in maps) {
        forms.add(Form1AData.fromJson(map));
      }
      print(">>>>>>>>>>>>> fetching all form data $forms ");
      return forms;
    }
    List<Map<String, dynamic>> maps = await db.queryAllRows(formType);
    List<Form1BData> forms = [];
    for (var map in maps) {
      forms.add(Form1BData.fromJson(map));
    }
    print(">>>>>>>>>>>>> fetching all form data $forms ");
    return forms;

  } catch (e) {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>$e");
  }
  return [];
}


postForm(formData, String formEndpoint) async {
  var data = formData.toMap();
  try {
    http.Response response = await ApiService().postSecData(data, formEndpoint);
    print(response.body);
    return response;
  } catch (e) {
    print(e);
  }
  return http.Response("error", 500);
}


class Form1Service {

  static Future<bool> saveForm(String formType, Form1AData form1A) {
    return saveValues(formType, form1A);

  }

  static Future<bool> deleteForm(String formType, int id) {
    return deleteValue(formType, id);
  }

  static getAllForms(String formType) {
    return getAllValues(formType);
  }

  // send form to server
  static Future<http.Response> sendForm(formData, String formEndpoint) {
    return postForm(formData, formEndpoint);
  }
}

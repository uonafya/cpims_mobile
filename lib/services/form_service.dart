import 'package:cpims_mobile/Models/form_1a.dart';
import 'package:cpims_mobile/helpers/database.dart';
import 'package:cpims_mobile/services/api_service.dart';
import 'package:http/http.dart' as http;
import '../Models/form_1b.dart';

// save form to local storage
saveValues(String formType, formData) async {
//save the form data that is in the form of a map to  a local database
  final db = DatabaseHelper();
  try {
    await db.init();
    await db.insertForm1Data(formType, formData);
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
      List<Map<String, dynamic>> maps = await db.queryAllForm1Rows(formType);
      List<Form1ADataModel> forms = [];
      for (var map in maps) {
        forms.add(Form1ADataModel.fromJson(map));
      }
      print(">>>>>>>>>>>>> fetching all form data $forms ");
      return forms;
    } else if (formType == 'form1b') {
      List<Map<String, dynamic>> maps = await db.queryAllForm1Rows(formType);
      List<Form1BDataModel> forms = [];
      for (var map in maps) {
        forms.add(Form1BDataModel.fromJson(map));
      }
      print(">>>>>>>>>>>>> fetching all form data $forms ");
      return forms;
    }

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

  static Future<bool> saveFormLocal(String formType, formData) {
    return saveValues(formType, formData);
  }

  static Future<bool> deleteFormLocal(String formType, int id) {
    return deleteValue(formType, id);
  }

  static getAllForms(String formType) {
    return getAllValues(formType);
  }

  // send form to server
  static Future<http.Response> postFormRemote(formData, String formEndpoint) {
    return postForm(formData, formEndpoint);
  }
}

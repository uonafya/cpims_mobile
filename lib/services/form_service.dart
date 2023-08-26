import 'package:cpims_mobile/Models/form_1_model.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/services/api_service.dart';
import 'package:http/http.dart' as http;

// save form to local storage
saveValues(String formType, formData) async {
//save the form data that is in the form of a map to  a local database
  final db = LocalDb.instance;
  try {
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
  final db = LocalDb.instance;
  try {
    await db.deleteForm1Data(formType, id);
    print(">>>>>>>>>>>>>>>>form deleted<<<<<<<<<<<<<<<<<");
    return true;
  } catch (e) {
    print(e);
  }
  return false;
}

// get all forms from local storage
getAllValues(String formType) async {
  final db = LocalDb.instance;
  try {
      List<Map<String, dynamic>> maps = await db.queryAllForm1Rows(formType);
      List<Form1DataModel> forms = [];
      for (var map in maps) {
        forms.add(Form1DataModel.fromJson(map));
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

  static Future<dynamic> saveFormLocal(String formType, formData) {
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

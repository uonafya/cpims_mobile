import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/model/health_model.dart';
import 'package:cpims_mobile/screens/cpara/model/safe_model.dart';
import 'package:cpims_mobile/screens/cpara/model/schooled_model.dart';
import 'package:cpims_mobile/screens/cpara/model/stable_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class CparaModel {
  final DetailModel detail;
  final SafeModel safe;
  final StableModel stable;
  final SchooledModel schooled;
  final HealthModel health;

  CparaModel({
    required this.detail,
    required this.safe,
    required this.stable,
    required this.schooled,
    required this.health,
  });

  factory CparaModel.fromJson(Map<String, dynamic> json) {
    return CparaModel(
      detail: DetailModel.fromJson(json['detail']),
      safe: SafeModel.fromJson(json['safe']),
      stable: StableModel.fromJson(json['stable']),
      schooled: SchooledModel.fromJson(json['schooled']),
      health: HealthModel.fromJson(json['health']),
    );
  }

  // This function add the portion of the form filled by the household to the database
  Future<void> addHouseholdFilledQuestionsToDB(Database? db, String houseHoldID,
      String formDate, String ovcpmsid, int formID) async {
    try {
      // Get JSON data from CPARA model
      Map<String, dynamic> json = {};
      var detailJSON = detail.toJSON();
      var healthJSON = health.toJSON();
      var safeJSON = safe.toJSON();
      var schooledJSON = schooled.toJSON();
      var stableJSON = stable.toJSON();

      // insert to database, for now debugPrint for testing
      print("Detail");
      print(detailJSON.toString());
      print("Health");
      print(healthJSON.toString());
      print("Safe");
      print(safeJSON.toString());
      print("Schooled");
      print(schooledJSON.toString());
      print("Stable");
      print(stableJSON.toString());

      // Merge all maps
      json.addAll(detailJSON);
      json.addAll(healthJSON);
      json.addAll(safeJSON);
      json.addAll(schooledJSON);
      json.addAll(stableJSON);
      print(json);

      // Send request
      // Create questions to send
      var questions = [];
      json.forEach((key, value) {
        questions.add({key: value});
      });

      // ovcpmisid is passed to function

      // date of event is passed to function

      var dateOfPreviousEvent =
          detail.dateOfLastAssessment ?? ""; // Date of previous event

      // Combine all parts
      var jsonToSend = {};
      jsonToSend['ovc_cpims_id'] = ovcpmsid;
      jsonToSend['date_of_event'] = formDate;
      jsonToSend['date_of_previous_event'] = dateOfPreviousEvent;
      jsonToSend['questions'] = questions;

      print("The Data Sent To The Server");
      print(jsonToSend.toString());
      print("Sending Data");

      // Send request later
      var prefs = await SharedPreferences.getInstance();
      var accessToken = prefs.getString('access');

      var response = await dio.request("https://dev.cpims.net/api/form/CPR/",
          data: jsonToSend,
          options: Options(
              method: 'POST',
              contentType: 'application/json',
              headers: {"Authorization": "Bearer $accessToken"}));

      print(response.statusCode);
      print(response.data.toString());

      // Insert database
      // Create a batch
      var batch = db!.batch();
      json.forEach((key, value) {
        batch.insert(
          "HouseholdAnswer",
          {
            "houseHoldID": houseHoldID,
            "questionID": key,
            "answer": value,
            "formID": formID
          },
        );
      });

      await batch.commit(noResult: true);
    } catch (err) {
      print("OHH SHIT!");
      print(err.toString());
      print("OHH SHIT!");
    }
  }

  // Create Form in database
  Future<void> createForm(Database? db) async {
    try {
      // Insert entry to db
      db!.insert("Form", {"date": DateTime.now().toString().split(' ')[0]});
    } catch (err) {
      print("OHH SHIT!");
      print(err.toString());
      print("OHH SHIT!");
    }
  }

  // Get latest form date
  Future<FormData> getLatestFormID(Database? db) async {
    try {
      List<Map<String, dynamic>> fetchResults = await db!
          .rawQuery("SELECT date, id FROM Form ORDER BY id DESC LIMIT 1");
      print("FetchResult is This");
      print(fetchResults.toString());
      DateTime formDate = DateTime.parse(fetchResults[0]['date']);
      int formID = fetchResults[0]['id'];
      return FormData(formID: formID, formDate: formDate);
    } catch (err) {
      print("OHH SHIT!");
      print(err.toString());
      print("OHH SHIT!");
      throw ("Get Latest ID error");
    }
  }
}

class FormData {
  final int formID;
  final DateTime formDate;

  const FormData({required this.formID, required this.formDate});
}

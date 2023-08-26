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
  final OvcSubPopulationModel? ovcSubPopulationModel;

  CparaModel({
    required this.detail,
    required this.safe,
    required this.stable,
    required this.schooled,
    required this.health,
    required this.ovcSubPopulationModel
  });

  factory CparaModel.fromJson(Map<String, dynamic> json) {
    return CparaModel(
      detail: DetailModel.fromJson(json['detail']),
      safe: SafeModel.fromJson(json['safe']),
      stable: StableModel.fromJson(json['stable']),
      schooled: SchooledModel.fromJson(json['schooled']),
      health: HealthModel.fromJson(json['health']),
      ovcSubPopulationModel: OvcSubPopulationModel.fromJson(json['ovcSubPopulationModel'])
    );
  }

  Future<void> addChildren(
      Database? db, List<List<Map<String, dynamic>>> data, int formID) async {
    try {
      // Create a batch
      var batch = await db!.batch();

      // Loop through all children
      for (var i in data) {
        // looping through the questions for each child
        for (var j in i) {
          // print('j is $j');
          j.forEach((key, value) {
            // print("j key is $key");
            // print("j's value key is ${value.keys.toList()[0]}");
            // print("j's value value is ${value.values.toList()[0]}");
            batch.insert("ChildAnswer", {
              "childID": key,
              "questionID": value.keys.toList()[0],
              "answer": value.values.toList()[0],
              "formID": formID
            });
          });

          await batch.commit(noResult: true);
        }
      }
    } catch (err) {
      print("OHH SHIT!");
      print(err.toString());
      print("OHH SHIT!");
    }
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
      var ovcSubPopulationModelJSON=ovcSubPopulationModel?.toJSON();

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
      print("OVC Sbpopulation");
      print(ovcSubPopulationModelJSON.toString());

      // Get children from safe and health
      // Health
      var healtChildren = healthJSON.remove('children');
      print("\nHealth Children\n");
      print(healtChildren.toString());

      // Safe
      var safeChildren = safeJSON.remove('children');
      print("\nSafe Children\n");
      print(safeChildren.toString());

      // Convert health children to a usable format
      List<List<Map<String, dynamic>>> usableHealthChildren = [];
      for (var i in healtChildren) {
        List<Map<String, dynamic>> tempList = [];
        var id = i['id'];
        i.forEach((key, val) {
          if (key != "id") {
            tempList.add({
              id: {key: val}
            });
          }
        });
        usableHealthChildren.add(tempList);
      }

      // Convert health children to a usable format
      List<List<Map<String, dynamic>>> usableSafeChildren = [];
      for (var i in safeChildren) {
        List<Map<String, dynamic>> tempList = [];
        var id = i['id'];
        i.forEach((key, val) {
          if (key != "id") {
            tempList.add({
              id: {key: val}
            });
          }
        });
        usableSafeChildren.add(tempList);
      }

      await addChildren(db, usableHealthChildren, formID);
      await addChildren(db, usableSafeChildren, formID);

      print("\nUsable Health Children\n");
      print(usableHealthChildren.toString());

      print("\nUsable Safe Children\n");
      print(usableSafeChildren.toString());

      // Merge all maps
      json.addAll(detailJSON);
      json.addAll(healthJSON);
      json.addAll(safeJSON);
      json.addAll(schooledJSON);
      json.addAll(stableJSON);
      json.addAll(ovcSubPopulationModelJSON!);
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
      print("Local Db Data start");
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

      print("Local Db Data end");
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

      // // Insert database
      // // Create a batch
      // var batch = db!.batch();
      // json.forEach((key, value) {
      //   batch.insert(
      //     "HouseholdAnswer",
      //     {
      //       "houseHoldID": houseHoldID,
      //       "questionID": key,
      //       "answer": value,
      //       "formID": formID
      //     },
      //   );
      // });
      //
      // await batch.commit(noResult: true);
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

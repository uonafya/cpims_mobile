import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/model/health_model.dart';
import 'package:cpims_mobile/screens/cpara/model/ovc_model.dart';
import 'package:cpims_mobile/screens/cpara/model/safe_model.dart';
import 'package:cpims_mobile/screens/cpara/model/schooled_model.dart';
import 'package:cpims_mobile/screens/cpara/model/stable_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import '../widgets/ovc_sub_population_form.dart';
import 'package:cpims_mobile/utils/app_form_metadata.dart';

final dio = Dio();

class CparaModel {
  final DetailModel detail;
  final SafeModel safe;
  final StableModel stable;
  final SchooledModel schooled;
  final HealthModel health;
  final CparaOvcSubPopulation ovcSubPopulations;
  final String uuid;
  final AppFormMetaData appFormMetaData;

  CparaModel({
    required this.detail,
    required this.safe,
    required this.stable,
    required this.schooled,
    required this.health,
    required this.ovcSubPopulations,
    this.uuid = "",
    this.appFormMetaData = const AppFormMetaData(),
    // required this.ovcSubPopulationModel
  });

  @override
  String toString() {
    return 'CparaModel {\n'
        '  detail: $detail,\n'
        '  safe: $safe,\n'
        '  stable: $stable,\n'
        '  schooled: $schooled,\n'
        '  health: $health,\n'
        '  appFormMetaData: $appFormMetaData, \n'
        '  uuid $uuid, \n'
        ' subpopulation: $ovcSubPopulations,\n'
        '}';
  }

  factory CparaModel.fromJson(Map<String, dynamic> json) {
    return CparaModel(
      detail: DetailModel.fromJson(json['detail']),
      safe: SafeModel.fromJson(json['safe']),
      stable: StableModel.fromJson(json['stable']),
      schooled: SchooledModel.fromJson(json['schooled']),
      health: HealthModel.fromJson(json['health']),
      ovcSubPopulations: json['ovc_subpopulation'],
      uuid: json['uuid'],
      appFormMetaData: AppFormMetaData.fromJson(json['appFormMetaData']),
    );
  }

  Future<void> addChildren(
      Database? db, List<List<Map<String, dynamic>>> data, int formID) async {
    try {
      // Create a batch
      var batch = db!.batch();

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
      if (kDebugMode) {
        print("Error adding children ${err.toString()}");
      }
    }
  }

  Future<void> addChildren2(
      List<Map<String, dynamic>> data, Database db, int formId) async {
    try {
      // Create a batch
      var batch = db.batch();
      for (Map i in data) {
        // getting data for each child

        i.forEach((key, value) {
          if (key != "id") {
            batch.insert("ChildAnswer", {
              "childID": i["id"],
              "questionID": key,
              "answer": value,
              "formID": formId
            });
          }
        });
        // Insert database
      }
      await batch.commit(noResult: true);
    } catch (err) {
      if (kDebugMode) {
        print("Error adding children ${err.toString()}");
      }
    }
  }

  // This function add the portion of the form filled by the household to the database
  Future<void> addHouseholdFilledQuestionsToDB(
      Database? db, String formDate, String ovcpmsid, int formID) async {
    try {
      // Get JSON data from CPARA model
      Map<String, dynamic> json = {};
      var detailJSON = detail.toJSON();
      var healthJSON = health.toJSON();
      var safeJSON = safe.toJSON();
      var schooledJSON = schooled.toJSON();
      var stableJSON = stable.toJSON();

      // Get children from safe and health
      // Health
      List<Map<String, dynamic>> healtChildren = healthJSON.remove('children');
      if (kDebugMode) {
        print("\nHealth Children\n");
      }
      if (kDebugMode) {
        print(healtChildren.toString());
      }

      // Safe
      List<Map<String, dynamic>> safeChildren = safeJSON.remove('children');
      if (kDebugMode) {
        print("\nSafe Children\n");
      }
      if (kDebugMode) {
        print(safeChildren.toString());
      }

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


      await addChildren2(healtChildren, db!, formID);
      await addChildren2(safeChildren, db, formID);

      // Merge all maps
      json.addAll(detailJSON);
      json.addAll(healthJSON);
      json.addAll(safeJSON);
      json.addAll(schooledJSON);
      json.addAll(stableJSON);

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

      // Insert database
      // Create a batch
      var batch = db.batch();
      json.forEach((key, value) {
        batch.insert(
          "HouseholdAnswer",
          {
            "houseHoldID": ovcpmsid,
            "questionID": key,
            "answer": value,
            "formID": formID
          },
        );
      });

      await batch.commit(noResult: true);
    } catch (err) {
      if (kDebugMode) {
        print(
            "Error adding household filled questions to db ${err.toString()}");
      }
    }
  }

  // Create Form in database
  Future<String> createForm(Database? db, String assessmentDate) async {
    try {
      String formUUID = const Uuid().v4();
      // Insert entry to db
      db!.insert("Form",
          {"date": assessmentDate, "uuid": formUUID});
      // db!.insert("Form",
      //     {"date": DateTime.now().toString().split(' ')[0], "uuid": formUUID});


      return formUUID;
    } catch (err) {
      if (kDebugMode) {
        print("Error creating form ${err.toString()}");
      }
      return "";
    }
  }

  // Get latest form date
  Future<FormData> getLatestFormID(Database? db) async {
    try {
      List<Map<String, dynamic>> fetchResults = await db!
          .rawQuery("SELECT date, id FROM Form ORDER BY id DESC LIMIT 1");
      if (kDebugMode) {
        print("FetchResult is This");
      }
      if (kDebugMode) {
        print(fetchResults.toString());
      }
      DateTime formDate = DateTime.parse(fetchResults[0]['date']);
      int formID = fetchResults[0]['id'];
      return FormData(formID: formID, formDate: formDate);
    } catch (err) {
      throw ("Error getting latest form date ${err.toString()}");
    }
  }
}

class FormData {
  final int formID;
  final DateTime formDate;

  const FormData({required this.formID, required this.formDate});
}

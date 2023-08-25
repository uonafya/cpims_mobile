import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/model/health_model.dart';
import 'package:cpims_mobile/screens/cpara/model/safe_model.dart';
import 'package:cpims_mobile/screens/cpara/model/schooled_model.dart';
import 'package:cpims_mobile/screens/cpara/model/stable_model.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<void> addHouseholdFilledQuestionsToDB(
      Database? db, String houseHoldID, int formID) async {
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
      db!.insert("Form", {"date": DateTime.now().toIso8601String()});
    } catch (err) {
      print("OHH SHIT!");
      print(err.toString());
      print("OHH SHIT!");
    }
  }

  // Get latest form ID
  Future<int> getLatestFormID(Database? db) async {
    try {
      List<Map<String, dynamic>> fetchResults =
          await db!.rawQuery("SELECT id FROM Form ORDER BY date DESC LIMIT 1");
      int formID = fetchResults[0]['id'];
      return formID;
    } catch (err) {
      print("OHH SHIT!");
      print(err.toString());
      print("OHH SHIT!");
      throw ("Get Latest ID error");
    }
  }
}

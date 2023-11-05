

import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/model/health_model.dart';
import 'package:cpims_mobile/screens/cpara/model/safe_model.dart';
import 'package:cpims_mobile/screens/cpara/model/schooled_model.dart';
import 'package:cpims_mobile/screens/cpara/model/stable_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dio/dio.dart';


final dio = Dio();

class CparaModel {
  final DetailModel detail;
  final SafeModel safe;
  final StableModel stable;
  final SchooledModel schooled;
  final HealthModel health;
  // final OvcSubPopulationModel? ovcSubPopulationModel;

  CparaModel({
    required this.detail,
    required this.safe,
    required this.stable,
    required this.schooled,
    required this.health,
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
        '}';
  }

  factory CparaModel.fromJson(Map<String, dynamic> json) {
    return CparaModel(
      detail: DetailModel.fromJson(json['detail']),
      safe: SafeModel.fromJson(json['safe']),
      stable: StableModel.fromJson(json['stable']),
      schooled: SchooledModel.fromJson(json['schooled']),
      health: HealthModel.fromJson(json['health']),
      // ovcSubPopulationModel: OvcSubPopulationModel.fromJson(json['ovcSubPopulationModel'])
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
      print("Error adding children ${err.toString()}");
    }
  }

  Future<void> addChildren2(List<Map<String, dynamic>> data, Database db, int formId) async{
    try {
      // Create a batch
      var batch = db.batch();
      for(Map i in data) {
        // getting data for each child

        i.forEach((key, value) {
          if(key != "id" ){
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
    }catch(err) {
      print("Error adding children ${err.toString()}");
    }
  }

  // This function add the portion of the form filled by the household to the database
  Future<void> addHouseholdFilledQuestionsToDB(Database? db,
      String formDate, String ovcpmsid, int formID) async {
    try {
      // Get JSON data from CPARA model
      Map<String, dynamic> json = {};
      var detailJSON = detail.toJSON();
      var healthJSON = health.toJSON();
      var safeJSON = safe.toJSON();
      var schooledJSON = schooled.toJSON();
      var stableJSON = stable.toJSON();
      // var ovcSubPopulationModelJSON=ovcSubPopulationModel?.toJSON();

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
      // print("OVC Sbpopulation");
      // print(ovcSubPopulationModelJSON.toString());

      // var h = healthJSON.remove('children');
      // var s = safeJSON.remove('children');
      // Get children from safe and health
      // Health
      List<Map<String, dynamic>> healtChildren = healthJSON.remove('children');
      print("\nHealth Children\n");
      print(healtChildren.toString());

      // Safe
      List<Map<String, dynamic>> safeChildren = safeJSON.remove('children');
      // List<Map<String, dynamic>> safeChildren = [{"id": "45", "q1": "ge"}];
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

      // await addChildren(db, usableHealthChildren, formID);
      // await addChildren(db, usableSafeChildren, formID);
      await addChildren2(healtChildren, db!, formID);
      await addChildren2(safeChildren, db, formID);

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
      // json.addAll(ovcSubPopulationModelJSON!);
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

       print("Local Db Data end KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");


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
      print("Error adding household filled questions to db ${err.toString()}");
    }
  }

  // Create Form in database
  Future<void> createForm(Database? db) async {
    try {
      // Insert entry to db
      db!.insert("Form", {"date": DateTime.now().toString().split(' ')[0]});
    } catch (err) {
      print("Error creating form ${err.toString()}");
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
      throw ("Error getting latest form date ${err.toString()}");
    }
  }

//   // submit to upstream
// Future<void> submitCparaToUpstream() async{
//   var prefs = await SharedPreferences.getInstance();
//   var accessToken = prefs.getString('access');
//   var savedUsername = prefs.getString('username');
//   var savedPassword = prefs.getString('password');
//
//   // Encode your username and password as Basic Auth credentials
//   String username = savedUsername ?? "";
//   String password = savedPassword ?? "";
//   String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
//   String bearerAuth = "Bearer $accessToken";
//
//
//   // local db initialization
//   Database database = await LocalDb.instance.database;
//   // cpara data from local db
//   List<CPARADatabase> cparaFormsInDb = await getUnsynchedForms(database);
//
//   for(CPARADatabase cparaForm in cparaFormsInDb){
//     try{
//       // submission
//       await singleCparaFormSubmission(cparaForm: cparaForm, authorization: basicAuth);
//       // remove from local db
//       // purgeForm(formID, database);
//     }
//         catch(e){
//           debugPrint("Cpara form with ovs cpims id : ${cparaForm.ovc_cpims_id} failed submission to upstream");
//       continue;
//         }
//   }
//
// }
//
// Future<void> singleCparaFormSubmission({required CPARADatabase cparaForm, required String authorization}) async {
//   Map<String, List<CPARAChildQuestions>> separatedChildren = {};
//
//   for (var child in cparaForm.childQuestions) {
//     if (!separatedChildren.containsKey(child.ovc_cpims_id)) {
//       separatedChildren[child.ovc_cpims_id] = [];
//     }
//     separatedChildren[child.ovc_cpims_id]!.add(child);
//   }
//
//   // Printing the separated children
//   separatedChildren.forEach((id, childrenList) {
//     print("Children with ID $id:");
//     for (var child in childrenList) {
//       print("  ${child.question_code} - ${child.answer_id}");
//     }
//   });
//
// // household questions
//   for(int i = 0; i < cparaForm.questions.length; i++){
//     debugPrint("Question ${cparaForm.questions[i].question_code} - ${cparaForm.questions[i].answer_id}");
//   }
//
//   // child questions
//   for(int i = 0; i < cparaForm.childQuestions.length; i++){
//     debugPrint("Child ID ${cparaForm.childQuestions[i].ovc_cpims_id}: ${cparaForm.childQuestions[i].question_code} - ${cparaForm.childQuestions[i].answer_id}");
//   }
//
//   // Child questions v2
//   for(int i = 0; i < separatedChildren.length; i++){
//     String childId = separatedChildren.keys.elementAt(i);
//     List<CPARAChildQuestions> data = separatedChildren[childId]!;
//     for(int i = 0; i < data.length; i++) {
//       debugPrint("Child ID $childId: ${data[i].question_code} - ${data[i].answer_id}");
//     }
//   }
//
//   // scores value
//   String b1 = benchMarkOneScoreFromDb(cparaDatabase: cparaForm);
//   String b2 = benchMarkTwoScoreFromDb(cparaDatabase: cparaForm);
//     String b3 = benchMarkThreeScoreFromDb(cparaDatabase: cparaForm);
//   String b4 = benchMarkFourScoreFromDb(cparaDatabase: cparaForm);
//   String b5 = benchMarkFiveScoreFromDb(cparaDatabase: cparaForm);
//   String b6 = benchMarkSixScoreFromDb(cparaDatabase: cparaForm);
//   String b7 = benchMarkSevenScoreFromDb(cparaDatabase: cparaForm);
//   String b8 =  benchMarkEightScoreFromDb(cparaDatabase: cparaForm);
//    String b9 = benchMarkNineScoreFromDb(cparaDatabase: cparaForm);
//
//     var cparaMapData = {};
//     // var response = await dio.request("https://dev.cpims.net/api/form/CPR/",
//     //     data: cparaMapData,
//     //     options: Options(
//     //         method: 'POST',
//     //         contentType: 'application/json',
//     //         headers: {"Authorization": "Bearer $accessToken"}));
//       var response = await dio.post("https://dev.cpims.net/api/form/CPR/",
//           data: cparaMapData,
//           options: Options(
//               contentType: 'application/json',
//               headers: {"Authorization": authorization}));
//
//       if(response.statusCode != 200){
//         throw ("Submission to upstream failed");
//       }
//       debugPrint("${response.statusCode}");
//       debugPrint(response.data.toString());
// }
}

class FormData {
  final int formID;
  final DateTime formDate;

  const FormData({required this.formID, required this.formDate});
}

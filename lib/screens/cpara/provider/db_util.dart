import 'dart:convert';

import 'package:cpims_mobile/screens/cpara/cpara_util.dart';
import 'package:cpims_mobile/screens/cpara/model/db_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../../providers/db_provider.dart';
import '../model/cpara_model.dart';
import '../widgets/cpara_stable_widget.dart';

Future<List<CPARADatabase>> getUnsynchedForms(Database db) async {
  try {
    List<CPARADatabase> forms = [];
    List<Map<String, dynamic>> formsFetchResult =
    await db.rawQuery("SELECT id FROM Form WHERE id IN (SELECT formID FROM HouseholdAnswer)");
    for (var i in formsFetchResult) {
      var form = await getFormFromDB(i['id'], db);
      forms.add(form);
    }
    return forms;
  } catch (err) {
   throw ("Could Not Get Unsynced Forms ${err.toString()}");
    print(err.toString());
  }
}

Future<int> getUnsyncedCparaFormsCount(Database db) async {
  try {
    List<Map<String, dynamic>> countResult = await db.rawQuery(
        "SELECT COUNT(id) AS count FROM Form WHERE id IN (SELECT formID FROM HouseholdAnswer)");

    if (countResult.isNotEmpty) {
      int count = countResult[0]['count'];
      return count;
    } else {
      return 0; // Return 0 if there are no unsynced forms
    }
  } catch (err) {
    throw ("Could Not Get Unsynced Forms Count: ${err.toString()}");
  }
}


Future<CPARADatabase> getFormFromDB(int formID, Database? db) async {
  try {
    CPARADatabase form = CPARADatabase();
    // Get ovpmsid, dateofevent and questions
    // List<Map<String, dynamic>> fetchResult1 = await db!.rawQuery(
    //     "SELECT householdid, date, questionid, answer FROM HouseholdAnswer INNER JOIN Form ON Form.id = HouseholdAnswer.formID");

    List<Map<String, dynamic>> fetchResult1 = await db!.rawQuery(
        "SELECT formID, householdid, date, questionid, answer "
            "FROM HouseholdAnswer "
            "INNER JOIN Form ON Form.id = HouseholdAnswer.formID "
            "WHERE formID =  $formID");

form.cpara_form_id = formID;
    var ovcpmisID = fetchResult1[0]['houseHoldID'];
    form.ovc_cpims_id = ovcpmisID;
    print("OVCPMIS ID from many: $ovcpmisID");
    var dateOfEvent2 = fetchResult1[0]['date'];
    form.date_of_event = dateOfEvent2;
    print("Date of event from many: $dateOfEvent2");
    List<CPARADatabaseQuestions> questions = [];
    for (var i in fetchResult1) {
      questions.add(CPARADatabaseQuestions(
          question_code: i['questionID'], answer_id: i['answer'] ?? ""));
    }
    form.questions = questions;
    print("Questions from many: $questions");

    // Get children questions
    List<Map<String, dynamic>> fetchResult2 = await db!.rawQuery(
        "SELECT questionid, answer, childid FROM ChildAnswer WHERE formid = ?",
        [formID]);
    List<CPARAChildQuestions> childQuestions = [];
    for (var i in fetchResult2) {
      childQuestions.add(CPARAChildQuestions.fromJSON(i));
    }


    form.childQuestions = childQuestions;
    return form;
  } catch (err) {
    throw ("Could Not Get Form From DB ${err.toString()}");
  }
}

Future<void> purgeForm(int formID, Database db) async {
  try {
    // Delete householdanswers
    await db
        .rawDelete("DELETE FROM HouseholdAnswer WHERE formID = ?", [formID]);

    // Delete childanswers
    await db.rawDelete("DELETE FROM ChildAnswer WHERE formID = ?", [formID]);

    // Form
    await db.rawDelete("DELETE FROM Form WHERE id = ?", [formID]);
  } catch (err) {}
}

//update form date time for sync
Future<void> updateFormDateSynced(int formID, Database db) async {
  try {
    // Get the current date and time
    DateTime now = DateTime.now();

    // Update "date_synced" for the "Form" table
    await db.rawUpdate(
        "UPDATE Form SET form_date_synced = ? WHERE id = ?",
        [now.toUtc().toIso8601String(), formID]);

    // // Update "date_synced" for the "HouseholdAnswer" table
    // await db.rawUpdate(
    //     "UPDATE HouseholdAnswer SET form_date_synced = ? WHERE formID = ?",
    //     [now.toUtc().toIso8601String(), formID]);
    //
    // // Update "date_synced" for the "ChildAnswer" table
    // await db.rawUpdate(
    //     "UPDATE ChildAnswer SET form_date_synced = ? WHERE formID = ?",
    //     [now.toUtc().toIso8601String(), formID]);

  } catch (err) {
    // Handle any errors that may occur during the updates
    print("Error updating date_synced: $err");
  }
}

Future<int> getUnsyncedFormCount(Database db) async {
  try {
    const query = "SELECT COUNT(*) FROM Form WHERE date_synced IS NULL";
    final result = await db.rawQuery(query);
    return result.first[0] as int;
  } catch (err) {
    debugPrint("Error getting unsynced form count: $err");
    return 0;
  }
}


// Returns the number of CPARA forms
Future<int> getCountOfForms(Database? db) async {
  try {
    // Run query to get count of unique forms
    List<Map<String, dynamic>> fetchResults =
    await db!.rawQuery("SELECT COUNT(*) total FROM Form");
    // Return value
    int total = fetchResults[0]['total'];
    return total;
  } catch (err) {
    print(err.toString());
    throw ("Could Not Get Count ${err.toString()}");
  }
}

// submit to upstream
Future<void> submitCparaToUpstream() async{
  var prefs = await SharedPreferences.getInstance();
  var accessToken = prefs.getString('access');
  var savedUsername = prefs.getString('username');
  var savedPassword = prefs.getString('password');

  // Encode your username and password as Basic Auth credentials
  String username = savedUsername ?? "";
  String password = savedPassword ?? "";
  String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  String bearerAuth = "Bearer $accessToken";


  // local db initialization
  Database database = await LocalDb.instance.database;
  // cpara data from local db
  List<CPARADatabase> cparaFormsInDb = await getUnsynchedForms(database);

  for(CPARADatabase cparaForm in cparaFormsInDb){
    try{
      // submission
      await singleCparaFormSubmission(cparaForm: cparaForm, authorization: bearerAuth);
      // remove from local db
      // purgeForm(cparaForm.cpara_form_id, database);
      updateFormDateSynced(cparaForm.cpara_form_id, database);
      print("Unscynced forms are ${await getUnsyncedCparaFormsCount(database)}");

      
    }
    catch(e){
      debugPrint("Cpara form with ovs cpims id : ${cparaForm.ovc_cpims_id} failed submission to upstream");
      continue;
    }
  }
}

Future<void> singleCparaFormSubmission({required CPARADatabase cparaForm, required String authorization}) async {

// household questions
  final houseHoldQuestions = [];
  for(int i = 0; i < cparaForm.questions.length; i++){
    houseHoldQuestions.add({
      "question_code": convertQuestionIdsStandardFormat(text: cparaForm.questions[i].question_code),
      "answer_id": convertOptionStandardFormat(text: cparaForm.questions[i].answer_id),
    });
    debugPrint("Household ${cparaForm.questions[i].question_code} - ${cparaForm.questions[i].answer_id}");
  }

  // child questions
  final individualQuestions = [];
  for(int i = 0; i < cparaForm.childQuestions.length; i++){
    individualQuestions.add({
      "ovc_cpims_id": cparaForm.childQuestions[i].ovc_cpims_id,
      "question_code": convertQuestionIdsStandardFormat(text: cparaForm.childQuestions[i].question_code),
      "answer_id": convertOptionStandardFormat(text: cparaForm.childQuestions[i].answer_id),
    });
    debugPrint("Child ${cparaForm.childQuestions[i].ovc_cpims_id}: "
        "${cparaForm.childQuestions[i].question_code} - ${cparaForm.childQuestions[i].answer_id}");
  }

  // scores value
  String b1 = benchMarkOneScoreFromDb(cparaDatabase: cparaForm);
  String b2 = benchMarkTwoScoreFromDb(cparaDatabase: cparaForm);
  String b3 = benchMarkThreeScoreFromDb(cparaDatabase: cparaForm);
  String b4 = benchMarkFourScoreFromDb(cparaDatabase: cparaForm);
  String b5 = benchMarkFiveScoreFromDb(cparaDatabase: cparaForm);
  String b6 = benchMarkSixScoreFromDb(cparaDatabase: cparaForm);
  String b7 = benchMarkSevenScoreFromDb(cparaDatabase: cparaForm);
  String b8 =  benchMarkEightScoreFromDb(cparaDatabase: cparaForm);
  String b9 = benchMarkNineScoreFromDb(cparaDatabase: cparaForm);
  List<String> scores = [b1, b2, b3, b4, b5, b6, b7, b8, b9];

  final scoreList = [];
  for(int i = 0; i < scores.length; i++){
    scoreList.add({
      "b${i + 1}": "${scoreConversion(text: scores[i])}",
    });
  }

  var cparaMapData = {
    "ovc_cpims_id": cparaForm.ovc_cpims_id,
    "date_of_event": cparaForm.date_of_event,
    "questions": houseHoldQuestions,
    "individual_questions": individualQuestions,
    "scores": scoreList,
  };
  debugPrint(json.encode(cparaMapData));
  String cparaJsonData= json.encode(cparaMapData);
  print("Cpara data is $cparaJsonData");

  dio.interceptors.add(LogInterceptor());
  var response = await dio.post("https://dev.cpims.net/api/form/CPR/",
      data: cparaMapData,
      options: Options(
          contentType: 'application/json',
          headers: {"Authorization": authorization}));

  if(response.statusCode != 200){
    throw ("Submission to upstream failed");
  }
  debugPrint("${response.statusCode}");
  debugPrint(response.data.toString());
}

void fetchAndPostToServerOvcSubpopulationData() async {
  // Call the fetchOvcSubPopulationData function to get the result
  List<Map<String, dynamic>> result = await fetchOvcSubPopulationData();
  print("The result is $result");

  List<Map<String, dynamic>> ovcSubPopulationList = [];
  for (var row in result) {
    ovcSubPopulationList.add({
      // Map the row data to your desired structure
      'id': row['id'],
      'uuid': row['uuid'],
      'cpims_id': row['cpims_id'],
      'criteria': row['criteria'],
      'date_of_event': row['date_of_event'],
      'created_at': row['created_at'],
    });
  }
  var ovcPostToServer = {
    "ovc_subpopulation": ovcSubPopulationList,
  };
  print("The ovc posted to server is $ovcPostToServer");
  await postOvcToServer(ovcPostToServer);
}

Future<List<Map<String, dynamic>>> fetchOvcSubPopulationData() async {
  final db = await LocalDb.instance.database;
  final result = await db.query(ovcsubpopulation);
  return result;
}

Future<void> postOvcToServer(Map<String, dynamic> data) async {
  var prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');
  String? password = prefs.getString('password');
  String basicAuth =
      'Basic ${base64Encode(utf8.encode('$username:$password'))}';

  try {
    final response = await dio.post(
      'https://dev.cpims.net/api/form/CPR/',
      data: data, // Pass the data directly as the request body
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth, // Add Basic Auth header
        },
      ),
    );
    if (response.statusCode == 200) {
      print('Data posted to server successfully');
    } else {
      print(
          'Failed to post data to server. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error posting data to server: $e');
  }
}
//
// Future<void> submitOvcSubPopultaionForm async(){
//
//
//
// }

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
//     debugPrint("Children with ID $id:");
//     for (var child in childrenList) {
//       debugPrint("  ${child.question_code} - ${child.answer_id}");
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
//     debugPrint("Child ID raw ${cparaForm.childQuestions[i].ovc_cpims_id}: "
//         "${cparaForm.childQuestions[i].question_code} - ${cparaForm.childQuestions[i].answer_id}");
//   }
//
//   // Child questions v2
//   for(int i = 0; i < separatedChildren.length; i++){
//     String childId = separatedChildren.keys.elementAt(i);
//     List<CPARAChildQuestions> data = separatedChildren[childId]!;
//     for(int i = 0; i < data.length; i++) {
//       debugPrint("Child ID v2 $childId: ${data[i].question_code} - ${data[i].answer_id}");
//     }
//   }
//
//   // scores value
//   String b1 = benchMarkOneScoreFromDb(cparaDatabase: cparaForm);
//   String b2 = benchMarkTwoScoreFromDb(cparaDatabase: cparaForm);
//   String b3 = benchMarkThreeScoreFromDb(cparaDatabase: cparaForm);
//   String b4 = benchMarkFourScoreFromDb(cparaDatabase: cparaForm);
//   String b5 = benchMarkFiveScoreFromDb(cparaDatabase: cparaForm);
//   String b6 = benchMarkSixScoreFromDb(cparaDatabase: cparaForm);
//   String b7 = benchMarkSevenScoreFromDb(cparaDatabase: cparaForm);
//   String b8 =  benchMarkEightScoreFromDb(cparaDatabase: cparaForm);
//   String b9 = benchMarkNineScoreFromDb(cparaDatabase: cparaForm);
//   List<String> scores = [b1, b2, b3, b4, b5, b6, b7, b8, b9];
//
//   final houseHoldQuestions = [];
//   for(int i = 0; i < scores.length; i++){
//     houseHoldQuestions.add({
//       "question_code": convertQuestionIdsStandardFormat(text: scores[i]),
//       "answer_id": convertOptionStandardFormat(text: scores[i]),
//     });
//   }
//
//   final individualQuestions = [];
//   for(int i = 0; i < scores.length; i++){
//     individualQuestions.add({
//       "ovc_cpims_id": separatedChildren.keys.elementAt(i),
//       "question_code": convertQuestionIdsStandardFormat(text: scores[i]),
//       "answer_id": convertOptionStandardFormat(text: scores[i]),
//     });
//   }
//
//   final scoreList = [];
//   for(int i = 0; i < scores.length; i++){
//     scoreList.add({
//       "b${i + 1}": "${scoreConversion(text: scores[i])}",
//     });
//   }
//
//   var cparaMapData = {
//     "ovc_cpims_id": cparaForm.ovc_cpims_id,
//     "date_of_event": cparaForm.date_of_event,
//     "questions": houseHoldQuestions,
//     "individual_questions": individualQuestions,
//     "scores": scoreList,
//   };
//   // var response = await dio.request("https://dev.cpims.net/api/form/CPR/",
//   //     data: cparaMapData,
//   //     options: Options(
//   //         method: 'POST',
//   //         contentType: 'application/json',
//   //         headers: {"Authorization": "Bearer $accessToken"}));
//   var response = await dio.post("https://dev.cpims.net/api/form/CPR/",
//       data: cparaMapData,
//       options: Options(
//           contentType: 'application/json',
//           headers: {"Authorization": authorization}));
//
//   if(response.statusCode != 200){
//     throw ("Submission to upstream failed");
//   }
//   debugPrint("${response.statusCode}");
//   debugPrint(response.data.toString());
// }

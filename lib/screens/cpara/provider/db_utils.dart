import 'package:cpims_mobile/screens/cpara/model/cpara_db_models.dart';
import 'package:sqflite/sqflite.dart';

Future<List<CPARADatabase>> getUnsynchedForms(Database db) async {
  try {
    List<CPARADatabase> forms = [];
    List<Map<String, dynamic>> formsFetchResult =
    await db.rawQuery("SELECT id FROM Form");
    for (var i in formsFetchResult) {
      var form = await getFormFromDB(i['id'], db);
      forms.add(form);
    }
    return forms;
  } catch (err) {
    print("OHH SHIT!");
    print(err.toString());
    print("OHH SHIT!");
    throw ("Could Not Get Unsynced Forms");
  }
}

Future<CPARADatabase> getFormFromDB(int formID, Database? db) async {
  try {
    CPARADatabase form = CPARADatabase();
    // Get ovpmsid, dateofevent and questions
    List<Map<String, dynamic>> fetchResult1 = await db!.rawQuery(
        "SELECT householdid, date, questionid, answer FROM HouseholdAnswer INNER JOIN Form ON Form.id = HouseholdAnswer.formID");

    var ovcpmisID = fetchResult1[0]['householdid'];
    form.ovc_cpims_id = ovcpmisID;
    print("OVCPMIS ID from many: $ovcpmisID");
    var dateOfEvent2 = fetchResult1[0]['date'];
    form.date_of_event = dateOfEvent2;
    print("Date of event from many: $dateOfEvent2");
    List<CPARADatabaseQuestions> questions = [];
    for (var i in fetchResult1) {
      questions.add(CPARADatabaseQuestions(
          question_code: i['questionid'], answer_id: i['answer']));
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
    print("OHH SHIT!");
    print(err.toString());
    print("OHH SHIT!");
    throw ("Could Not Get Form");
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
    await db.rawDelete("DELTE FROM Form WHERE id = ?", [formID]);
  } catch (err) {}
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
    print("OHH SHIT!");
    print(err.toString());
    print("OHH SHIT!");
    throw ("Could Not Get Count");
  }
}
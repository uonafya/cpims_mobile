import 'package:cpims_mobile/providers/cpara/unapproved_cpara_database.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/model/health_model.dart';
import 'package:cpims_mobile/screens/cpara/model/ovc_model.dart';
import 'package:cpims_mobile/screens/cpara/model/safe_model.dart';
import 'package:cpims_mobile/screens/cpara/model/schooled_model.dart';
import 'package:cpims_mobile/screens/cpara/model/stable_model.dart';
import 'package:cpims_mobile/utils/app_form_metadata.dart';

import 'fill_cpara_records_from_questions.dart';

Future<List> fetchUnapprovedCparaForms() async{
  try {
    var db = await LocalDb.instance.database;

    // Get all forms in UnapprovedCparaTable
    List<Map<String, dynamic>> formsFetchResult = await db.rawQuery(
        "SELECT id, date_of_event, message, ovc_id FROM UnapprovedCPARA");

    return formsFetchResult;
  } catch(err) {
    print(err.toString());
    throw "Could Not Get Unapproved Cpara Forms";
  }
}

Future<UnapprovedCparaModel> getUnaprovedCparaFromDb(String formID, String message, String cpms_id, String date_of_event) async{
  // Create an empty instance of UnapprovedCpara
  var unaprovedToReturn = UnapprovedCparaModel(
      appFormMetaData: AppFormMetaData(),
      detail: DetailModel(
        dateOfAssessment: date_of_event
      ),
      health: HealthModel(),
      ovcSubPopulations: CparaOvcSubPopulation(),
      safe: SafeModel(),
      schooled: SchooledModel(),
      stable: StableModel(),
      uuid: formID,
      message: message,
      cpmis_id: cpms_id
  );

  var db = await LocalDb.instance.database;

  // Get all questions from forms
  List<Map<String, dynamic>> formsFetchResult = await db.rawQuery(
      "SELECT question_code, answer_id, ovc_cpims_id FROM UnapprovedCPARAAnswers WHERE form_id = ?", [formID]);

  unaprovedToReturn = fillCparaFromQuestions(unaprovedToReturn, cpms_id, formsFetchResult);
  return unaprovedToReturn;
}


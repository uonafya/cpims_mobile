import 'package:cpims_mobile/providers/cpara/read_unapproved_cpara_from_db.dart';
import 'package:cpims_mobile/providers/cpara/unapproved_cpara_database.dart';
import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/model/health_model.dart';
import 'package:cpims_mobile/screens/cpara/model/ovc_model.dart';
import 'package:cpims_mobile/screens/cpara/model/safe_model.dart';
import 'package:cpims_mobile/screens/cpara/model/schooled_model.dart';
import 'package:cpims_mobile/screens/cpara/model/stable_model.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_safe_widget.dart';
import 'package:cpims_mobile/services/unapproved_data_service.dart';
import 'package:cpims_mobile/utils/app_form_metadata.dart';
import 'package:uuid/uuid.dart';

import '../db_provider.dart';

class UnapprovedCparaService {
  static Future<void> storeInDB(UnapprovedCparaModel model) async {
    // Get instance of local db
    var db = LocalDb.instance;
    try {
      // Store metadata
      db.insertUnapprovedAppFormMetaData(
          model.uuid, model.appFormMetaData, 'cpara');

      Map<String, dynamic> json = {};
      List questions = [];

      // Get questions from health
      // Convert health to JSON
      var healthJSON = model.health.toJSON();
      // Remove health children
      var healtChildren = healthJSON.remove('children');

      // Get questions from detail
      var detailJSON = model.detail.toJSON();

      // Get questions from ovc subpopulation
      for (CparaOvcChild child
          in model.ovcSubPopulations.childrenQuestions ?? []) {
        var subpopulationquestions = _cparaovcchildtojson(child, model.uuid);
        questions.addAll(subpopulationquestions);
      }

      // Get questions from safe
      var safeJSON = model.safe.toJSON();
      List<Map<String, dynamic>> safeChildren = safeJSON.remove('children');

      // Get questions from schooled
      var schooledJSON = model.schooled.toJSON();

      // Get questions from stable
      var stableJSON = model.stable.toJSON();

      json.addAll(healthJSON);
      json.addAll(detailJSON);
      json.addAll(safeJSON);
      json.addAll(schooledJSON);
      json.addAll(stableJSON);

      // Loop through keys of JSON and and add to questions list
      json.forEach((key, value) {
        questions.add({
          "question_code": key,
          "answer_id": value,
          "ovc_cpims_id": model.cpmis_id,
          "form_id": model.uuid
        });
      });

      // Add health children
      for (Map i in healtChildren) {
        var jsonToAdd = {'form_id': model.uuid};
        // Go through every question
        i.forEach((key, value) {
          if (key != "id") {
            jsonToAdd['question_code'] = key;
            jsonToAdd['answer_id'] = value;
            jsonToAdd['ovc_cpims_id'] = i['id'];

            questions.add(jsonToAdd);
          }
        });
      }

      // Add safe children
      for (Map i in safeChildren) {
        var jsonToAdd = {'form_id': model.uuid};
        // Go through every question
        i.forEach((key, value) {
          if (key != "id") {
            jsonToAdd['question_code'] = key;
            jsonToAdd['answer_id'] = value;
            jsonToAdd['ovc_cpims_id'] = i['id'];

            questions.add(jsonToAdd);
          }
        });
      }

      // Add CPARA form
      var uuid = Uuid();
      var formID = uuid.v4();
      model.uuid = formID;
      var datab = await db.database;
      datab.insert("UnapprovedCPARA", {
        "id": model.uuid,
        "date_of_event": model.detail.dateOfAssessment,
        "message": model.message,
        "ovc_id": model.cpmis_id,
      });

      // Add questions to DB
      var batch = datab.batch();
      for (Map question in questions) {
        batch.insert("UnapprovedCPARAAnswers", {
          "question_code": question['question_code'],
          "answer_id": question['answer_id'],
          "ovc_cpims_id": question['ovc_cpims_id'],
          "form_id": model.uuid
        });
      }
      await batch.commit(noResult: true);

    } catch (err) {
      print(err.toString());
      throw (cannot_store_unapproved_cpara);
    }
  }

  static deleteUnapprovedCparaForm(String formID) async{
    try {
      var db = await LocalDb.instance.database;

      // Delete CPARA table
      db.rawQuery(
        "DELETE FROM UnapprovedCPARA WHERE id = ?", [formID]
      );

      // Delete entries for unapproved table
      db.rawQuery(
        "DELETE FROM UnapprovedCPARAAnswers WHERE form_id = ? ", [formID]
      );
    } catch(err) {
      print(err.toString());
      throw "Could Not Delete Unapproved CPARA";
    }
  }

  static Future<List<UnapprovedCparaModel>> getUnapprovedFromDB() async{
    var unapprovedForms = await fetchUnapprovedCparaForms();
    List<UnapprovedCparaModel> formsToBeReturned = [];

    for (Map i in unapprovedForms) {
      formsToBeReturned.add(
        await getUnaprovedCparaFromDb(i['id'] ?? "", i['message'] ?? "", i['ovc_id'] ?? "", i['date_of_event'] ?? "")
      );
    }
    print(formsToBeReturned);
    return formsToBeReturned;
  }

  static List _cparaovcchildtojson(CparaOvcChild child, String form_id) {
    // For each question return entry
    var entries = [];
    var baseJSON = {"ovc_cpims_id": child.ovcId, "form_id": form_id};

    if (child.question1 != null) {
      var question1 = baseJSON;
      question1.addAll({"question_code": "ovc_q1"});
      question1.addAll({"answer_id": child.question1});
      entries.add(question1);
    }

    if (child.question2 != null) {
      var question2 = {"ovc_cpims_id": child.ovcId, "form_id": form_id};
      question2.addAll({"question_code": "ovc_q2"});
      question2.addAll({"answer_id": child.question2});
      entries.add(question2);
    }

    if (child.question3 != null) {
      var question3 = {"ovc_cpims_id": child.ovcId, "form_id": form_id};
      question3.addAll({"question_code": "ovc_q3"});
      question3.addAll({"answer_id": child.question3});
      entries.add(question3);
    }

    if (child.question4 != null) {
      var question4 = {"ovc_cpims_id": child.ovcId, "form_id": form_id};
      question4.addAll({"question_code": "ovc_q4"});
      question4.addAll({"answer_id": child.question4});
      entries.add(question4);
    }

    if (child.question5 != null) {
      var question5 = {"ovc_cpims_id": child.ovcId, "form_id": form_id};
      question5.addAll({"question_code": "ovc_q5"});
      question5.addAll({"answer_id": child.question5});
      entries.add(question5);
    }

    if (child.question6 != null) {
      var question6 = {"ovc_cpims_id": child.ovcId, "form_id": form_id};
      question6.addAll({"question_code": "ovc_q6"});
      question6.addAll({"answer_id": child.question6});
      entries.add(question6);
    }

    if (child.question7 != null) {
      var question7 = {"ovc_cpims_id": child.ovcId, "form_id": form_id};
      question7.addAll({"question_code": "ovc_q7"});
      question7.addAll({"answer_id": child.question7});
      entries.add(question7);
    }

    if (child.question8 != null) {
      var question8 = {"ovc_cpims_id": child.ovcId, "form_id": form_id};
      question8.addAll({"question_code": "ovc_q8"});
      question8.addAll({"answer_id": child.question8});
      entries.add(question8);
    }

    return entries;
  }
}

var testModel = UnapprovedCparaModel(
    cpmis_id: "3799369",
    appFormMetaData: AppFormMetaData(
        formId: '1',
        location_lat: '1',
        location_long: '1',
        startOfInterview: DateTime.now().toIso8601String(),
        endOfInterview: DateTime.now().toIso8601String(),
        formType: 'CPARA'),
    detail: DetailModel(
        isChildHeaded: "Yes",
        isFirstAssessment: "Yes",
        hasHivExposedInfant: "Yes",
        dateOfAssessment: DateTime.now().toIso8601String(),
        hasPregnantOrBreastfeedingWoman: "Yes"),
    health: HealthModel(
        question1: "Yes",
        question2: "Yes",
        question3: "Yes",
        question4: "Yes",
        childrenQuestions: [
          HealthChild(
              name: "B",
              id: '4027465',
              question1: 'yes',
              question2: 'yes',
              question3: 'yes'),
          HealthChild(
              name: "C",
              id: '3799369',
              question1: 'yes',
              question2: 'yes',
              question3: 'yes'),
          HealthChild(
              name: "A",
              id: '4027475',
              question1: 'yes',
              question2: 'yes',
              question3: 'yes')
        ]),
    ovcSubPopulations: CparaOvcSubPopulation(childrenQuestions: [
      CparaOvcChild(
          name: "Y",
          ovcId: "4027475",
          question6: "",
          question7: '',
          question8: ''),
      CparaOvcChild(
          name: "Y",
          ovcId: "3799369",
          question4: "yes",
          question3: "yes",
          question2: "Yes",
          question1: "yes",
          question5: "yes",
          question6: "yes",
          question7: 'yes',
          question8: 'yes')
    ]),
    safe: SafeModel(
        question1: 'yes',
        question2: 'yes',
        question3: 'yes',
        childrenQuestions: [
          SafeChild(ovcId: '3799369', name: 'E', question1: 'yes'),
          SafeChild(ovcId: '4027465', name: 'B', question1: 'yes'),
          SafeChild(ovcId: '4027475', name: 'X', question1: 'yes'),
        ]),
    schooled: SchooledModel(
        mainquestion1: 'yes',
        question3: 'yes',
        question2: 'yes',
        question1: 'yes'),
    stable: StableModel(question2: 'yes', question1: 'yes', question3: 'yes'),
    uuid: '1',
    message: "Some shit went down",
);

final unapprovedcparaserviceconstructor = UnapprovedCparaService();

import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_current_status_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_risk_assessment_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/progress_monitoring_form.dart';
import 'package:cpims_mobile/services/api_service.dart';
import 'package:cpims_mobile/utils/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../forms/hiv_assessment/unapproved/hiv_risk_assessment_form_model.dart';

class HIVAssessmentProvider with ChangeNotifier {
  CaseLoadModel _caseLoadModel = CaseLoadModel();

  CaseLoadModel get caseLoadModel => _caseLoadModel;


  RiskAssessmentFormModel _riskAssessmentFormModel = RiskAssessmentFormModel();

  RiskAssessmentFormModel get riskAssessmentFormModel =>
      _riskAssessmentFormModel;

  int formIndex = 0;

  int ovcAge = 0;

  String finalEvaluation = "No";

  void updateOvcAge(int age) {
    ovcAge = age;
    notifyListeners();
  }

  //clear ovc age
  void clearOvcAge() {
    ovcAge = 0;
    notifyListeners();
  }

  void updateFormIndex(int index) {
    formIndex = index;
    notifyListeners();
  }

  void updateCaseLoadModel(CaseLoadModel model) {
    _caseLoadModel = model;
    notifyListeners();
  }

  // void updateHIVCurrentStatusModel(HIVCurrentStatusModel model) {
  //   _hivCurrentStatusModel = model;
  //   // if (_hivCurrentStatusModel.hivStatus == "HIV_Positive" &&
  //   //     _hivCurrentStatusModel.dateOfAssessment.isNotEmpty) {
  //   //   updateFormIndex(2);
  //   // }
  //   if (kDebugMode) {
  //     print(hivCurrentStatusModel.toJson());
  //   }
  //   notifyListeners();
  // }
  //
  // void updateHIVRiskAssessmentModel(HIVRiskAssessmentModel model) {
  //   _hivRiskAssessmentModel = model;
  //   calculateFinalEvaluation();
  //   if (kDebugMode) {
  //     print(hivRiskAssessmentModel.toJson());
  //   }
  //   notifyListeners();
  // }
  //
  // void updateProgressMonitoringModel(ProgressMonitoringModel model) {
  //   _progressMonitoringModel = model;
  //   if (kDebugMode) {
  //     print(progressMonitoringModel.toJson());
  //   }
  //   notifyListeners();
  // }

  void updateRiskAssessmentModel(RiskAssessmentFormModel model) {
    _riskAssessmentFormModel = model;
    calculateFinalEvaluation();
    if (kDebugMode) {
      print(riskAssessmentFormModel.toJson());
    }
    notifyListeners();
  }

  Future<void> submitHIVAssessmentForm(String startTime) async {
    try {
      final data = {
        'ovc_cpims_id': caseLoadModel.cpimsId,
        ...riskAssessmentFormModel.toJson(),
      };

      // Convert "Yes" to "AYES" and "No" to "ANO"
      data.forEach((key, value) {
        if (value is String) {
          if (value.toLowerCase() == 'yes') {
            data[key] = 'AYES';
          } else if (value.toLowerCase() == 'no') {
            data[key] = 'ANNO';
          }
        }
      });

      debugPrint("HIV Assessment Data: $data");

      String formUuid = const Uuid().v4();
      await LocalDb.instance.insertHRSData(
          caseLoadModel.cpimsId!,
          caseLoadModel.caregiverCpimsId!,
          _riskAssessmentFormModel,
          formUuid,
          startTime,
          "HIV Risk Assessment",
          false
      );

      resetWholeForm();
    } catch (e) {
      rethrow;
    }
  }

  void resetWholeForm() {
    _riskAssessmentFormModel = RiskAssessmentFormModel();
    formIndex = 0;
    ovcAge = 0;
    finalEvaluation = "No";

    notifyListeners();
  }

  void calculateFinalEvaluation() {
    bool finalEvaluation = false;

    if (ovcAge < 15) {
      finalEvaluation = riskAssessmentFormModel.biologicalFather == "Yes" ||
          riskAssessmentFormModel.malnourished == "Yes" ||
          riskAssessmentFormModel.sexualAbuse == "Yes" ||
          riskAssessmentFormModel.traditionalProcedures == "Yes";
    } else {
      finalEvaluation = riskAssessmentFormModel.sexualAbuseAdolescent == "Yes" ||
          riskAssessmentFormModel.persistentlySick == "Yes" ||
          riskAssessmentFormModel.tb == "Yes" &&
              riskAssessmentFormModel.sexualIntercourse == "Yes" ||
          riskAssessmentFormModel.symptomsOfSTI == "Yes" ||
          riskAssessmentFormModel.ivDrugUser == "Yes";
    }

    this.finalEvaluation = finalEvaluation ? "Yes" : "No";
    notifyListeners();
  }
}

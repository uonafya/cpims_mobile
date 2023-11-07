import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_current_status_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_risk_assessment_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/progress_monitoring_form.dart';
import 'package:cpims_mobile/services/api_service.dart';
import 'package:flutter/foundation.dart';

class HIVAssessmentProvider with ChangeNotifier {
  CaseLoadModel _caseLoadModel = CaseLoadModel();
  CaseLoadModel get caseLoadModel => _caseLoadModel;
  HIVCurrentStatusModel _hivCurrentStatusModel = HIVCurrentStatusModel();
  HIVCurrentStatusModel get hivCurrentStatusModel => _hivCurrentStatusModel;
  HIVRiskAssessmentModel _hivRiskAssessmentModel = HIVRiskAssessmentModel();
  HIVRiskAssessmentModel get hivRiskAssessmentModel => _hivRiskAssessmentModel;
  ProgressMonitoringModel _progressMonitoringModel = ProgressMonitoringModel();
  ProgressMonitoringModel get progressMonitoringModel =>
      _progressMonitoringModel;

  int formIndex = 0;

  void updateFormIndex(int index) {
    formIndex = index;
    notifyListeners();
  }

  void updateCaseLoadModel(CaseLoadModel model) {
    _caseLoadModel = model;
    notifyListeners();
  }

  void updateHIVCurrentStatusModel(HIVCurrentStatusModel model) {
    _hivCurrentStatusModel = model;
    if (_hivCurrentStatusModel.hivStatus == "HIV_Positive") {
      updateFormIndex(2);
    }
    if (kDebugMode) {
      print(hivCurrentStatusModel.toJson());
    }
    notifyListeners();
  }

  void updateHIVRiskAssessmentModel(HIVRiskAssessmentModel model) {
    _hivRiskAssessmentModel = model;
    if (kDebugMode) {
      print(hivRiskAssessmentModel.toJson());
    }
    notifyListeners();
  }

  void updateProgressMonitoringModel(ProgressMonitoringModel model) {
    _progressMonitoringModel = model;
    if (kDebugMode) {
      print(progressMonitoringModel.toJson());
    }
    notifyListeners();
  }

  void clearForms() {
    _hivRiskAssessmentModel = HIVRiskAssessmentModel();
    _progressMonitoringModel = ProgressMonitoringModel();
    _progressMonitoringModel.reasonForNotMakingReferral = "A";
    notifyListeners();
  }

  Future<void> submitHIVAssessmentForm() async {
    try {
      final data = {
        'ovcCPIMSID': caseLoadModel.cpimsId,
        ..._hivCurrentStatusModel.toJson(),
        ..._hivRiskAssessmentModel.toJson(),
        ..._progressMonitoringModel.toJson(),
      };
      final response =
          await apiServiceConstructor.postSecData(data, "mobile/hrs/");
      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

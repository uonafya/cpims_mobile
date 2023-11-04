import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_current_status_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_risk_assessment_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/progress_monitoring_form.dart';
import 'package:flutter/foundation.dart';

class HIVAssessmentProvider with ChangeNotifier {
  HIVCurrentStatusModel? _hivCurrentStatusModel;
  HIVCurrentStatusModel? get hivCurrentStatusModel => _hivCurrentStatusModel;
  HIVRiskAssessmentModel? _hivRiskAssessmentModel;
  HIVRiskAssessmentModel? get hivRiskAssessmentModel => _hivRiskAssessmentModel;
  ProgressMonitoringModel? _progressMonitoringModel;
  ProgressMonitoringModel? get progressMonitoringModel =>
      _progressMonitoringModel;

  void updateHIVCurrentStatusModel(HIVCurrentStatusModel model) {
    _hivCurrentStatusModel = model;
    print(hivCurrentStatusModel!.toJson());
    notifyListeners();
  }

  void updateHIVRiskAssessmentModel(HIVRiskAssessmentModel model) {
    _hivRiskAssessmentModel = model;
    print(hivRiskAssessmentModel!.toJson());
    notifyListeners();
  }

  void updateProgressMonitoringModel(ProgressMonitoringModel model) {
    _progressMonitoringModel = model;
    print(progressMonitoringModel!.toJson());
    notifyListeners();
  }
}

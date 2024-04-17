import 'package:cpims_mobile/screens/forms/graduation_monitoring/model/graduation_monitoring_form_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class GraduationMonitoringProvider extends ChangeNotifier {
  GraduationMonitoringFormModel _graduationMonitoringFormModel =
      GraduationMonitoringFormModel();

  GraduationMonitoringFormModel get graduationMonitoringFormModel =>
      _graduationMonitoringFormModel;

  void updateGraduationMonitoringModel(
      GraduationMonitoringFormModel formModel) {
    _graduationMonitoringFormModel = formModel;
    notifyListeners();
    if (kDebugMode) {
      print(_graduationMonitoringFormModel.toMap());
    }
  }

  Future<void> submitGraduationMonitoringForm(
    String? cpimsID,
    String? caregiverCpimsId,
    uuid,
    startTimeInterview,
    formType,
  ) async {
    try {
      final formData = {
        'ovc_cpims_id': cpimsID,
        'caregiver_cpims_id': caregiverCpimsId,
        ..._graduationMonitoringFormModel.toMap()
      };

      if (kDebugMode) {
        print(formData);
      }
    } catch (e) {
      rethrow;
    }
  }
}

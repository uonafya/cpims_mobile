import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/screens/forms/graduation_monitoring/model/graduation_monitoring_form_model.dart';
import 'package:flutter/foundation.dart';

class GraduationMonitoringProvider extends ChangeNotifier {
  GraduationMonitoringFormModel _graduationMonitoringFormModel =
      GraduationMonitoringFormModel();

  GraduationMonitoringFormModel get graduationMonitoringFormModel =>
      _graduationMonitoringFormModel;

  String? formUuid;


  void updateGraduationMonitoringModel(
      GraduationMonitoringFormModel formModel) {
    _graduationMonitoringFormModel = formModel;
    notifyListeners();
    if (kDebugMode) {
      print(_graduationMonitoringFormModel.toMap());
    }
  }

  void clearForm() {
    _graduationMonitoringFormModel = GraduationMonitoringFormModel();
    formUuid = null;
    notifyListeners();
  }

  void updateFormUuid(String? formUuid) {
    this.formUuid = formUuid;
    notifyListeners();
  }

  Future<bool> submitGraduationMonitoringForm(
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

      bool isFormSaved = await LocalDb.instance
          .insertGraduationMonitoringFormData(
              cpimsID,
              caregiverCpimsId,
              _graduationMonitoringFormModel,
              uuid,
              startTimeInterview,
              formType,
              false,
              null);

      if (isFormSaved) {
        clearForm();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}

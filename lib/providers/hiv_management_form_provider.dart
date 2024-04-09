import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/models/hiv_management_form_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/strings.dart';

class HIVManagementFormProvider extends ChangeNotifier {
  HivManagementFormModel _hivManagementFormModel = HivManagementFormModel();

  HivManagementFormModel get hivManagementFormModel => _hivManagementFormModel;

  final CaseLoadModel _caseLoadModel = CaseLoadModel();

  CaseLoadModel get caseLoadModel => _caseLoadModel;

  String? formUuid;

  void updateHIVVisitationModel(HivManagementFormModel formModel) {
    _hivManagementFormModel = formModel;
    notifyListeners();
    if (kDebugMode) {
      print(_hivManagementFormModel.toJson());
    }
  }

  // clear form data
  void clearForms() {
    _hivManagementFormModel = HivManagementFormModel();
    notifyListeners();
  }

  void updateFormUuid(String? formUuid) {
    this.formUuid = formUuid;
    notifyListeners();
  }

  // submit form
  Future<void> submitHIVManagementForm(
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
        ..._hivManagementFormModel.toJson()
      };

      if (kDebugMode) {
        print(formData);
      }

      if (kDebugMode) {
        print(_hivManagementFormModel.nutritionalSupport);
      }

      // save data locally
      await LocalDb.instance.insertHMFFormData(
        cpimsID!,
        caregiverCpimsId!,
        _hivManagementFormModel,
        uuid,
        startTimeInterview,
        formType,
        false,
        null,
      );

      //reset form Data
      clearForms();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

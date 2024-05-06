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
  Future<bool> submitHIVManagementForm(
      String? cpimsID,
      String? caregiverCpimsId,
      String uuid,
      String startTimeInterview,
      String formType,
      ) async {
    try {
      final formData = {
        'ovc_cpims_id': cpimsID,
        'caregiver_cpims_id': caregiverCpimsId,
        ..._hivManagementFormModel.toJson()
      };

      print("The data being saved is $formData");

      if (kDebugMode) {
        print("The data being saved is $formData");
      }

      if (kDebugMode) {
        print(_hivManagementFormModel.nutritionalSupport);
      }

      // save data locally
      bool isFormSaved = await LocalDb.instance.insertHMFFormData(
        cpimsID!,
        caregiverCpimsId!,
        _hivManagementFormModel,
        uuid,
        startTimeInterview,
        formType,
        false,
        null,
      );

      if (isFormSaved) {
        clearForms();
        return true; // Form saved successfully
      } else {
        return false; // Form save failed
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false; // Exception occurred during form save
    }
  }
}

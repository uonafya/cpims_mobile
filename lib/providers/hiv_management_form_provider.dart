import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/models/hiv_management_form_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/strings.dart';

class HIVManagementFormProvider extends ChangeNotifier {
  ARTTherapyHIVFormModel _artTherapyFormModel = ARTTherapyHIVFormModel();

  ARTTherapyHIVFormModel get artTherapyFormModel => _artTherapyFormModel;

  HIVVisitationFormModel _hivVisitationFormModel = HIVVisitationFormModel();

  HIVVisitationFormModel get hIVVisitationFormModel => _hivVisitationFormModel;

  final CaseLoadModel _caseLoadModel = CaseLoadModel();
  CaseLoadModel get caseLoadModel => _caseLoadModel;

  // update artTherapy Info Model
  void updateARTTheraphyHIVModel(ARTTherapyHIVFormModel formModel) {
    _artTherapyFormModel = formModel;
    notifyListeners();
    if (kDebugMode) {
      print(_artTherapyFormModel.toJson());
    }
  }

  void updateHIVVisitationModel(HIVVisitationFormModel formModel) {
    _hivVisitationFormModel = formModel;
    notifyListeners();
    if (kDebugMode) {
      print(_hivVisitationFormModel.toJson());
    }
  }

  // clear form data
  void clearForms() {
    _artTherapyFormModel = ARTTherapyHIVFormModel();
    _hivVisitationFormModel = HIVVisitationFormModel();
    notifyListeners();
  }

  // submit form
  Future<void> submitHIVManagementForm(
      String? cpimsID,String? caregiverCpimsId,  uuid, startTimeInterview, formType,
      {required BuildContext context}) async {
    try {
      final formData = {
        'ovc_cpims_id': cpimsID,
        'caregiver_cpims_id': caregiverCpimsId,
        ..._artTherapyFormModel.toJson(),
        ..._hivVisitationFormModel.toJson(),
      };

      if (kDebugMode) {
        print(formData);
      }

      if (kDebugMode) {
        print(_hivVisitationFormModel.nutritionalSupport);
      }

      // save data locally
      await LocalDb.instance.insertHMFFormData(
        cpimsID!,
        caregiverCpimsId!,
        _artTherapyFormModel,
        _hivVisitationFormModel,
        uuid,
        startTimeInterview,
        formType,
        context: context,
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

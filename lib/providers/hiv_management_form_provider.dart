import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/models/hiv_management_form_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/strings.dart';

class HIVManagementFormProvider extends ChangeNotifier {
  ARTTherapyHIVFormModel _artTherapyFormModel = ARTTherapyHIVFormModel();

  ARTTherapyHIVFormModel get hIVManagementFormModel => _artTherapyFormModel;

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
  Future<void> submitHIVManagementForm(String? cpimsID,uuid,startTimeInterview,formType, {required BuildContext context}) async {
    try {
      final formData = {
        'ovc_cpims_id': cpimsID,
        ..._artTherapyFormModel.toJson(),
        ..._hivVisitationFormModel.toJson(),
      };

      // Loop through the formData map and apply modifications
      formData.forEach((key, value) {
        if (value == "Yes") {
          formData[key] = convertBooleanStringToDBBoolen("Yes");
        } else if (value == "No") {
          formData[key] = convertBooleanStringToDBBoolen("No");
        }
      });

      if (kDebugMode) {
        print(formData);
      }

      if (kDebugMode) {
        print(_hivVisitationFormModel.nutritionalSupport);
      }

      formData.forEach((key, value) {
        if (value == "Yes") {
          formData[key] = convertBooleanStringToDBBoolen("Yes");
        } else if (value == "No") {
          formData[key] = convertBooleanStringToDBBoolen("No");
        }
      });

      // save data locally
      await LocalDb.instance.insertHMFFormData(
        cpimsID!,
        _artTherapyFormModel,
        _hivVisitationFormModel,
        uuid,
        startTimeInterview,
        formType,
        context: context
      );

      //reset form Data
      clearForms();

      //reset form Data
      clearForms();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

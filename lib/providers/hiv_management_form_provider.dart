import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/models/hiv_management_form_model.dart';
import 'package:cpims_mobile/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

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
  Future<void> submitHIVManagementForm(String? cpimsID) async {
    try {
      final formData = {
        'ovc_cpims_id': cpimsID,
        ..._artTherapyFormModel.toJson(),
        ..._hivVisitationFormModel.toJson(),
      };

      // Loop through the formData map and apply modifications
      formData.forEach((key, value) {
        if (value is String) {
          // Combine values with 2 or more characters into one
          formData[key] = value.split(' ').where((s) => s.length > 1).join(' ');
          print(formData[value]);

          // Combine the first words before "if"
          formData[key] = formData[key]
              .split(' ')
              .map((value) =>
                  value.contains('if') ? value.split('if')[0] : value)
              .join(' ');
          print(formData[value]);
        } else {
          print("Hello");
        }
      });
      if (kDebugMode) {
        print(formData);
      }

      // submit data
      final Response response =
          await apiServiceConstructor.postSecData(formData, "mobile/hmf/");
      if (kDebugMode) {
        print(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

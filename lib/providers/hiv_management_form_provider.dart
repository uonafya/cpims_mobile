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

  CaseLoadModel _caseLoadModel = CaseLoadModel();
  CaseLoadModel get caseLoadModel => _caseLoadModel;

  // update artTherapy Info Model
  void updateARTTheraphyHIVModel(ARTTherapyHIVFormModel formModel) {
    _artTherapyFormModel = formModel;
    notifyListeners();
    print(_artTherapyFormModel.toJson());
  }

  void updateHIVVisitationModel(HIVVisitationFormModel formModel) {
    _hivVisitationFormModel = formModel;
    notifyListeners();
    print(_hivVisitationFormModel.toJson());
  }

  // clear form data
  void clearForms() {
    _artTherapyFormModel = ARTTherapyHIVFormModel();
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
      print(formData);
      final Response response =
          await apiServiceConstructor.postSecData(formData, "mobile/hmf/");
      print(response.body);
    } catch (e) {
      print(e);
    }
  }
}

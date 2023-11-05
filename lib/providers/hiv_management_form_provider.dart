import 'package:cpims_mobile/screens/forms/hiv_management/models/hiv_management_form_model.dart';
import 'package:flutter/cupertino.dart';

class HIVManagementFormProvider extends ChangeNotifier {
  HIVManagementFormModel? _hivManagementFormModel;

  HIVManagementFormModel? get hIVManagementFormModel => _hivManagementFormModel;

  void updateHIVManagementModel(HIVManagementFormModel formModel) {
    _hivManagementFormModel = formModel;
    notifyListeners();
    print(_hivManagementFormModel!.toJson());
  }
}

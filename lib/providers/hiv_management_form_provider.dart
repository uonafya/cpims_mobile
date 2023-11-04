import 'package:cpims_mobile/screens/forms/hiv_management/models/hiv_management_form_model.dart';
import 'package:flutter/cupertino.dart';

class HIVManagementFormProvider extends ChangeNotifier {
  final HIVManagementFormModel hivManagementFormModel =
      HIVManagementFormModel();

  HIVManagementFormModel get formData => hivManagementFormModel;
  
}

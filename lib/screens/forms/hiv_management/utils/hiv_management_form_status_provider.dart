import 'package:flutter/foundation.dart';

class FormCompletionStatusProvider with ChangeNotifier {
  bool _hivManagementFormCompleted =false;
  bool get hivManagementFormCompleted => _hivManagementFormCompleted;

  void setHIVManagementFormCompleted(bool completed) {
    _hivManagementFormCompleted = completed;
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';

class AppMetaDataProvider extends ChangeNotifier {
  String? formType;
  String? startTimeInterview;
  String? endTimeInterview;

  AppMetaDataProvider({
    this.formType,
    this.startTimeInterview,
    this.endTimeInterview,
  });

  void updateFormType(String formType) {
    this.formType = formType;
    notifyListeners();
  }

  void updateStartTimeInterview(String startTimeInterview) {
    this.startTimeInterview = startTimeInterview;
    notifyListeners();
  }

  void updateEndTimeInterview(String endTimeInterview) {
    this.endTimeInterview = endTimeInterview;
    notifyListeners();
  }

  void clearFormMetaData() {
    this.formType = null;
    this.startTimeInterview = null;
    this.endTimeInterview = null;
    notifyListeners();
  }
}

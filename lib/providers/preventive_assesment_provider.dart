import 'package:flutter/cupertino.dart';

class PreventiveAttendanceFormModel {
  String selectedDomain;
  String attendance;
  String dateOfEvent;
  String completedSessions;
  PreventiveAttendanceFormModel({
    this.selectedDomain = "Please select",
    this.attendance = "Please select",
    this.dateOfEvent = "",
    this.completedSessions = "",
  });

  Map<String, dynamic> toJSON() {
    return {
      "domain": selectedDomain,
      "attendance": attendance,
      "date_of_event": dateOfEvent,
      "completed_sessions": completedSessions,
    };
  }

  factory PreventiveAttendanceFormModel.fromJSON(Map<String, dynamic> json) {
    return PreventiveAttendanceFormModel(
      selectedDomain: json['domain'],
      attendance: json['attendance'],
      dateOfEvent: json['date_of_event'],
      completedSessions: json['completed_sessions'],
    );
  }
}

class ServicesReferralFormModel {
  String hasServiceOffered;
  String client;
  String hasCompleted;
  String otherReasons;
  String referralCompleted;
  String dateOfService;

  ServicesReferralFormModel({
    this.hasServiceOffered = "",
    this.client = "Please select",
    this.hasCompleted = "Please select",
    this.otherReasons = "",
    this.referralCompleted = "",
    this.dateOfService = "",
  });

  Map<String, dynamic> toJSON() {
    return {
      "has_service_offered": hasServiceOffered,
      "client": client,
      "has_completed": hasCompleted,
      "other_reasons": otherReasons,
      "referral_completed": referralCompleted,
      "date_of_service": dateOfService,
    };
  }

  factory ServicesReferralFormModel.fromJSON(Map<String, dynamic> json) {
    return ServicesReferralFormModel(
      hasServiceOffered: json['has_service_offered'],
      client: json['client'],
      hasCompleted: json['has_completed'],
      otherReasons: json['other_reasons'],
      referralCompleted: json['referral_completed'],
      dateOfService: json['date_of_service'],
    );
  }
}

class PreventiveAssessmentProvider with ChangeNotifier {
  int formIndex = 0;

  PreventiveAttendanceFormModel _preventiveAttendanceFormModel =
      PreventiveAttendanceFormModel();
  PreventiveAttendanceFormModel get preventiveAttendanceFormModel =>
      _preventiveAttendanceFormModel;

  ServicesReferralFormModel _servicesReferralFormModel =
      ServicesReferralFormModel();
  ServicesReferralFormModel get servicesReferralFormModel =>
      _servicesReferralFormModel;

  void updateFormIndex(int index) {
    formIndex = index;
    notifyListeners();
  }

  void updatePreventiveAttendanceFormModel(
      PreventiveAttendanceFormModel model) {
    _preventiveAttendanceFormModel = model;
    notifyListeners();
  }

  void updateServicesReferralFormModel(ServicesReferralFormModel model) {
    _servicesReferralFormModel = model;
    notifyListeners();
  }

  void clearPreventiveAttendanceFormModel() {
    _preventiveAttendanceFormModel = PreventiveAttendanceFormModel();
    notifyListeners();
  }

  void clearServicesReferralFormModel() {
    _servicesReferralFormModel = ServicesReferralFormModel();
    notifyListeners();
  }
}

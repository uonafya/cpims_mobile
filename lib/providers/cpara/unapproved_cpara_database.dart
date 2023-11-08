// Due to the large difference between how the CPARA model stores CPARA data
// and how the database stores CPARA data it is easier to create an intermediary
// class to bridge the gap
import 'package:cpims_mobile/screens/cpara/model/db_model.dart';

class UnapprovedCPARADatabase extends CPARADatabase {
  final String message;

  UnapprovedCPARADatabase(
      {required super.appFormMetaData,
      required super.childQuestions,
      required super.cpara_form_id,
      required super.date_of_event,
      required super.ovc_cpims_id,
      required super.questions,
      required this.message});

  factory UnapprovedCPARADatabase.fromJSON(Map<String, dynamic> json) {
    return UnapprovedCPARADatabase(
        appFormMetaData: appFormMetaData,
        childQuestions: json['individual_questions'].map((e) => CPARAChildQuestions.fromJSON(e)).toList(),
        cpara_form_id: 1,
        date_of_event: json['date_of_event'],
        ovc_cpims_id: json['ovc_cpims_id'],
        questions: questions,
        message: message);
  }
}

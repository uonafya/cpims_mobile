// Models for interacting with db
import 'package:cpims_mobile/screens/cpara/model/sub_ovc_child.dart';
import 'package:cpims_mobile/utils/app_form_metadata.dart';

class CPARAChildQuestions {
  String ovcCpimsId;
  String questionCode;
  String answerId;

  CPARAChildQuestions(
      {this.ovcCpimsId = "", this.questionCode = "", this.answerId = ""});

  factory CPARAChildQuestions.fromJSON(Map<String, dynamic> json) {
    return CPARAChildQuestions(
        questionCode: "${json['question_code']}",
        answerId: "${json['answer_id']}",
        ovcCpimsId: "${json['ovc_cpims_id']}");
  }

  Map<String, dynamic> toJSON() {
    return {
      "ovc_cpims_id": ovcCpimsId,
      "question_code": questionCode,
      "answer_id": answerId
    };
  }
}

class CPARADatabaseQuestions {
  final String questionCode;
  final String answerId;

  const CPARADatabaseQuestions({
    required this.questionCode,
    required this.answerId,
  });

  factory CPARADatabaseQuestions.fromJSON(Map<String, dynamic> json) {
    return CPARADatabaseQuestions(
        questionCode: json['question_code'], answerId: json['answer_id']);
  }

  Map<String, dynamic> toJSON() {
    return {questionCode: answerId};
  }
}

class CPARADatabase {
  String cparaFormId;
  String ovcCpimsId;
  String dateOfEvent;
  List<CPARADatabaseQuestions> questions;
  List<CPARAChildQuestions> childQuestions;
  AppFormMetaData appFormMetaData;
  List<SubOvcChild> listOfSubOvcs;

  CPARADatabase(
      {this.cparaFormId = "",
      this.ovcCpimsId = "",
      this.dateOfEvent = "",
      this.questions = const [],
      this.childQuestions = const [],
      this.appFormMetaData = const AppFormMetaData(),
      this.listOfSubOvcs = const []});
}

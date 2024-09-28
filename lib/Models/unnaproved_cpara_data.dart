// To parse this JSON data, do
//
//     final unaprovedRemoteData = unaprovedRemoteDataFromJson(jsonString);

import 'dart:convert';

List<UnaprovedRemoteData> unaprovedRemoteDataFromJson(String str) => List<UnaprovedRemoteData>.from(json.decode(str).map((x) => UnaprovedRemoteData.fromJson(x)));

String unaprovedRemoteDataToJson(List<UnaprovedRemoteData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UnaprovedRemoteData {
  String ovcCpimsId;
  DateTime dateOfEvent;
  List<Question> questions;
  List<IndividualQuestion> individualQuestions;
  Scores scores;

  UnaprovedRemoteData({
    required this.ovcCpimsId,
    required this.dateOfEvent,
    required this.questions,
    required this.individualQuestions,
    required this.scores,
  });

  factory UnaprovedRemoteData.fromJson(Map<String, dynamic> json) => UnaprovedRemoteData(
    ovcCpimsId: json["ovc_cpims_id"],
    dateOfEvent: DateTime.parse(json["date_of_event"]),
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    individualQuestions: List<IndividualQuestion>.from(json["individual_questions"].map((x) => IndividualQuestion.fromJson(x))),
    scores: Scores.fromJson(json["scores"]),
  );

  Map<String, dynamic> toJson() => {
    "ovc_cpims_id": ovcCpimsId,
    "date_of_event": "${dateOfEvent.year.toString().padLeft(4, '0')}-${dateOfEvent.month.toString().padLeft(2, '0')}-${dateOfEvent.day.toString().padLeft(2, '0')}",
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    "individual_questions": List<dynamic>.from(individualQuestions.map((x) => x.toJson())),
    "scores": scores.toJson(),
  };
}

class IndividualQuestion {
  String questionCode;
  String answerId;
  String ovcCpimsId;

  IndividualQuestion({
    required this.questionCode,
    required this.answerId,
    required this.ovcCpimsId,
  });

  factory IndividualQuestion.fromJson(Map<String, dynamic> json) => IndividualQuestion(
    questionCode: json["question_code"]!,
    answerId: json["answer_id"]!,
    ovcCpimsId: json["ovc_cpims_id"],
  );

  Map<String, dynamic> toJson() => {
    "question_code": questionCode,
    "answer_id": answerId,
    "ovc_cpims_id": ovcCpimsId,
  };
}

class Question {
  String questionCode;
  String answerId;

  Question({
    required this.questionCode,
    required this.answerId,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionCode: json["question_code"],
    answerId: json["answer_id"]!,
  );

  Map<String, dynamic> toJson() => {
    "question_code": questionCode,
    "answer_id": answerId,
  };
}

class Scores {
  String? b1;
  String? b2;
  String? b3;
  String? b4;
  String? b5;
  String? b6;
  String? b7;
  String? b8;
  String? b9;
  String? date;

  Scores({
    this.b1,
    this.b2,
    this.b3,
    this.b4,
    this.b5,
    this.b6,
    this.b7,
    this.b8,
    this.b9,
    this.date,
  });

  factory Scores.fromJson(Map<String, dynamic> json) => Scores(
    b1: json["b1"].toString(),
    b2: json["b2"].toString(),
    b3: json["b3"].toString(),
    b4: json["b4"].toString(),
    b5: json["b5"].toString(),
    b6: json["b6"].toString(),
    b7: json["b7"].toString(),
    b8: json["b8"].toString(),
    b9: json["b9"].toString(),
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "b1": b1,
    "b2": b2,
    "b3": b3,
    "b4": b4,
    "b5": b5,
    "b6": b6,
    "b7": b7,
    "b8": b8,
    "b9": b9,
    "date": date,
  };
}

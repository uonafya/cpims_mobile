import 'package:cpims_mobile/screens/cpara/model/cpara_question_ids.dart';

class SafeModel {
  final String? question1;
  final String? question2;
  final String? question3;
  final String? question4;
  final String? question5;

  final String? question6;
  final String? question7;

  final String? question8;

  final String? overallQuestion1;
  final String? overallQuestion2;
  final List<SafeChild>? childrenQuestions;

  SafeModel({
    this.question1,
    this.question2,
    this.question3,
    this.question4,
    this.question5,
    this.question6,
    this.question7,
    this.question8,
    this.overallQuestion1,
    this.overallQuestion2,
    this.childrenQuestions,
  });

  factory SafeModel.fromJson(Map<String, dynamic> json) {
    return SafeModel(
      question1: json['question1'],
      question2: json['question2'],
      question3: json['question3'],
      question4: json['question4'],
      question5: json['question5'],
      question6: json['question6'],
      question7: json['question7'],
      question8: json['question8'],
      overallQuestion1: json['overallQuestion1'],
      overallQuestion2: json['overallQuestion2'],
      childrenQuestions: json["childrenQuestions"] == null
          ? []
          : List<SafeChild>.from(
              json["childrenQuestions"]!.map((x) => SafeChild.fromJson(x))),
    );
  }

  // Converts the detail model to json. This is particulary going to be used for the sake of the database
  Map<String, dynamic> toJSON() {
    return {
      CparaQuestionIds.safeQuestion1: question1,
      CparaQuestionIds.safeQuestion2: question2,
      CparaQuestionIds.safeQuestion3: question3,
      CparaQuestionIds.safeQuestion4: question4,
      CparaQuestionIds.safeQuestion5: question5,
      CparaQuestionIds.safeQuestion6: question6,
      CparaQuestionIds.safeQuestion7: question7,
      "children": childrenQuestions?.map((e) => e.toJSON()).toList() ?? []
    };
  }

  SafeModel copyWith({
    String? question1,
    String? question2,
    String? question3,
    String? question4,
    String? question5,
    String? question6,
    String? question7,
    String? question8,
    String? overallQuestion1,
    String? overallQuestion2,
    List<SafeChild>? childrenQuestions,
  }) {
    return SafeModel(
      question1: question1 ?? this.question1,
      question2: question2 ?? this.question2,
      question3: question3 ?? this.question3,
      question4: question4 ?? this.question4,
      question5: question5 ?? this.question5,
      question6: question6 ?? this.question6,
      question7: question7 ?? this.question7,
      question8: question8 ?? this.question8,
      overallQuestion1: overallQuestion1 ?? this.overallQuestion1,
      overallQuestion2: overallQuestion2 ?? this.overallQuestion2,
      childrenQuestions: childrenQuestions ?? this.childrenQuestions,
    );
  }
}

class SafeChild {
  final String  ovcId;
  final String name;
  final String? question1;

  SafeChild({
    required this.ovcId,
    required this.name,
    required this.question1,
  });

  factory SafeChild.fromJson(Map<String, dynamic> json) {
    return SafeChild(
      question1: json['question1'],
      name: json['name'],
      ovcId: json['id'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {"id": ovcId, CparaQuestionIds.safeChildQuestion1: question1};
  }
}

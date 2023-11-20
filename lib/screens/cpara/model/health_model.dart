import 'package:cpims_mobile/screens/cpara/model/cpara_question_ids.dart';

class HealthModel {
  final String? overallQuestion1;
  final String? overallQuestion2;
  final String? overallQuestion3;
  final String? overallQuestion4;
  final String? overallQuestion5;
  final String? overallQuestion6;
  final String? overallQuestion7;
  String? question1;
  String? question2;
  String? question3;
  String? question4;
  String? question5;
  String? question6;
  String? question7;
  String? question8;
  String? question9;
  String? question10;
  String? question11;
  String? question12;
  String? question13;
  String? question14;
  String? question15;
  String? question16;
  String? question17;
  String? question18;
  List<HealthChild>? childrenQuestions;

  HealthModel({
    this.overallQuestion1,
    this.overallQuestion2,
    this.overallQuestion3,
    this.overallQuestion4,
    this.overallQuestion5,
    this.overallQuestion6,
    this.overallQuestion7,
    this.question1,
    this.question2,
    this.question3,
    this.question4,
    this.question5,
    this.question6,
    this.question7,
    this.question8,
    this.question9,
    this.question10,
    this.question11,
    this.question12,
    this.question13,
    this.question14,
    this.question15,
    this.question16,
    this.question17,
    this.question18,
    this.childrenQuestions,
  });

  HealthModel copyWith({
    String? overallQuestion1,
    String? overallQuestion2,
    String? overallQuestion3,
    String? overallQuestion4,
    String? overallQuestion5,
    String? overallQuestion6,
    String? overallQuestion7,
    String? question1,
    String? question2,
    String? question3,
    String? question4,
    String? question5,
    String? question6,
    String? question7,
    String? question8,
    String? question9,
    String? question10,
    String? question11,
    String? question12,
    String? question13,
    String? question14,
    String? question15,
    String? question16,
    String? question17,
    String? question18,
    List<HealthChild>? childrenQuestions,
  }) {
    return HealthModel(
        overallQuestion1: overallQuestion1 ?? this.overallQuestion1,
        overallQuestion2: overallQuestion2 ?? this.overallQuestion2,
        overallQuestion3: overallQuestion3 ?? this.overallQuestion3,
        overallQuestion4: overallQuestion4 ?? this.overallQuestion4,
        overallQuestion5: overallQuestion5 ?? this.overallQuestion5,
        overallQuestion6: overallQuestion6 ?? this.overallQuestion6,
        overallQuestion7: overallQuestion7 ?? this.overallQuestion7,
        question1: question1 ?? this.question1,
        question2: question2 ?? this.question2,
        question3: question3 ?? this.question3,
        question4: question4 ?? this.question4,
        question5: question5 ?? this.question5,
        question6: question6 ?? this.question6,
        question7: question7 ?? this.question7,
        question8: question8 ?? this.question8,
        question9: question9 ?? this.question9,
        question10: question10 ?? this.question10,
        question11: question11 ?? this.question11,
        question12: question12 ?? this.question12,
        question13: question13 ?? this.question13,
        question14: question14 ?? this.question14,
        question15: question15 ?? this.question15,
        question16: question16 ?? this.question16,
        question17: question17 ?? this.question17,
        question18: question18 ?? this.question18,
        childrenQuestions: childrenQuestions ?? this.childrenQuestions);
  }

  factory HealthModel.fromJson(Map<String, dynamic> json) {
    return HealthModel(
      overallQuestion1: json['overallQuestion1'],
      overallQuestion2: json['overallQuestion2'],
      overallQuestion3: json['overallQuestion3'],
      overallQuestion4: json['overallQuestion4'],
      overallQuestion5: json['overallQuestion5'],
      overallQuestion6: json['overallQuestion6'],
      overallQuestion7: json['overallQuestion7'],
      question1: json['question1'],
      question2: json['question2'],
      question3: json['question3'],
      question4: json['question4'],
      question5: json['question5'],
      question6: json['question6'],
      question7: json['question7'],
      question8: json['question8'],
      question9: json['question9'],
      question10: json['question10'],
      question11: json['question11'],
      question12: json['question12'],
      question13: json['question13'],
      question14: json['question14'],
      question15: json['question15'],
      question16: json['question16'],
      question17: json['question17'],
      question18: json['question18'],
      childrenQuestions: List<HealthChild>.from(
          json["childrenQuestions"]!.map((x) => HealthChild.fromJson(x))),
    );
  }

  // Converts the detail model to json. This is particulary going to be used for the sake of the database
  Map<String, dynamic> toJSON() {
    return {
      CparaQuestionIds.healthQuestion1: question1,
      CparaQuestionIds.healthQuestion2: question2,
      CparaQuestionIds.healthQuestion3: question3,
      CparaQuestionIds.healthQuestion4: question4,
      CparaQuestionIds.healthQuestion5: question5,
      CparaQuestionIds.healthGoal2Question1: question6,
      CparaQuestionIds.healthGoal2Question2: question7,
      CparaQuestionIds.healthGoal2Question3: question8,
      CparaQuestionIds.healthGoal2Question4: question9,
      CparaQuestionIds.healthGoal2Question5: question10,
      CparaQuestionIds.healthGoal2Question6: question11,
      CparaQuestionIds.healthGoal2Question7: question12,
      CparaQuestionIds.healthGoal2Question8: question13,
      CparaQuestionIds.healthGoal2Question9: question14,
      CparaQuestionIds.healthGoal4Question1: question15,
      CparaQuestionIds.healthGoal4Question2: question16,
      CparaQuestionIds.healthGoal4Question3: question17,
      CparaQuestionIds.healthGoal4Question4: question18,
      "children": childrenQuestions?.map((e) => e.toJSON()).toList() ?? []
    };
  }

  @override
  String toString() {
    return 'HealthModel {\n'
        '  question1: $question1,\n'
        '  question2: $question2,\n'
        '  question3: $question3,\n'
        '  question4: $question4,\n'
        '  question5: $question5,\n'
        '  question6: $question6,\n'
        '  question7: $question7,\n'
        '  question8: $question8,\n'
        '  question9: $question9,\n'
        '  question10: $question10,\n'
        '  question11: $question11,\n'
        '  question12: $question12,\n'
        '  question13: $question13,\n'
        '  question14: $question14,\n'
        '  question15: $question15,\n'
        '  question16: $question16,\n'
        '  question17: $question17,\n'
        '  question18: $question18,\n'
        '  childrenQuestions: $childrenQuestions,\n'
        '}';
  }
}

class HealthChild {
  String id;
  String name;
  String question1;
  String question2;
  String question3;

  HealthChild({
    required this.name,
    required this.id,
    required this.question1,
    required this.question2,
    required this.question3,
  });

  factory HealthChild.fromJson(Map<String, dynamic> json) {
    return HealthChild(
      id: json['id'],
      name: json['name'] ?? "",
      question1: json['question1'],
      question2: json['question2'],
      question3: json['question3'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      CparaQuestionIds.healthGoal3ChildQuestion1: question1,
      CparaQuestionIds.healthGoal3ChildQuestion2: question2,
      CparaQuestionIds.healthGoal3ChildQuestion3: question3
    };
  }

  @override
  String toString() {
    return 'HealthChild {\n'
        '  id: $id,\n'
        '  name: $name,\n'
        '  question1: $question1,\n'
        '  question2: $question2,\n'
        '  question3: $question3,\n'
        '}';
  }
}

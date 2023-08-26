class HealthModel {
  final String? question1;
  final String? question2;
  final String? question3;
  final String? question4;
  final String? question5;
  final String? question6;
  final String? question7;
  final String? question8;
  final String? question9;
  final String? question10;
  final String? question11;
  final String? question12;
  final String? question13;
  final String? question14;
  final String? question15;
  final String? question16;
  final String? question17;
  final String? question18;
  final List<HealthChild>? childrenQuestions;

  HealthModel({
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
      'q7': question1,
      'q8': question2,
      'q9': question3,
      'q10': question4,
      'q11': question5,
      'q12': question6,
      'q13': question7,
      'q14': question8,
      'q15': question9,
      'q16': question10,
      'q17': question11,
      'q18': question12,
      'q19': question13,
      'q20': question14,
      'q21': question15,
      'q22': question16,
      'q23': question17,
      'q24': question18,
      "children": childrenQuestions?.map((e) => e.toJSON()).toList() ?? []
    };
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
    return {"id": id, "q1": question1, "q2": question2, "q3": question3};
  }
}

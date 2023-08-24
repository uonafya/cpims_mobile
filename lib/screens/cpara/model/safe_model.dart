class SafeModel{
  final String? question1;
  final String? question2;
  final String? question3;
  final String? question4;
  final String? question5;
  final String? question6;
  final String? question7;
  final List<SafeChild>? childrenQuestions;

  SafeModel({
    this.question1,
    this.question2,
    this.question3,
    this.question4,
    this.question5,
    this.question6,
    this.question7,
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
      childrenQuestions: json["childrenQuestions"] == null ? [] : List<SafeChild>.from(json["childrenQuestions"]!.map((x) => SafeChild.fromJson(x))),
    );
  }

  SafeModel copyWith({
    String? question1,
    String? question2,
    String? question3,
    String? question4,
    String? question5,
    String? question6,
    String? question7,
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
      childrenQuestions: childrenQuestions ?? this.childrenQuestions,
    );
  }
}

class SafeChild{
  final String? question1;

  SafeChild({
    required this.question1,
  });

  factory SafeChild.fromJson(Map<String, dynamic> json) {
    return SafeChild(
      question1: json['question1'],
    );
  }
}
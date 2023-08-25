class SchooledModel{
   final String? mainquestion1;
  final String? question1;
  final String? question2;
  final String? mainquestion2;
  final String? question3;
  final String? question4;

  SchooledModel({
    this.mainquestion1,
    this.question1,
    this.question2,
    this.mainquestion2,
    this.question3,
    this.question4,
  });

  factory SchooledModel.fromJson(Map<String, dynamic> json) {
    return SchooledModel(
      mainquestion1: json['mainquestion1'],
      question1: json['question1'],
      question2: json['question2'],
      mainquestion2: json['mainquestion2'],
      question3: json['question3'],
      question4: json['question4'],
    );
  }

  SchooledModel copyWith({
    String? mainquestion1,
    String? question1,
    String? question2,
    String? mainquestion2,
    String? question3,
    String? question4,
  }) {
    return SchooledModel(
      mainquestion1: mainquestion1 ?? this.mainquestion1,
      question1: question1 ?? this.question1,
      question2: question2 ?? this.question2,
      mainquestion2: mainquestion2 ?? this.mainquestion2,
      question3: question3 ?? this.question3,
      question4: question4 ?? this.question4,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'q32': question1,
      'q33': question2,
      'q34': question3,
      'q35': question4,
    };
  }
}

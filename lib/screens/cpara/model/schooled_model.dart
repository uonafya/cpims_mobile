class SchooledModel {
  final String question1;
  final String question2;
  final String question3;
  final String question4;

  SchooledModel({
    required this.question1,
    required this.question2,
    required this.question3,
    required this.question4,
  });

  factory SchooledModel.fromJson(Map<String, dynamic> json) {
    return SchooledModel(
      question1: json['question1'],
      question2: json['question2'],
      question3: json['question3'],
      question4: json['question4'],
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

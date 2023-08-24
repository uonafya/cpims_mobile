class SafeModel{
  final String question1;
  final String question2;
  final String question3;
  final String question4;
  final String question5;
  final String question6;
  final String question7;
  final String question8;

  SafeModel({
    required this.question1,
    required this.question2,
    required this.question3,
    required this.question4,
    required this.question5,
    required this.question6,
    required this.question7,
    required this.question8,
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
    );
  }
}
/// note it has a list of children.
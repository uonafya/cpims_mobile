class HealthModel{
  final String question1;
  final String question2;
  final String question3;
  final String question4;
  final String question5;
  final String question6;
  final String question7;
  final String question8;
  final String question9;
  final String question10;
  final String question11;
  final String question12;
  final String question13;
  final String question14;
  final String question15;
  final String question16;
  final String question17;
  final String question18;
  final String question19;
  final String question20;
  final String question21;

  HealthModel({
    required this.question1,
    required this.question2,
    required this.question3,
    required this.question4,
    required this.question5,
    required this.question6,
    required this.question7,
    required this.question8,
    required this.question9,
    required this.question10,
    required this.question11,
    required this.question12,
    required this.question13,
    required this.question14,
    required this.question15,
    required this.question16,
    required this.question17,
    required this.question18,
    required this.question19,
    required this.question20,
    required this.question21,
  });


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
      question19: json['question19'],
      question20: json['question20'],
      question21: json['question21'],
    );
  }
}
//list of children
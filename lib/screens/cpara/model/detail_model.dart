class DetailModel{
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
  final String dateOfAssessment;
  final String dateOfLastAssessment;

  DetailModel({
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
    required this.dateOfAssessment,
    required this.dateOfLastAssessment,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
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
      dateOfAssessment: json['dateOfAssessment'],
      dateOfLastAssessment: json['dateOfLastAssessment'],
    );
  }
}
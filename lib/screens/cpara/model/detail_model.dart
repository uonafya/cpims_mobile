class DetailModel{
  final String question1;
  final List<DetailChild> childrenQuestions;
  final String dateOfAssessment;
  final String dateOfLastAssessment;

  DetailModel({
    required this.question1,
    required this.childrenQuestions,
    required this.dateOfAssessment,
    required this.dateOfLastAssessment,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      question1: json['question1'],
      childrenQuestions: List<DetailChild>.from(json["childrenQuestions"]!.map((x) => DetailChild.fromJson(x))),
      dateOfAssessment: json['dateOfAssessment'],
      dateOfLastAssessment: json['dateOfLastAssessment'],
    );
  }
}

class DetailChild {
  final String question1;
  final String question2;
  final String question3;
  final String question4;
  final String question5;
  final String question6;
  final String question7;
  final String question8;


  DetailChild({
    required this.question1,
    required this.question2,
    required this.question3,
    required this.question4,
    required this.question5,
    required this.question6,
    required this.question7,
    required this.question8,
  });

  factory DetailChild.fromJson(Map<String, dynamic> json) {
    return DetailChild(
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
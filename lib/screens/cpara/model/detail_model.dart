class DetailModel {
  final String? isFirstAssessment;
  final String? isChildHeaded;
  final String? hasHivExposedInfant;
  final String? hasPregnantOrBreastfeedingWoman;
  final List<DetailChild>? childrenQuestions;
  final String? dateOfAssessment;
  final String? dateOfLastAssessment;

  DetailModel({
    this.isFirstAssessment,
    this.isChildHeaded,
    this.hasHivExposedInfant,
    this.hasPregnantOrBreastfeedingWoman,
    this.childrenQuestions,
    this.dateOfAssessment,
    this.dateOfLastAssessment,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      isFirstAssessment: json['question1'],
      isChildHeaded: json['question2'],
      hasHivExposedInfant: json['question3'],
      hasPregnantOrBreastfeedingWoman: json['question4'],
      childrenQuestions: List<DetailChild>.from(
          json["childrenQuestions"]!.map((x) => DetailChild.fromJson(x))),
      dateOfAssessment: json['dateOfAssessment'],
      dateOfLastAssessment: json['dateOfLastAssessment'],
    );
  }

  // Converts the detail model to json. This is particulary going to be used for the sake of the database
  Map<String, dynamic> toJSON() {
    return {
      'q1': isFirstAssessment,
      'q2': isChildHeaded,
      'q3': hasHivExposedInfant,
      'q4': hasPregnantOrBreastfeedingWoman,
      'q5': dateOfAssessment,
      // 'q6': dateOfLastAssessment // This is sent as its own parameter in the request
    };
  }

  DetailModel copyWith({
    String? isFirstAssessment,
    String? isChildHeaded,
    String? hasHivExposedInfant,
    String? hasPregnantOrBreastfeedingWoman,
    List<DetailChild>? childrenQuestions,
    String? dateOfAssessment,
    String? dateOfLastAssessment,
  }) {
    return DetailModel(
      isFirstAssessment: isFirstAssessment ?? this.isFirstAssessment,
      isChildHeaded: isChildHeaded ?? this.isChildHeaded,
      hasHivExposedInfant: hasHivExposedInfant ?? this.hasHivExposedInfant,
      hasPregnantOrBreastfeedingWoman: hasPregnantOrBreastfeedingWoman ??
          this.hasPregnantOrBreastfeedingWoman,
      childrenQuestions: childrenQuestions ?? this.childrenQuestions,
      dateOfAssessment: dateOfAssessment ?? this.dateOfAssessment,
      dateOfLastAssessment: dateOfLastAssessment ?? this.dateOfLastAssessment,
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

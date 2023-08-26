class DetailModel {
  final String? isFirstAssessment;
  final String? isChildHeaded;
  final String? hasHivExposedInfant;
  final String? hasPregnantOrBreastfeedingWoman;
  final String? dateOfAssessment;
  final String? dateOfLastAssessment;

  DetailModel({
    this.isFirstAssessment,
    this.isChildHeaded,
    this.hasHivExposedInfant,
    this.hasPregnantOrBreastfeedingWoman,
    this.dateOfAssessment,
    this.dateOfLastAssessment,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      isFirstAssessment: json['question1'],
      isChildHeaded: json['question2'],
      hasHivExposedInfant: json['question3'],
      hasPregnantOrBreastfeedingWoman: json['question4'],
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
    String? dateOfAssessment,
    String? dateOfLastAssessment,
  }) {
    return DetailModel(
      isFirstAssessment: isFirstAssessment ?? this.isFirstAssessment,
      isChildHeaded: isChildHeaded ?? this.isChildHeaded,
      hasHivExposedInfant: hasHivExposedInfant ?? this.hasHivExposedInfant,
      hasPregnantOrBreastfeedingWoman: hasPregnantOrBreastfeedingWoman ??
          this.hasPregnantOrBreastfeedingWoman,
      dateOfAssessment: dateOfAssessment ?? this.dateOfAssessment,
      dateOfLastAssessment: dateOfLastAssessment ?? this.dateOfLastAssessment,
    );
  }
}

class OvcSubPopulationModel {
  final String? question1;
  final String? question2;
  final String? question3;
  final String? question4;
  final String? question5;
  final String? question6;
  final String? question7;
  final String? question8;

  OvcSubPopulationModel({
     this.question1,
     this.question2,
     this.question3,
     this.question4,
     this.question5,
     this.question6,
     this.question7,
     this.question8,
  });

  factory OvcSubPopulationModel.fromJson(Map<String, dynamic> json) {
    return OvcSubPopulationModel(
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

  //to json
  Map<String, dynamic> toJSON() {
    return {
      'q1': question1,
      'q2': question2,
      'q3': question3,
      'q4': question4,
      'q5': question5,
      'q6': question6,
      'q7': question7,
      'q8': question8,
    };
  }


}

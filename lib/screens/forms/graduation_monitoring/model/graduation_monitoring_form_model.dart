class GraduationMonitoringFormModel {
  String? form_type = 'bm';
  String? gm1d = '';
  String? cm2q = '';
  String? cm3q = '';
  String? cm4q = '';
  String? cm5q = '';
  String? cm6q = '';
  String? cm7q = '';
  String? cm8q = '';
  String? cm9q = '';
  String? cm10q = '';
  String? cm13q = '';
  String? cm14q = '';

  GraduationMonitoringFormModel({
    this.form_type,
    this.gm1d,
    this.cm2q,
    this.cm3q,
    this.cm4q,
    this.cm5q,
    this.cm6q,
    this.cm7q,
    this.cm8q,
    this.cm9q,
    this.cm10q,
    this.cm13q,
    this.cm14q,
  });

  Map<String, dynamic> toMap() {
    return {
      'form_type': form_type,
      'gm1d': gm1d,
      'cm2q': cm2q,
      'cm3q': cm3q,
      'cm4q': cm4q,
      'cm5q': cm5q,
      'cm6q': cm6q,
      'cm7q': cm7q,
      'cm8q': cm8q,
      'cm9q': cm9q,
      'cm10q': cm10q,
      'cm13q': cm13q,
      'cm14q': cm14q,
    };
  }

  factory GraduationMonitoringFormModel.fromMap(Map<String, dynamic> map) {
    return GraduationMonitoringFormModel(
      form_type: map['form_type'],
      gm1d: map['gm1d'],
      cm2q: map['cm2q'],
      cm3q: map['cm3q'],
      cm4q: map['cm4q'],
      cm5q: map['cm5q'],
      cm6q: map['cm6q'],
      cm7q: map['cm7q'],
      cm8q: map['cm8q'],
      cm9q: map['cm9q'],
      cm10q: map['cm10q'],
      cm13q: map['cm13q'],
      cm14q: map['cm14q'],
    );
  }

  //copyWith method
  GraduationMonitoringFormModel copyWith({
    String? formType,
    String? dateOfMonitoring,
    String? benchmark1,
    String? benchmark2,
    String? benchmark3,
    String? benchmark4,
    String? benchmark5,
    String? benchmark6,
    String? benchmark7,
    String? benchmark8,
    String? benchmark9,
    String? householdReadyToExit,
    String? caseDeterminedReadyForClosure,
  }) {
    return GraduationMonitoringFormModel(
      form_type: formType ?? this.form_type,
      gm1d: dateOfMonitoring ?? this.gm1d,
      cm2q: benchmark1 ?? this.cm2q,
      cm3q: benchmark2 ?? this.cm3q,
      cm4q: benchmark3 ?? this.cm4q,
      cm5q: benchmark4 ?? this.cm5q,
      cm6q: benchmark5 ?? this.cm6q,
      cm7q: benchmark6 ?? this.cm7q,
      cm8q: benchmark7 ?? this.cm8q,
      cm9q: benchmark8 ?? this.cm9q,
      cm10q: benchmark9 ?? this.cm10q,
      cm13q: householdReadyToExit ?? this.cm13q,
      cm14q: caseDeterminedReadyForClosure ?? this.cm14q,
    );
  }

  //toString method
  @override
  String toString() {
    return 'GraduationMonitoringFormModel(formType: $form_type, dateOfMonitoring: $gm1d, benchmark1: $cm2q, benchmark2: $cm3q, benchmark3: $cm4q, benchmark4: $cm5q, benchmark5: $cm6q, benchmark6: $cm7q, benchmark7: $cm8q, benchmark8: $cm9q, benchmark9: $cm10q, householdReadyToExit: $cm13q, caseDeterminedReadyForClosure: $cm14q)';
  }
}

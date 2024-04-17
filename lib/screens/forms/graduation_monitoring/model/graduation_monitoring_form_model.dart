class GraduationMonitoringFormModel {
  String? formType = 'Benchmark Monitoring';
  String? dateOfMonitoring = '';
  String? benchmark1 = '';
  String? benchmark2 = '';
  String? benchmark3 = '';
  String? benchmark4 = '';
  String? benchmark5 = '';
  String? benchmark6 = '';
  String? benchmark7 = '';
  String? benchmark8 = '';
  String? benchmark9 = '';
  String? householdReadyToExit = '';
  String? caseDeterminedReadyForClosure = '';

  GraduationMonitoringFormModel({
    this.formType,
    this.dateOfMonitoring,
    this.benchmark1,
    this.benchmark2,
    this.benchmark3,
    this.benchmark4,
    this.benchmark5,
    this.benchmark6,
    this.benchmark7,
    this.benchmark8,
    this.benchmark9,
    this.householdReadyToExit,
    this.caseDeterminedReadyForClosure,
  });

  Map<String, dynamic> toMap() {
    return {
      'formType': formType,
      'dateOfMonitoring': dateOfMonitoring,
      'benchmark1': benchmark1,
      'benchmark2': benchmark2,
      'benchmark3': benchmark3,
      'benchmark4': benchmark4,
      'benchmark5': benchmark5,
      'benchmark6': benchmark6,
      'benchmark7': benchmark7,
      'benchmark8': benchmark8,
      'benchmark9': benchmark9,
      'householdReadyToExit': householdReadyToExit,
      'caseDeterminedReadyForClosure': caseDeterminedReadyForClosure,
    };
  }

  factory GraduationMonitoringFormModel.fromMap(Map<String, dynamic> map) {
    return GraduationMonitoringFormModel(
      formType: map['formType'],
      dateOfMonitoring: map['dateOfMonitoring'],
      benchmark1: map['benchmark1'],
      benchmark2: map['benchmark2'],
      benchmark3: map['benchmark3'],
      benchmark4: map['benchmark4'],
      benchmark5: map['benchmark5'],
      benchmark6: map['benchmark6'],
      benchmark7: map['benchmark7'],
      benchmark8: map['benchmark8'],
      benchmark9: map['benchmark9'],
      householdReadyToExit: map['householdReadyToExit'],
      caseDeterminedReadyForClosure: map['caseDeterminedReadyForClosure'],
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
      formType: formType ?? this.formType,
      dateOfMonitoring: dateOfMonitoring ?? this.dateOfMonitoring,
      benchmark1: benchmark1 ?? this.benchmark1,
      benchmark2: benchmark2 ?? this.benchmark2,
      benchmark3: benchmark3 ?? this.benchmark3,
      benchmark4: benchmark4 ?? this.benchmark4,
      benchmark5: benchmark5 ?? this.benchmark5,
      benchmark6: benchmark6 ?? this.benchmark6,
      benchmark7: benchmark7 ?? this.benchmark7,
      benchmark8: benchmark8 ?? this.benchmark8,
      benchmark9: benchmark9 ?? this.benchmark9,
      householdReadyToExit: householdReadyToExit ?? this.householdReadyToExit,
      caseDeterminedReadyForClosure:
          caseDeterminedReadyForClosure ?? this.caseDeterminedReadyForClosure,
    );
  }

  //toString method
  @override
  String toString() {
    return 'GraduationMonitoringFormModel(formType: $formType, dateOfMonitoring: $dateOfMonitoring, benchmark1: $benchmark1, benchmark2: $benchmark2, benchmark3: $benchmark3, benchmark4: $benchmark4, benchmark5: $benchmark5, benchmark6: $benchmark6, benchmark7: $benchmark7, benchmark8: $benchmark8, benchmark9: $benchmark9, householdReadyToExit: $householdReadyToExit, caseDeterminedReadyForClosure: $caseDeterminedReadyForClosure)';
  }
}

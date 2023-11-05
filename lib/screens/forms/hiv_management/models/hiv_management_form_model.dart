class HIVManagementFormModel {
  final DateTime? dateHIVConfirmedPositive;
  final DateTime? dateTreatmentInitiated;
  final String? baselineHEILoad;
  final DateTime? dateStartedFirstLine;
  final String? arvsSubWithFirstLine;
  final DateTime? arvsSubWithFirstLineDate;
  final String? switchToSecondLine;
  final DateTime? switchToSecondLineDate;
  final String? switchToThirdLine;
  final DateTime? switchToThirdLineDate;
  final DateTime? visitDate;
  final String? durationOnARTs;
  final String? height;
  final DateTime? mUAC;
  final String? arvDrugsAdherence;
  final String? arvDrugsDuration;
  final String? adherenceCounseling;
  final String? treatmentSupporter;
  final String? treatmentSupporterOthers;
  final String? treatmentSupporterSex;
  final String? treatmentSupporterAge;
  final String? treatmentSupporterHIVStatus;
  final String? viralLoadResults;
  final DateTime? labInvestigationsDate;
  final String? detectableViralLoadInterventions;
  final String? disclosure;
  final String? mUACScore;
  final String? zScore;
  final Set<String>? nutritionalSupport;
  final String? supportGroupStatus;
  final String? nhifEnrollment;
  final String? nhifEnrollmentStatus;
  final String? referralServices;
  final DateTime? nextAppointmentDate;
  final String? peerEducatorName;
  final String? peerEducatorContact;

  HIVManagementFormModel({
    this.dateHIVConfirmedPositive,
    this.dateTreatmentInitiated,
    this.baselineHEILoad,
    this.dateStartedFirstLine,
    this.arvsSubWithFirstLine,
    this.arvsSubWithFirstLineDate,
    this.switchToSecondLine,
    this.switchToSecondLineDate,
    this.switchToThirdLine,
    this.switchToThirdLineDate,
    this.visitDate,
    this.durationOnARTs,
    this.height,
    this.mUAC,
    this.arvDrugsAdherence,
    this.arvDrugsDuration,
    this.adherenceCounseling,
    this.treatmentSupporter,
    this.treatmentSupporterOthers,
    this.treatmentSupporterSex,
    this.treatmentSupporterAge,
    this.treatmentSupporterHIVStatus,
    this.viralLoadResults,
    this.labInvestigationsDate,
    this.detectableViralLoadInterventions,
    this.disclosure,
    this.mUACScore,
    this.zScore,
    this.nutritionalSupport,
    this.supportGroupStatus,
    this.nhifEnrollment,
    this.nhifEnrollmentStatus,
    this.referralServices,
    this.nextAppointmentDate,
    this.peerEducatorName,
    this.peerEducatorContact,
  });

  Map<String, dynamic> toJson() {
    List<dynamic>? nutritionalSupportList = nutritionalSupport?.toList();

    return {
      'dateHIVConfirmedPositive': dateHIVConfirmedPositive,
      'dateTreatmentInitiated': dateTreatmentInitiated,
      'baselineHEILoad': baselineHEILoad,
      'dateStartedFirstLine': dateStartedFirstLine,
      'arvsSubWithFirstLine': arvsSubWithFirstLine,
      'arvsSubWithFirstLineDate': arvsSubWithFirstLineDate,
      'switchToSecondLine': switchToSecondLine,
      'switchToSecondLineDate': switchToSecondLineDate,
      'switchToThirdLine': switchToThirdLine,
      'switchToThirdLineDate': switchToThirdLineDate,
      'visitDate': visitDate,
      'durationOnARTs': durationOnARTs,
      'height': height,
      'mUAC': mUAC,
      'arvDrugsAdherence': arvDrugsAdherence,
      'arvDrugsDuration': arvDrugsDuration,
      'adherenceCounseling': adherenceCounseling,
      'treatmentSupporter': treatmentSupporter,
      'treatmentSupporterOthers': treatmentSupporterOthers,
      'treatmentSupporterSex': treatmentSupporterSex,
      'treatmentSupporterAge': treatmentSupporterAge,
      'treatmentSupporterHIVStatus': treatmentSupporterHIVStatus,
      'viralLoadResults': viralLoadResults,
      'labInvestigationsDate': labInvestigationsDate,
      'detectableViralLoadInterventions': detectableViralLoadInterventions,
      'disclosure': disclosure,
      'mUACScore': mUACScore,
      'zScore': zScore,
      'nutritionalSupport': nutritionalSupportList,
      'supportGroupStatus': supportGroupStatus,
      'nhifEnrollment': nhifEnrollment,
      'nhifEnrollmentStatus': nhifEnrollmentStatus,
      'referralServices': referralServices,
      'nextAppointmentDate': nextAppointmentDate,
      'peerEducatorName': peerEducatorName,
      'peerEducatorContact': peerEducatorContact,
    };
  }

  factory HIVManagementFormModel.fromJson(Map<String, dynamic> json) {
    Set<String>? nutritionalSupport =
        (json['nutritionalSupport'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toSet();
    return HIVManagementFormModel(
      dateHIVConfirmedPositive: json['dateHIVConfirmedPositive'],
      dateTreatmentInitiated: json['dateTreatmentInitiated'],
      baselineHEILoad: json['baselineHEILoad'],
      dateStartedFirstLine: json['dateStartedFirstLine'],
      arvsSubWithFirstLine: json['arvsSubWithFirstLine'],
      arvsSubWithFirstLineDate: json['arvsSubWithFirstLineDate'],
      switchToSecondLine: json['switchToSecondLine'],
      switchToSecondLineDate: json['switchToSecondLineDate'],
      switchToThirdLine: json['switchToThirdLine'],
      switchToThirdLineDate: json['switchToThirdLineDate'],
      visitDate: json['visitDate'],
      durationOnARTs: json['durationOnARTs'],
      height: json['height'],
      mUAC: json['mUAC'],
      arvDrugsAdherence: json['arvDrugsAdherence'],
      arvDrugsDuration: json['arvDrugsDuration'],
      adherenceCounseling: json['adherenceCounseling'],
      treatmentSupporter: json['treatmentSupporter'],
      treatmentSupporterOthers: json['treatmentSupporterOthers'],
      treatmentSupporterSex: json['treatmentSupporterSex'],
      treatmentSupporterAge: json['treatmentSupporterAge'],
      treatmentSupporterHIVStatus: json['treatmentSupporterHIVStatus'],
      viralLoadResults: json['viralLoadResults'],
      labInvestigationsDate: json['labInvestigationsDate'],
      detectableViralLoadInterventions:
          json['detectableViralLoadInterventions'],
      disclosure: json['disclosure'],
      mUACScore: json['mUACScore'],
      zScore: json['zScore'],
      nutritionalSupport: nutritionalSupport,
      supportGroupStatus: json['supportGroupStatus'],
      nhifEnrollment: json['nhifEnrollment'],
      nhifEnrollmentStatus: json['nhifEnrollmentStatus'],
      referralServices: json['referralServices'],
      nextAppointmentDate: json['nextAppointmentDate'],
      peerEducatorName: json['peerEducatorName'],
      peerEducatorContact: json['peerEducatorContact'],
    );
  }
}

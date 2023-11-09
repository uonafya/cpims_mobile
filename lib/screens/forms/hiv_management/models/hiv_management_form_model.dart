import 'dart:convert';

class ARTTherapyHIVFormModel {
  final String dateOfEvent;
  final String dateHIVConfirmedPositive;
  final String dateTreatmentInitiated;
  final String baselineHEILoad;
  final String dateStartedFirstLine;
  final String arvsSubWithFirstLine;
  final String arvsSubWithFirstLineDate;
  final String switchToSecondLine;
  final String switchToSecondLineDate;
  final String switchToThirdLine;
  final String switchToThirdLineDate;

  ARTTherapyHIVFormModel({
    this.dateOfEvent = '',
    this.dateHIVConfirmedPositive = '',
    this.dateTreatmentInitiated = '',
    this.baselineHEILoad = '',
    this.dateStartedFirstLine = '',
    this.arvsSubWithFirstLine = '',
    this.arvsSubWithFirstLineDate = '',
    this.switchToSecondLine = '',
    this.switchToSecondLineDate = '',
    this.switchToThirdLine = '',
    this.switchToThirdLineDate = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'HIV_MGMT_1_A': dateHIVConfirmedPositive,
      'HIV_MGMT_1_B': dateTreatmentInitiated,
      'HIV_MGMT_1_C': baselineHEILoad,
      'HIV_MGMT_1_D': dateStartedFirstLine,
      'HIV_MGMT_1_E': arvsSubWithFirstLine,
      'HIV_MGMT_1_E_DATE': arvsSubWithFirstLineDate,
      'HIV_MGMT_1_F': switchToSecondLine,
      'HIV_MGMT_1_F_DATE': switchToSecondLineDate,
      'HIV_MGMT_1_G': switchToThirdLine,
      'HIV_MGMT_1_G_DATE': switchToThirdLineDate,
    };
  }

  factory ARTTherapyHIVFormModel.fromJson(Map<String, dynamic> json) {
    return ARTTherapyHIVFormModel(
      dateHIVConfirmedPositive: json['HIV_MGMT_1_A'] ?? '',
      dateTreatmentInitiated: json['HIV_MGMT_1_B'] ?? '',
      baselineHEILoad: json['HIV_MGMT_1_C'] ?? '',
      dateStartedFirstLine: json['HIV_MGMT_1_D'] ?? '',
      arvsSubWithFirstLine: json['HIV_MGMT_1_E'] ?? '',
      arvsSubWithFirstLineDate: json['HIV_MGMT_1_E_DATE'] ?? '',
      switchToSecondLine: json['HIV_MGMT_1_F'] ?? '',
      switchToSecondLineDate: json['HIV_MGMT_1_F_DATE'] ?? '',
      switchToThirdLine: json['HIV_MGMT_1_G'] ?? '',
      switchToThirdLineDate: json['HIV_MGMT_1_G_DATE'] ?? '',
    );
  }
}

class HIVVisitationFormModel {
  final String visitDate;
  final String durationOnARTs;
  final String height;
  final String mUAC;
  final String arvDrugsAdherence;
  final String arvDrugsDuration;
  final String adherenceCounseling;
  final String treatmentSupporter;
  final String treatmentSupporterSex;
  final String treatmentSupporterAge;
  final String treatmentSupporterHIVStatus;
  final String viralLoadResults;
  final String labInvestigationsDate;
  final String detectableViralLoadInterventions;
  final String disclosure;
  final String mUACScore;
  final String zScore;
  final List<String> nutritionalSupport;
  final String supportGroupStatus;
  final String nhifEnrollment;
  final String nhifEnrollmentStatus;
  final String referralServices;
  final String nextAppointmentDate;
  final String peerEducatorName;
  final String peerEducatorContact;

  HIVVisitationFormModel({
    this.visitDate = '',
    this.durationOnARTs = '',
    this.height = '',
    this.mUAC = '',
    this.arvDrugsAdherence = '',
    this.arvDrugsDuration = '',
    this.adherenceCounseling = '',
    this.treatmentSupporter = '',
    this.treatmentSupporterSex = '',
    this.treatmentSupporterAge = '',
    this.treatmentSupporterHIVStatus = '',
    this.viralLoadResults = '',
    this.labInvestigationsDate = '',
    this.detectableViralLoadInterventions = '',
    this.disclosure = '',
    this.mUACScore = '',
    this.zScore = '',
    this.nutritionalSupport = const [],
    this.supportGroupStatus = '',
    this.nhifEnrollment = '',
    this.nhifEnrollmentStatus = '',
    this.referralServices = '',
    this.nextAppointmentDate = '',
    this.peerEducatorName = '',
    this.peerEducatorContact = '',
  });

  Map<String, dynamic> toJson() {
    // List<dynamic>? nutritionalSupportList = nutritionalSupport.toList();

    String nutritionalSupportList = nutritionalSupport.map((item) => "'$item'").join(',');

    return {
      'HIV_MGMT_2_A': visitDate,
      'HIV_MGMT_2_B': durationOnARTs,
      'HIV_MGMT_2_C': height,
      'HIV_MGMT_2_D': mUAC,
      'HIV_MGMT_2_E': arvDrugsAdherence,
      'HIV_MGMT_2_F': arvDrugsDuration,
      'HIV_MGMT_2_G': adherenceCounseling,
      'HIV_MGMT_2_H_2': treatmentSupporter,
      'HIV_MGMT_2_H_3': treatmentSupporterSex,
      'HIV_MGMT_2_H_4': treatmentSupporterAge,
      'HIV_MGMT_2_H_5': treatmentSupporterHIVStatus,
      'HIV_MGMT_2_I_1': viralLoadResults,
      'HIV_MGMT_2_I_DATE': labInvestigationsDate,
      'HIV_MGMT_2_J': detectableViralLoadInterventions,
      'HIV_MGMT_2_K': disclosure,
      'HIV_MGMT_2_L_1': mUACScore,
      'HIV_MGMT_2_L_2': zScore,
      'HIV_MGMT_2_M': nutritionalSupportList,
      'HIV_MGMT_2_N': supportGroupStatus,
      'HIV_MGMT_2_O_1': nhifEnrollment,
      'HIV_MGMT_2_O_2': nhifEnrollmentStatus,
      'HIV_MGMT_2_P': referralServices,
      'HIV_MGMT_2_Q': nextAppointmentDate,
      'HIV_MGMT_2_R': peerEducatorName,
      'HIV_MGMT_2_S': peerEducatorContact,
    };
  }

  factory HIVVisitationFormModel.fromJson(Map<String, dynamic> json) {
    // Set<String> nutritionalSupport = (json['HIV_MGMT_2_M'] as List<dynamic>)
    //     .map((e) => e.toString())
    //     .toSet();

    String nutritionalSupportString = json['HIV_MGMT_2_M'] ?? '';

    List<String> nutritionalSupportList = nutritionalSupportString.split(',');


    return HIVVisitationFormModel(
      visitDate: json['HIV_MGMT_2_A'] ?? '',
      durationOnARTs: json['HIV_MGMT_2_B'] ?? '',
      height: json['HIV_MGMT_2_C'] ?? '',
      mUAC: json['HIV_MGMT_2_D'] ?? '',
      arvDrugsAdherence: json['HIV_MGMT_2_E'] ?? '',
      arvDrugsDuration: json['HIV_MGMT_2_F'] ?? '',
      adherenceCounseling: json['HIV_MGMT_2_G'] ?? '',
      treatmentSupporter: json['HIV_MGMT_2_H_2'] ?? '',
      treatmentSupporterSex: json['HIV_MGMT_2_H_3'] ?? '',
      treatmentSupporterAge: json['HIV_MGMT_2_H_4'] ?? '',
      treatmentSupporterHIVStatus: json['HIV_MGMT_2_H_5'] ?? '',
      viralLoadResults: json['HIV_MGMT_2_I_1'] ?? '',
      labInvestigationsDate: json['HIV_MGMT_2_I_DATE'] ?? '',
      detectableViralLoadInterventions: json['HIV_MGMT_2_J'] ?? '',
      disclosure: json['HIV_MGMT_2_K'] ?? '',
      mUACScore: json['HIV_MGMT_2_L_1'] ?? '',
      zScore: json['HIV_MGMT_2_L_2'] ?? '',
      nutritionalSupport: nutritionalSupportList,
      supportGroupStatus: json['HIV_MGMT_2_N'] ?? '',
      nhifEnrollment: json['HIV_MGMT_2_O_1'] ?? '',
      nhifEnrollmentStatus: json['HIV_MGMT_2_O_2'] ?? '',
      referralServices: json['HIV_MGMT_2_P'] ?? '',
      nextAppointmentDate: json['HIV_MGMT_2_Q'] ?? '',
      peerEducatorName: json['HIV_MGMT_2_R'] ?? '',
      peerEducatorContact: json['HIV_MGMT_2_S'] ?? '',
    );
  }
}

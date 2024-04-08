import 'dart:convert';

class HivManagementFormModel {
  final String dateOfEvent;
  String dateHIVConfirmedPositive;
  String dateTreatmentInitiated;
  String baselineHEILoad;
  String dateStartedFirstLine;
  String arvsSubWithFirstLine;
  String arvsSubWithFirstLineDate;
  String switchToSecondLine;
  String switchToSecondLineDate;
  String switchToThirdLine;
  String switchToThirdLineDate;
  String visitDate;
  String durationOnARTs;
  String height;
  String mUAC;
  String arvDrugsAdherence;
  String arvDrugsDuration;
  String adherenceCounseling;
  String treatmentSupporter;
  String treatmentSupporterSex;
  String treatmentSupporterAge;
  String treatmentSupporterHIVStatus;
  String viralLoadResults;
  String labInvestigationsDate;
  String detectableViralLoadInterventions;
  String disclosure;
  String mUACScore;
  String zScore;
  List<String> nutritionalSupport;
  String supportGroupStatus;
  String nhifEnrollment;
  String nhifEnrollmentStatus;
  String referralServices;
  String nextAppointmentDate;
  String peerEducatorName;
  String peerEducatorContact;

  HivManagementFormModel({
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
    String nutritionalSupportList =
        nutritionalSupport.map((item) => "'$item'").join(',');

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

  factory HivManagementFormModel.fromJson(Map<String, dynamic> json) {
    String nutritionalSupportString = json['HIV_MGMT_2_M'] ?? '';

    List<String> nutritionalSupportList = nutritionalSupportString.split(',');

    return HivManagementFormModel(
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

  HivManagementFormModel copyWith({
    String? dateOfEvent,
    String? dateHIVConfirmedPositive,
    String? dateTreatmentInitiated,
    String? baselineHEILoad,
    String? dateStartedFirstLine,
    String? arvsSubWithFirstLine,
    String? arvsSubWithFirstLineDate,
    String? switchToSecondLine,
    String? switchToSecondLineDate,
    String? switchToThirdLine,
    String? switchToThirdLineDate,
    String? visitDate,
    String? durationOnARTs,
    String? height,
    String? mUAC,
    String? arvDrugsAdherence,
    String? arvDrugsDuration,
    String? adherenceCounseling,
    String? treatmentSupporter,
    String? treatmentSupporterSex,
    String? treatmentSupporterAge,
    String? treatmentSupporterHIVStatus,
    String? viralLoadResults,
    String? labInvestigationsDate,
    String? detectableViralLoadInterventions,
    String? disclosure,
    String? mUACScore,
    String? zScore,
    List<String>? nutritionalSupport,
    String? supportGroupStatus,
    String? nhifEnrollment,
    String? nhifEnrollmentStatus,
    String? referralServices,
    String? nextAppointmentDate,
    String? peerEducatorName,
    String? peerEducatorContact,
  }) {
    return HivManagementFormModel(
      dateOfEvent: dateOfEvent ?? this.dateOfEvent,
      dateHIVConfirmedPositive: dateHIVConfirmedPositive ?? this.dateHIVConfirmedPositive,
      dateTreatmentInitiated: dateTreatmentInitiated ?? this.dateTreatmentInitiated,
      baselineHEILoad: baselineHEILoad ?? this.baselineHEILoad,
      dateStartedFirstLine: dateStartedFirstLine ?? this.dateStartedFirstLine,
      arvsSubWithFirstLine: arvsSubWithFirstLine ?? this.arvsSubWithFirstLine,
      arvsSubWithFirstLineDate: arvsSubWithFirstLineDate ?? this.arvsSubWithFirstLineDate,
      switchToSecondLine: switchToSecondLine ?? this.switchToSecondLine,
      switchToSecondLineDate: switchToSecondLineDate ?? this.switchToSecondLineDate,
      switchToThirdLine: switchToThirdLine ?? this.switchToThirdLine,
      switchToThirdLineDate: switchToThirdLineDate ?? this.switchToThirdLineDate,
      visitDate: visitDate ?? this.visitDate,
      durationOnARTs: durationOnARTs ?? this.durationOnARTs,
      height: height ?? this.height,
      mUAC: mUAC ?? this.mUAC,
      arvDrugsAdherence: arvDrugsAdherence ?? this.arvDrugsAdherence,
      arvDrugsDuration: arvDrugsDuration ?? this.arvDrugsDuration,
      adherenceCounseling: adherenceCounseling ?? this.adherenceCounseling,
      treatmentSupporter: treatmentSupporter ?? this.treatmentSupporter,
      treatmentSupporterSex: treatmentSupporterSex ?? this.treatmentSupporterSex,
      treatmentSupporterAge: treatmentSupporterAge ?? this.treatmentSupporterAge,
      treatmentSupporterHIVStatus: treatmentSupporterHIVStatus ?? this.treatmentSupporterHIVStatus,
      viralLoadResults: viralLoadResults ?? this.viralLoadResults,
      labInvestigationsDate: labInvestigationsDate ?? this.labInvestigationsDate,
      detectableViralLoadInterventions: detectableViralLoadInterventions ?? this.detectableViralLoadInterventions,
      disclosure: disclosure ?? this.disclosure,
      mUACScore: mUACScore ?? this.mUACScore,
      zScore: zScore ?? this.zScore,
      nutritionalSupport: nutritionalSupport ?? this.nutritionalSupport,
      supportGroupStatus: supportGroupStatus ?? this.supportGroupStatus,
      nhifEnrollment: nhifEnrollment ?? this.nhifEnrollment,
      nhifEnrollmentStatus: nhifEnrollmentStatus ?? this.nhifEnrollmentStatus,
      referralServices: referralServices ?? this.referralServices,
      nextAppointmentDate: nextAppointmentDate ?? this.nextAppointmentDate,
      peerEducatorName: peerEducatorName ?? this.peerEducatorName,
      peerEducatorContact: peerEducatorContact ?? this.peerEducatorContact,
    );
  }
}

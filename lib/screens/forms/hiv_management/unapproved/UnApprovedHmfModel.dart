import '../../../../utils/app_form_metadata.dart';
import '../models/hiv_management_form_model.dart';

class UnApprovedHivManagementForm extends HivManagementFormModel {
  final String? message;
  final String? ovcCpimsId;
  final String? caregiverCpimsId;
  final String? adherenceId;
  final AppFormMetaData appFormMetaData;

  UnApprovedHivManagementForm({
    this.message,
    this.ovcCpimsId,
    this.caregiverCpimsId,
    this.adherenceId,
    required this.appFormMetaData,
    String dateOfEvent = '',
    String dateHIVConfirmedPositive = '',
    String dateTreatmentInitiated = '',
    String baselineHEILoad = '',
    String dateStartedFirstLine = '',
    String arvsSubWithFirstLine = '',
    String arvsSubWithFirstLineDate = '',
    String switchToSecondLine = '',
    String switchToSecondLineDate = '',
    String switchToThirdLine = '',
    String switchToThirdLineDate = '',
    String visitDate = '',
    String durationOnARTs = '',
    String height = '',
    String mUAC = '',
    String arvDrugsAdherence = '',
    String arvDrugsDuration = '',
    String adherenceCounseling = '',
    String treatmentSupporter = '',
    String treatmentSupporterSex = '',
    String treatmentSupporterAge = '',
    String treatmentSupporterHIVStatus = '',
    String viralLoadResults = '',
    String labInvestigationsDate = '',
    String detectableViralLoadInterventions = '',
    String disclosure = '',
    String mUACScore = '',
    String zScore = '',
    List<String> nutritionalSupport = const [],
    String supportGroupStatus = '',
    String nhifEnrollment = '',
    String nhifEnrollmentStatus = '',
    String referralServices = '',
    String nextAppointmentDate = '',
    String peerEducatorName = '',
    String peerEducatorContact = '',
  }) : super(
          dateOfEvent: dateOfEvent,
          dateHIVConfirmedPositive: dateHIVConfirmedPositive,
          dateTreatmentInitiated: dateTreatmentInitiated,
          baselineHEILoad: baselineHEILoad,
          dateStartedFirstLine: dateStartedFirstLine,
          arvsSubWithFirstLine: arvsSubWithFirstLine,
          arvsSubWithFirstLineDate: arvsSubWithFirstLineDate,
          switchToSecondLine: switchToSecondLine,
          switchToSecondLineDate: switchToSecondLineDate,
          switchToThirdLine: switchToThirdLine,
          switchToThirdLineDate: switchToThirdLineDate,
          visitDate: visitDate,
          durationOnARTs: durationOnARTs,
          height: height,
          mUAC: mUAC,
          arvDrugsAdherence: arvDrugsAdherence,
          arvDrugsDuration: arvDrugsDuration,
          adherenceCounseling: adherenceCounseling,
          treatmentSupporter: treatmentSupporter,
          treatmentSupporterSex: treatmentSupporterSex,
          treatmentSupporterAge: treatmentSupporterAge,
          treatmentSupporterHIVStatus: treatmentSupporterHIVStatus,
          viralLoadResults: viralLoadResults,
          labInvestigationsDate: labInvestigationsDate,
          detectableViralLoadInterventions: detectableViralLoadInterventions,
          disclosure: disclosure,
          mUACScore: mUACScore,
          zScore: zScore,
          nutritionalSupport: nutritionalSupport,
          supportGroupStatus: supportGroupStatus,
          nhifEnrollment: nhifEnrollment,
          nhifEnrollmentStatus: nhifEnrollmentStatus,
          referralServices: referralServices,
          nextAppointmentDate: nextAppointmentDate,
          peerEducatorName: peerEducatorName,
          peerEducatorContact: peerEducatorContact,
        );

  factory UnApprovedHivManagementForm.fromJson(Map<String, dynamic> json) {
    final appFormMetaData = AppFormMetaData.fromJson(json['app_form_metadata']);

    return UnApprovedHivManagementForm(
      message: json['message'] ?? '',
      ovcCpimsId: json['ovc_cpims_id'].toString(),
      caregiverCpimsId: json['caregiver_cpims_id'] ?? '',
      adherenceId: json['adherence_id'],
      appFormMetaData: appFormMetaData,
      dateHIVConfirmedPositive: json['HIV_MGMT_1_A'],
      dateTreatmentInitiated: json['HIV_MGMT_1_B'],
      baselineHEILoad: json['HIV_MGMT_1_C'],
      dateStartedFirstLine: json['HIV_MGMT_1_D'],
      arvsSubWithFirstLine: json['HIV_MGMT_1_E'].toString(),
      arvsSubWithFirstLineDate: json['HIV_MGMT_1_E_DATE'],
      switchToSecondLine: json['HIV_MGMT_1_F'].toString(),
      switchToSecondLineDate: json['HIV_MGMT_1_F_DATE'],
      switchToThirdLine: json['HIV_MGMT_1_G'].toString(),
      switchToThirdLineDate: json['HIV_MGMT_1_G_DATE'],
      visitDate: json['HIV_MGMT_2_A'],
      durationOnARTs: json['HIV_MGMT_2_B'],
      height: json['HIV_MGMT_2_C'],
      mUAC: json['HIV_MGMT_2_D'] ?? "",
      arvDrugsAdherence: json['HIV_MGMT_2_E'],
      arvDrugsDuration: json['HIV_MGMT_2_F'],
      adherenceCounseling: json['HIV_MGMT_2_G'],
      treatmentSupporter: json['HIV_MGMT_2_H_2'],
      treatmentSupporterSex: json['HIV_MGMT_2_H_3'],
      treatmentSupporterAge: json['HIV_MGMT_2_H_4'],
      treatmentSupporterHIVStatus: json['HIV_MGMT_2_H_5'],
      viralLoadResults: json['HIV_MGMT_2_I_1'],
      labInvestigationsDate: json['HIV_MGMT_2_I_DATE'],
      detectableViralLoadInterventions: json['HIV_MGMT_2_J'],
      disclosure: json['HIV_MGMT_2_K'],
      mUACScore: json['HIV_MGMT_2_L_1'],
      zScore: json['HIV_MGMT_2_L_2'],
      nutritionalSupport: json['HIV_MGMT_2_M']
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .split(',')
          .map((item) => item.trim().replaceAll("'", ""))
          .toList(),
      supportGroupStatus: json['HIV_MGMT_2_N'],
      nhifEnrollment: json['HIV_MGMT_2_O_1'].toString(),
      nhifEnrollmentStatus: json['HIV_MGMT_2_O_2'],
      referralServices: json['HIV_MGMT_2_P'],
      nextAppointmentDate: json['HIV_MGMT_2_Q'],
      peerEducatorName: json['HIV_MGMT_2_R'],
      peerEducatorContact: json['HIV_MGMT_2_S'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['message'] = message;
    data['ovc_cpims_id'] = ovcCpimsId;
    data['caregiver_cpims_id'] = caregiverCpimsId;
    data['adherence_id'] = adherenceId;
    data['app_form_metadata'] = appFormMetaData.toJson();
    return data;
  }
}

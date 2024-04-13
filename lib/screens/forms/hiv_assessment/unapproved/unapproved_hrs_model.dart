import 'package:cpims_mobile/screens/forms/hiv_assessment/unapproved/hiv_risk_assessment_form_model.dart';

class UnapprovedHrsModel extends RiskAssessmentFormModel {
  final String? message;
  final String? ovcCpimsId;
  final String? riskId;

  UnapprovedHrsModel({
    this.message,
    this.ovcCpimsId,
    this.riskId,
    String formUuid = '',
    String dateOfAssessment = '',
    String statusOfChild = '',
    String hivStatus = '',
    String hivTestDone = '',
    String biologicalFather = '',
    String malnourished = '',
    String sexualAbuse = '',
    String sexualAbuseAdolescent = '',
    String traditionalProcedures = '',
    String persistentlySick = '',
    String tb = '',
    String sexualIntercourse = '',
    String symptomsOfSTI = '',
    String ivDrugUser = '',
    String finalEvaluation = '',
    String parentAcceptHivTesting = '',
    String parentAcceptHivTestingDate = '',
    String formalReferralMade = '',
    String formalReferralMadeDate = '',
    String formalReferralCompleted = '',
    String formalReferralCompletedDate = '',
    String reasonForNotMakingReferral = '',
    String hivTestResult = '',
    String referredForArt = '',
    String referredForArtDate = '',
    String artReferralCompleted = '',
    String artReferralCompletedDate = '',
    String facilityOfArtEnrollment = '',
  }) : super(
            formUuid: formUuid,
            dateOfAssessment: dateOfAssessment,
            statusOfChild: statusOfChild,
            hivStatus: hivStatus,
            hivTestDone: hivTestDone,
            biologicalFather: biologicalFather,
            malnourished: malnourished,
            sexualAbuse: sexualAbuse,
            sexualAbuseAdolescent: sexualAbuseAdolescent,
            traditionalProcedures: traditionalProcedures,
            persistentlySick: persistentlySick,
            tb: tb,
            sexualIntercourse: sexualIntercourse,
            symptomsOfSTI: symptomsOfSTI,
            ivDrugUser: ivDrugUser,
            finalEvaluation: finalEvaluation,
            parentAcceptHivTesting: parentAcceptHivTesting,
            parentAcceptHivTestingDate: parentAcceptHivTestingDate,
            formalReferralMade: formalReferralMade,
            formalReferralMadeDate: formalReferralMadeDate,
            formalReferralCompleted: formalReferralCompleted,
            formalReferralCompletedDate: formalReferralCompletedDate,
            reasonForNotMakingReferral: reasonForNotMakingReferral,
            hivTestResult: hivTestResult,
            referredForArt: referredForArt,
            referredForArtDate: referredForArtDate,
            artReferralCompleted: artReferralCompleted,
            artReferralCompletedDate: artReferralCompletedDate,
            facilityOfArtEnrollment: facilityOfArtEnrollment);

  factory UnapprovedHrsModel.fromJson(Map<String, dynamic> json) {
    return UnapprovedHrsModel(
      message: json['message'],
      ovcCpimsId: json['ovc_cpims_id'].toString(),
      riskId: json['risk_id'],
      formUuid: json['risk_id'] ?? '',
      dateOfAssessment: json['HIV_RA_1A'] ?? '',
      statusOfChild: json['HIV_RS_01'].toString(),
      hivStatus: json['HIV_RS_02'] ?? '',
      hivTestDone: json['HIV_RS_03'].toString(),
      biologicalFather: json['HIV_RS_04'].toString(),
      malnourished: json['HIV_RS_05'].toString(),
      sexualAbuse: json['HIV_RS_06'].toString(),
      sexualAbuseAdolescent: json['HIV_RS_09'] ?? '',
      traditionalProcedures: json['HIV_RS_06A'].toString(),
      persistentlySick: json['HIV_RS_07'] ?? '',
      tb: json['HIV_RS_08'] ?? '',
      sexualIntercourse: json['HIV_RS_10'] ?? '',
      symptomsOfSTI: json['HIV_RS_10A'] ?? '',
      ivDrugUser: json['HIV_RS_10B'] ?? '',
      finalEvaluation:
          json['HIV_RS_11'] == null ? '' : json['HIV_RS_11'].toString(),
      parentAcceptHivTesting:
          json['HIV_RS_14'] == null ? '' : json['HIV_RS_14'].toString(),
      parentAcceptHivTestingDate: json['HIV_RS_15'] ?? '',
      formalReferralMade:
          json['HIV_RS_16'] == null ? '' : json['HIV_RS_16'].toString(),
      formalReferralMadeDate: json['HIV_RS_17'] ?? '',
      formalReferralCompleted:
          json['HIV_RS_18'] == null ? '' : json['HIV_RS_18'].toString(),
      reasonForNotMakingReferral: json['HIV_RS_18A'] ?? '',
      hivTestResult: json['HIV_RS_18B'] ?? '',
      referredForArt:
          json['HIV_RS_21'] == null ? '' : json['HIV_RS_21'].toString(),
      referredForArtDate:
          json['HIV_RS_22'] == null ? '' : json['HIV_RS_22'].toString(),
      artReferralCompleted:
          json['HIV_RS_23'] == null ? '' : json['HIV_RS_23'].toString(),
      artReferralCompletedDate: json['HIV_RS_24'] ?? '',
      facilityOfArtEnrollment: json['HIV_RA_3Q6'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['message'] = message;
    data['ovc_cpims_id'] = ovcCpimsId;
    data['risk_id'] = riskId;
    return data;
  }
}

class RiskAssessmentFormModel {
  final String formUuid;
  late  String dateOfAssessment;
  late String statusOfChild;
  late String hivStatus;
  late String hivTestDone;

  late String biologicalFather;
  late String malnourished;
  late String sexualAbuse;
  late String sexualAbuseAdolescent;
  late String traditionalProcedures;
  late String persistentlySick;
  late String tb;
  late String sexualIntercourse;
  late String symptomsOfSTI;
  late String ivDrugUser;
  late String finalEvaluation;
  late String parentAcceptHivTesting;
  late String parentAcceptHivTestingDate;
  late String formalReferralMade;
  late String formalReferralMadeDate;
  late String formalReferralCompleted;
  late String formalReferralCompletedDate;
  late String reasonForNotMakingReferral;
  late String hivTestResult;
  late String referredForArt;
  late String referredForArtDate;
  late String artReferralCompleted;
  late String artReferralCompletedDate;
  late String facilityOfArtEnrollment;

  RiskAssessmentFormModel({
    this.formUuid = "",
    this.dateOfAssessment = "",
    this.statusOfChild = "",
    this.hivStatus = "",
    this.hivTestDone = "",
    this.biologicalFather = "",
    this.malnourished = "",
    this.sexualAbuse = "",
    this.sexualAbuseAdolescent = "",
    this.traditionalProcedures = "",
    this.persistentlySick = "",
    this.tb = "",
    this.sexualIntercourse = "",
    this.symptomsOfSTI = "",
    this.ivDrugUser = "",
    this.parentAcceptHivTesting = "",
    this.parentAcceptHivTestingDate = "",
    this.formalReferralMade = "",
    this.formalReferralMadeDate = "",
    this.formalReferralCompleted = "",
    this.formalReferralCompletedDate = "",
    this.reasonForNotMakingReferral = "",
    this.hivTestResult = "",
    this.referredForArt = "",
    this.referredForArtDate = "",
    this.artReferralCompleted = "",
    this.artReferralCompletedDate = "",
    this.facilityOfArtEnrollment = "",
    String? finalEvaluation,
  }): finalEvaluation = _calculateFinalEvaluation(
    biologicalFather,
    malnourished,
    sexualAbuse,
    sexualAbuseAdolescent,
    traditionalProcedures,
    persistentlySick,
    tb,
    sexualIntercourse,
    symptomsOfSTI,
    ivDrugUser,
  );

  static String _calculateFinalEvaluation(
      String biologicalFather,
      String malnourished,
      String sexualAbuse,
      String sexualAbuseAdolescent,
      String traditionalProcedures,
      String persistentlySick,
      String tb,
      String sexualIntercourse,
      String symptomsOfSTI,
      String ivDrugUser,
      ) {
    bool anyQuestionAnsweredYes = biologicalFather == "Yes" ||
        malnourished == "Yes" ||
        sexualAbuse == "Yes" ||
        sexualAbuseAdolescent == "Yes" ||
        traditionalProcedures == "Yes" ||
        persistentlySick == "Yes" ||
        tb == "Yes" ||
        sexualIntercourse == "Yes" ||
        symptomsOfSTI == "Yes" ||
        ivDrugUser == "Yes";

    return anyQuestionAnsweredYes ? "Yes" : "";
  }

  Map<String, dynamic> toJson() {
    return {
      'formUuid': formUuid,
      'HIV_RA_1A': dateOfAssessment,
      'HIV_RS_01': statusOfChild,
      'HIV_RS_02': hivStatus,
      'HIV_RS_03': hivTestDone,
      'HIV_RS_04': biologicalFather,
      'HIV_RS_05': malnourished,
      'HIV_RS_06': sexualAbuse,
      'HIV_RS_09': sexualAbuseAdolescent,
      'HIV_RS_06A': traditionalProcedures,
      'HIV_RS_07': persistentlySick,
      'HIV_RS_08': tb,
      'HIV_RS_10': sexualIntercourse,
      'HIV_RS_10A': symptomsOfSTI,
      'HIV_RS_10B': ivDrugUser,
      'HIV_RS_11': finalEvaluation,
      'HIV_RS_14': parentAcceptHivTesting,
      'HIV_RS_15': parentAcceptHivTestingDate,
      'HIV_RS_16': formalReferralMade,
      'HIV_RS_17': formalReferralMadeDate,
      'HIV_RS_18': formalReferralCompleted,
      'HIV_RS_18A': reasonForNotMakingReferral,
      'HIV_RS_18B': hivTestResult,
      'HIV_RS_21': referredForArt,
      'HIV_RS_22': referredForArtDate,
      'HIV_RS_23': artReferralCompleted,
      'HIV_RS_24': artReferralCompletedDate,
      'HIV_RA_3Q6': facilityOfArtEnrollment,
    };
  }

  RiskAssessmentFormModel copyWith({
    String? formUuid,
    String? dateOfAssessment,
    String? statusOfChild,
    String? hivStatus,
    String? hivTestDone,
    String? biologicalFather,
    String? malnourished,
    String? sexualAbuse,
    String? sexualAbuseAdolescent,
    String? traditionalProcedures,
    String? persistentlySick,
    String? tb,
    String? sexualIntercourse,
    String? symptomsOfSTI,
    String? ivDrugUser,
    String? finalEvaluation,
    String? parentAcceptHivTesting,
    String? parentAcceptHivTestingDate,
    String? formalReferralMade,
    String? formalReferralMadeDate,
    String? formalReferralCompleted,
    String? formalReferralCompletedDate,
    String? reasonForNotMakingReferral,
    String? hivTestResult,
    String? referredForArt,
    String? referredForArtDate,
    String? artReferralCompleted,
    String? artReferralCompletedDate,
    String? facilityOfArtEnrollment,
  }) {
    return RiskAssessmentFormModel(
      formUuid: formUuid ?? this.formUuid,
      dateOfAssessment: dateOfAssessment ?? this.dateOfAssessment,
      statusOfChild: statusOfChild ?? this.statusOfChild,
      hivStatus: hivStatus ?? this.hivStatus,
      hivTestDone: hivTestDone ?? this.hivTestDone,
      biologicalFather: biologicalFather ?? this.biologicalFather,
      malnourished: malnourished ?? this.malnourished,
      sexualAbuse: sexualAbuse ?? this.sexualAbuse,
      sexualAbuseAdolescent:
          sexualAbuseAdolescent ?? this.sexualAbuseAdolescent,
      traditionalProcedures:
          traditionalProcedures ?? this.traditionalProcedures,
      persistentlySick: persistentlySick ?? this.persistentlySick,
      tb: tb ?? this.tb,
      sexualIntercourse: sexualIntercourse ?? this.sexualIntercourse,
      symptomsOfSTI: symptomsOfSTI ?? this.symptomsOfSTI,
      ivDrugUser: ivDrugUser ?? this.ivDrugUser,
      finalEvaluation: finalEvaluation ?? this.finalEvaluation,
      parentAcceptHivTesting:
          parentAcceptHivTesting ?? this.parentAcceptHivTesting,
      parentAcceptHivTestingDate:
          parentAcceptHivTestingDate ?? this.parentAcceptHivTestingDate,
      formalReferralMade: formalReferralMade ?? this.formalReferralMade,
      formalReferralMadeDate:
          formalReferralMadeDate ?? this.formalReferralMadeDate,
      formalReferralCompleted:
          formalReferralCompleted ?? this.formalReferralCompleted,
      formalReferralCompletedDate:
          formalReferralCompletedDate ?? this.formalReferralCompletedDate,
      reasonForNotMakingReferral:
          reasonForNotMakingReferral ?? this.reasonForNotMakingReferral,
      hivTestResult: hivTestResult ?? this.hivTestResult,
      referredForArt: referredForArt ?? this.referredForArt,
      referredForArtDate: referredForArtDate ?? this.referredForArtDate,
      artReferralCompleted: artReferralCompleted ?? this.artReferralCompleted,
      artReferralCompletedDate:
          artReferralCompletedDate ?? this.artReferralCompletedDate,
      facilityOfArtEnrollment:
          facilityOfArtEnrollment ?? this.facilityOfArtEnrollment,
    );
  }
}




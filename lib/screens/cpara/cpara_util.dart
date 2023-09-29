import 'package:cpims_mobile/screens/cpara/model/cpara_question_ids.dart';

String convertOptionStandardFormat({required String text}){
  switch(text.toLowerCase()){
    case "n/a":
      return "ANNA";
    case "no":
      return "ANNO";
    case "yes":
      default:
        return "AYES";
  }
}

String convertQuestionIdsStandardFormat({required String text}){
  switch(text.trim()){
    case CparaQuestionIds.stableQuestion1:
      return "q22";
    case CparaQuestionIds.stableQuestion2:
      return "q23";
    case CparaQuestionIds.stableQuestion3:
      return "q24";
    case CparaQuestionIds.safeOverallQuestion1:
      return "qo8";
    case CparaQuestionIds.safeQuestion1:
      return "q25";
    case CparaQuestionIds.safeQuestion2:
      return "q26";
    case CparaQuestionIds.safeOverallQuestion2:
      return "qo9";
    case CparaQuestionIds.safeChildQuestion1:
      return "q27";
    case CparaQuestionIds.safeQuestion3:
      return "q28";
    case CparaQuestionIds.safeQuestion4:
      return "q29";
    case CparaQuestionIds.safeQuestion5:
      return "q30";
    case CparaQuestionIds.safeQuestion6:
      return "q31";
    case CparaQuestionIds.safeQuestion7:
      return "q32";
    case CparaQuestionIds.schooledOverallQuestion1:
      return "qo10";
    case CparaQuestionIds.schooledQuestion1:
      return "q33";
    case CparaQuestionIds.schooledQuestion2:
      return "q34";
    case CparaQuestionIds.schooledOverallQuestion2:
      return "qo11";
    case CparaQuestionIds.schooledQuestion3:
      return "q35";
    case CparaQuestionIds.schooledQuestion4:
      return "q36";
    case CparaQuestionIds.healthQuestion1:
      return "q1";
    case CparaQuestionIds.healthQuestion2:
      return "q2";
    case CparaQuestionIds.healthQuestion3:
      return "q3";
    case CparaQuestionIds.healthQuestion4:
      return "q4";
    case CparaQuestionIds.healthQuestion5:
      return "q5";
    case CparaQuestionIds.healthGoal2OverallQuestion1:
      return "qo1";
    case CparaQuestionIds.healthGoal2OverallQuestion2:
      return "q02";
    case CparaQuestionIds.healthGoal2Question1:
      return "q6";
    case CparaQuestionIds.healthGoal2Question2:
      return "q7";
    case CparaQuestionIds.healthGoal2Question3:
      return "q8";
    case CparaQuestionIds.healthGoal2OverallQuestion3:
      return "qo3";
    case CparaQuestionIds.healthGoal2Question4:
      return "q9";
    case CparaQuestionIds.healthGoal2Question5:
      return "q10";
    case CparaQuestionIds.healthGoal2Question6:
      return "q11";
    case CparaQuestionIds.healthGoal2OverallQuestion4:
      return "qo4";
    case CparaQuestionIds.healthGoal2Question7:
      return "q12";
    case CparaQuestionIds.healthGoal2Question8:
      return "q13";
    case CparaQuestionIds.healthGoal2Question9:
      return "q14";
    case CparaQuestionIds.healthGoal3OverallQuestion1:
      return "qo5";
    case CparaQuestionIds.healthGoal3ChildQuestion1:
      return "q15";
    case CparaQuestionIds.healthGoal3ChildQuestion2:
      return "q16";
    case CparaQuestionIds.healthGoal3ChildQuestion3:
      return "q17";
    case CparaQuestionIds.healthGoal4OverallQuestion1:
      return "qo6";
    case CparaQuestionIds.healthGoal4Question1:
      return "q18";
    case CparaQuestionIds.healthGoal4Question2:
      return "q19";
    case CparaQuestionIds.healthGoal4Question3:
      return "q20";
    case CparaQuestionIds.healthGoal4OverallQuestion2:
      return "qo7";
    case CparaQuestionIds.healthGoal4Question4:
      return "q21";
    case CparaQuestionIds.detailDateOfAssessment:
      return "qd1";
    case CparaQuestionIds.isThisFirstCasePlanAssessment:
      return "qd2";
    case CparaQuestionIds.previousCasePlanAssessment:
      return "qd3";
    case CparaQuestionIds.houseChildHeaded:
      return "qd4";
    case CparaQuestionIds.houseHoldHavingHivExposedInfant:
      return "qd5";
    case CparaQuestionIds.houseHoldHavingPregnantWoman:
      return "qd6";
    default:
      return "qd7";
  }
}

int scoreConversion({required String text}){
  switch(text.toLowerCase()){
    case "no":
      return 0;
    case "yes":
    case "n/a":
    default:
      return 1;
  }
}

String overallChildrenBenchmark({required List<String> childrenOptions}){
  String selectedOption = "yes";

  if(childrenOptions.isEmpty){
    return "no";
  }

  for(String option in childrenOptions){
    print("list : ${option}");
    if(option.toLowerCase() == "no" || option == "null"){
      return "no";
    }
  }

  return selectedOption;
}
import 'dart:convert';

import 'package:cpims_mobile/screens/cpara/model/cpara_question_ids.dart';
import 'package:cpims_mobile/screens/cpara/model/unnaproved_cpara_database_model.dart';
import 'package:flutter/foundation.dart';

String convertOptionStandardFormat({required String text}) {
  switch (text.toLowerCase()) {
    case "n/a":
      return "ANNA";
    case "no":
      return "ANNO";
    case "yes":
    default:
      return "AYES";
  }
}

String convertQuestionIdsStandardFormat({required String text}) {
  switch (text.trim()) {
    case CparaQuestionIds.stableQuestion1:
      return "CP22q";
    case CparaQuestionIds.stableQuestion2:
      return "CP23q";
    case CparaQuestionIds.stableQuestion3:
      return "CP24q";
    // case CparaQuestionIds.safeOverallQuestion1:
    //   return "qo8";
    case CparaQuestionIds.safeQuestion1:
      return "CP25q";
    case CparaQuestionIds.safeQuestion2:
      return "CP26q";
    // case CparaQuestionIds.safeOverallQuestion2:
    //   return "qo9";
    case CparaQuestionIds.safeChildQuestion1:
      return "CP27q";
    case CparaQuestionIds.safeQuestion3:
      return "CP28q";
    case CparaQuestionIds.safeQuestion4:
      return "CP29q";
    case CparaQuestionIds.safeQuestion5:
      return "CP30q";
    case CparaQuestionIds.safeQuestion6:
      return "CP31q";
    case CparaQuestionIds.safeQuestion7:
      return "CP32q";
    // case CparaQuestionIds.schooledOverallQuestion1:
    //   return "qo10";
    case CparaQuestionIds.schooledQuestion1:
      return "CP33q";
    case CparaQuestionIds.schooledQuestion2:
      return "CP34q";
    // case CparaQuestionIds.schooledOverallQuestion2:
    //   return "qo11";
    case CparaQuestionIds.schooledQuestion3:
      return "CP35q";
    case CparaQuestionIds.schooledQuestion4:
      return "CP36q";
    case CparaQuestionIds.healthQuestion1:
      return "CP1q";
    case CparaQuestionIds.healthQuestion2:
      return "CP2q";
    case CparaQuestionIds.healthQuestion3:
      return "CP3q";
    case CparaQuestionIds.healthQuestion4:
      return "CP4q";
    case CparaQuestionIds.healthQuestion5:
      return "CP5q";
    // case CparaQuestionIds.healthGoal2OverallQuestion1:
    //   return "qo1";
    // case CparaQuestionIds.healthGoal2OverallQuestion2:
    //   return "q02";
    case CparaQuestionIds.healthGoal2Question1:
      return "CP6q";
    case CparaQuestionIds.healthGoal2Question2:
      return "CP7q";
    case CparaQuestionIds.healthGoal2Question3:
      return "CP8q";
    // case CparaQuestionIds.healthGoal2OverallQuestion3:
    //   return "qo3";
    case CparaQuestionIds.healthGoal2Question4:
      return "CP9q";
    case CparaQuestionIds.healthGoal2Question5:
      return "CP10q";
    case CparaQuestionIds.healthGoal2Question6:
      return "CP11q";
    // case CparaQuestionIds.healthGoal2OverallQuestion4:
    //   return "qo4";
    case CparaQuestionIds.healthGoal2Question7:
      return "CP12q";
    case CparaQuestionIds.healthGoal2Question8:
      return "CP13q";
    case CparaQuestionIds.healthGoal2Question9:
      return "CP14q";
    // case CparaQuestionIds.healthGoal3OverallQuestion1:
    //   return "qo5";
    case CparaQuestionIds.healthGoal3ChildQuestion1:
      return "CP15q";
    case CparaQuestionIds.healthGoal3ChildQuestion2:
      return "CP16q";
    case CparaQuestionIds.healthGoal3ChildQuestion3:
      return "CP17q";
    // case CparaQuestionIds.healthGoal4OverallQuestion1:
    //   return "qo6";
    case CparaQuestionIds.healthGoal4Question1:
      return "CP18q";
    case CparaQuestionIds.healthGoal4Question2:
      return "CP19q";
    case CparaQuestionIds.healthGoal4Question3:
      return "CP20q";
    // case CparaQuestionIds.healthGoal4OverallQuestion2:
    //   return "qo7";
    case CparaQuestionIds.healthGoal4Question4:
      return "CP21q";
    case CparaQuestionIds.detailDateOfAssessment:
      return "qd1";
    case CparaQuestionIds.isThisFirstCasePlanAssessment:
      return "CP1d";
    case CparaQuestionIds.previousCasePlanAssessment:
      return "qd3";
    case CparaQuestionIds.houseChildHeaded:
      return "CP3d";
    case CparaQuestionIds.houseHoldHavingHivExposedInfant:
      return "CP4d";
    case CparaQuestionIds.houseHoldHavingPregnantWoman:
      return "CP5d";
    default:
      return "qd7";
  }
}

int scoreConversion({required String text}) {
  switch (text.toLowerCase()) {
    case "no":
      return 0;
    case "yes":
    case "n/a":
    default:
      return 1;
  }
}

// String overallChildrenBenchmark({required List<String> childrenOptions}){
//   String selectedOption = "yes";
//
//   if(childrenOptions.isEmpty){
//     return "no";
//   }
//
//   for(String option in childrenOptions){
//     print("list : ${option}");
//     if(option.toLowerCase() == "no" || option == "null"){
//       return "no";
//     }
//   }
//
//   return selectedOption;
// }

String overallChildrenBenchmark({required List<String> childrenOptions}) {
  if (childrenOptions.isEmpty) {
    return "yes";
  }

  for (String option in childrenOptions) {
    if (kDebugMode) {
      print("list : $option");
    }
    if (option.toLowerCase() != "yes") {
      return "no";
    }
  }

  return "yes";
}

List<UnapprovedCparaDatabase> listOfUnapprovedCparas({required String remoteData}){
  var unapprovedCparaRemoteData = '[{"form_id":8, "ovc_cpims_id": "67804874", "date_of_event": "2023-11-08", "questions": [{"questionid":"CP1d","answer":"AYES"}], "individual_questions": [{"childID": "5674321", "questionid":"CP1d","answer":"AYES"}], "scores": [{"b1": "1"}], "app_form_metadata": {"form_id": "3fhfgjjyu", "location_lat": "-0.422", "location_long":"34.76", "start_of_interview":"2023-11-07 15:53:54.935785","end_of_interview":"2023-11-07T15:54:29.973195","form_type":"cpara"}, "sub_population": [{"ovc_cpims_id":"4566776", "criteria":"double", "answer_id":"AYES"}], "message":"Poor record filling"}]';

  var decodedData = json.decode(unapprovedCparaRemoteData);
  // List<dynamic>.from(cparaForm.listOfSubOvcs.map((x) => x.toJson())),
  List<UnapprovedCparaDatabase> listOfUnaprovedCparas =  List<UnapprovedCparaDatabase>.from(decodedData.map((x) => UnapprovedCparaDatabase.fromJson(x)));
  return listOfUnaprovedCparas;
}
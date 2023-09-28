import 'package:cpims_mobile/screens/cpara/cpara_util.dart';
import 'package:cpims_mobile/screens/cpara/model/cpara_model.dart';
import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/model/health_model.dart';
import 'package:cpims_mobile/screens/cpara/model/safe_model.dart';
import 'package:cpims_mobile/screens/cpara/model/schooled_model.dart';
import 'package:cpims_mobile/screens/cpara/model/stable_model.dart';
import 'package:flutter/foundation.dart';

import '../../../Models/case_load_model.dart';

class CparaProvider extends ChangeNotifier {
  CparaModel? cparaModel;
  DetailModel? detailModel;
  HealthModel? healthModel;
  StableModel? stableModel;
  SafeModel? safeModel;
  SchooledModel? schooledModel;
  OvcSubPopulationModel? ovcSubPopulationModel;
  CaseLoadModel? caseLoadModel;
  List<CaseLoadModel> children = [];

  // Calculate schooled benchmark
  int schooledBenchmark() {
    int schooledBenchmark = 0;



    if (schooledModel?.question1 == "Yes" &&
            schooledModel?.question2 == "Yes" &&
            schooledModel?.question3 == "Yes" &&
            schooledModel?.question4 == "Yes" ||
        schooledModel?.question4 == "N/A") {
      schooledBenchmark = 1;
    } else {
      schooledBenchmark = 0;
    }
    return schooledBenchmark;
  }

  // Calculate healthy benchmark
  int healthyBenchmark() {
    int finalScore = 33;
    int benchmark1 = 0;
    int benchmark2 = 0;
    int benchmark3 = 0;
    int benchmark4 = 0;

    List<String> firstListOfQuestions = [];
    List<String> secondListOfQuestions = [];
    List<String> thirdListOfQuestions = [];

    // List<HealthChild> childrens = [];
    // childrens = healthModel?.childrenQuestions ?? childrens;
    //
    // for(HealthChild child in childrens){
    //   firstListOfQuestions.add(child.question1);
    //   secondListOfQuestions.add(child.question2);
    //   thirdListOfQuestions.add(child.question3);
    // }

    // enos implementation to avoid early initialization
    for(HealthChild child in healthModel?.childrenQuestions ?? []){
      // childQuestions.add(child.question1 ?? "No");
      firstListOfQuestions.add(child.question1);
      secondListOfQuestions.add(child.question2);
      thirdListOfQuestions.add(child.question3);
    }


// Health BenchMark 1 result
    if (healthModel?.question1 == "Yes" && (healthModel?.question2 == "Yes" ||
        healthModel?.question2 == "N/A") && (healthModel?.question3 == "Yes" ||
        healthModel?.question3 == "N/A") &&
            healthModel?.question4 == "Yes" &&
        (healthModel?.question5 == "Yes" ||
        healthModel?.question5 == "N/A")
            ) {
      benchmark1 = 1;
    } else {
      benchmark1 = 0;
    }

// Health BenchMark 2 result
    if (healthModel?.question6 == "Yes" && (healthModel?.question7 == "Yes" ||
        healthModel?.question7 == "N/A") &&
            healthModel?.question8 == "Yes" &&
            healthModel?.question9 == "N/A" &&
        (healthModel?.question10 == "Yes" ||
        healthModel?.question10 == "N/A") &&
            healthModel?.question11 == "Yes" &&
            healthModel?.question12 == "Yes" &&
        (healthModel?.question13 == "Yes" ||
        healthModel?.question13 == "N/A") && healthModel?.question14 == "Yes") {
      benchmark2 = 1;
    } else {
      benchmark2 = 0;
    }

// Health BenchMark 3 result
    if ( overallChildrenBenchmark(childrenOptions: firstListOfQuestions).toLowerCase() == "yes"
    && overallChildrenBenchmark(childrenOptions: secondListOfQuestions).toLowerCase() == "yes"
    && overallChildrenBenchmark(childrenOptions: thirdListOfQuestions).toLowerCase() == "yes") {
      benchmark3 = 1;
    } else {
      benchmark3 = 0;
    }

    // Health BenchMark 1 result
    if (healthModel?.question15 == "Yes" &&
            healthModel?.question16 == "Yes" &&
        (healthModel?.question17 == "N/A" ||
        healthModel?.question17 == "Yes") &&
            healthModel?.question18 == "Yes") {
      benchmark4 = 1;
    } else {
      benchmark4 = 0;
    }

    finalScore = benchmark1 + benchmark2 + benchmark3 + benchmark4;
    if (finalScore == 4) {
      finalScore = 4;
    } else if (finalScore == 3) {
      finalScore = 3;
    } else if (finalScore == 2) {
      finalScore = 2;
    } else if (finalScore == 1) {
      finalScore = 1;
    } else if (finalScore == 0) {
      finalScore = 0;
    }
    return finalScore;
  }

// Calculate stable benchmark
  int stableBenchMark() {
    int stableBenchmark = 0;
    if (stableModel?.question1 == "Yes" ||
        stableModel?.question1 == "N/A" && stableModel?.question2 == "Yes" ||
        stableModel?.question2 == "N/A" && stableModel?.question3 == "Yes") {
      stableBenchmark = 1;
    } else {
      stableBenchmark = 0;
    }
    return stableBenchmark;
  }

// Calculate safe benchmark
  int safeBenchMark() {
    int schooledBenchmark = 44;
    int benchmark1 = 0;
    int benchmark2 = 0;
    int benchmark3 = 0;

    List<String> childQuestions = [];

    for(SafeChild child in safeModel?.childrenQuestions ?? []){
      childQuestions.add(child.question1 ?? "No");
    }

    // bool isAllChildrenYes = overallChildrenBenchmark(childrenOptions: childQuestions).toLowerCase() == "yes";

    if (
    safeModel?.overallQuestion1 == "No" ||
    safeModel?.question1 == "Yes" &&
        safeModel?.question2 == "Yes" &&
        // safeModel?.question3 == "Yes" &&
        safeModel?.question4 == "Yes" &&
        safeModel?.question5 == "Yes" && overallChildrenBenchmark(childrenOptions: childQuestions).toLowerCase() == "yes") {
      benchmark1 = 1;
    } else {
      benchmark1 = 0;
    }

// Safe Benchmark 2 result
    if (safeModel?.question6 == "Yes" && safeModel?.question7 == "Yes") {
      benchmark2 = 1;
    } else {
      benchmark2 = 0;
    }

// Safe Benchmark 3 result
    if (safeModel?.question7 == "Yes") {
      benchmark3 = 1;
    } else {
      benchmark3 = 0;
    }

    schooledBenchmark = benchmark1 + benchmark2 + benchmark3;
    if (schooledBenchmark == 3) {
      schooledBenchmark = 3;
    } else if (schooledBenchmark == 2) {
      schooledBenchmark = 2;
    } else if (schooledBenchmark == 1) {
      schooledBenchmark = 1;
    } else if (schooledBenchmark == 0) {
      schooledBenchmark = 0;
    }
    return schooledBenchmark;
  }

// Calculate final benchmark
  int finalScore() {
    int finalBenchmarkScore = schooledBenchmark() + healthyBenchmark() + stableBenchMark() + safeBenchMark();

    return finalBenchmarkScore;
  }

// update cpara model
  void updateCparaModel(CparaModel cparaModel) {
    this.cparaModel = cparaModel;
    notifyListeners();
  }

  // update detail model
  void updateDetailModel(DetailModel detailModel) {
    this.detailModel = detailModel;
    notifyListeners();
  }

  // update health model
  void updateHealthModel(HealthModel healthModel) {
    this.healthModel = healthModel;
    notifyListeners();
  }

  // update stable model
  void updateStableModel(StableModel stableModel) {
    this.stableModel = stableModel;
    notifyListeners();
  }

  // update safe model
  void updateSafeModel(SafeModel safeModel) {
    this.safeModel = safeModel;
    notifyListeners();
  }

  // update schooled model
  void updateSchooledModel(SchooledModel schooledModel) {
    this.schooledModel = schooledModel;
    notifyListeners();
  }

  void updateOvcSubPopulationModel(OvcSubPopulationModel ovcSubPopulationModel) {
    this.ovcSubPopulationModel = ovcSubPopulationModel;
    notifyListeners();
  }

  void updateCaseLoadModel(CaseLoadModel caseLoadModel) {
    this.caseLoadModel = caseLoadModel;
    notifyListeners();
  }

  void updateChildren(List<CaseLoadModel> allChildren) {
    children =  allChildren
        .where((element) =>
    element.caregiverNames == caseLoadModel?.caregiverNames)
        .toList();
    notifyListeners();
  }

  void clearCparaProvider(){
    // cparaModel = null;
    // detailModel = null;
    // healthModel = null;
    // stableModel = null;
    // safeModel = null;
    // schooledModel = null;
    // // ovcSubPopulationModel = null;
    // // caseLoadModel = null;
    // // children = [];
    // notifyListeners();
  }
}

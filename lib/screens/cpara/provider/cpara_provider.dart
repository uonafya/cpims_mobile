import 'package:cpims_mobile/screens/cpara/cpara_util.dart';
import 'package:cpims_mobile/screens/cpara/model/cpara_model.dart';
import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/model/health_model.dart';
import 'package:cpims_mobile/screens/cpara/model/ovc_model.dart';
import 'package:cpims_mobile/screens/cpara/model/safe_model.dart';
import 'package:cpims_mobile/screens/cpara/model/schooled_model.dart';
import 'package:cpims_mobile/screens/cpara/model/stable_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../Models/case_load_model.dart';
import '../widgets/ovc_sub_population_form.dart';

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
  List<Map<CaseLoadModel, List<CheckboxQuestion>>>? ovcSubPopulations;
  List<SubOvcModel>? childModules;
  CparaOvcSubPopulation? cparaOvcSubPopulation;

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
    int finalScore = 0;
    int benchmark1 = 0;
    int benchmark2 = 0;
    int benchmark3 = 0;
    int benchmark4 = 0;

    List<String> firstListOfQuestions = [];
    List<String> secondListOfQuestions = [];
    List<String> thirdListOfQuestions = [];

    // enos implementation to avoid early initialization
    for (HealthChild child in healthModel?.childrenQuestions ?? []) {
      // childQuestions.add(child.question1 ?? "No");
      firstListOfQuestions.add(child.question1);
      secondListOfQuestions.add(child.question2);
      thirdListOfQuestions.add(child.question3);
    }

// Health BenchMark 1 result
    if (healthModel?.question1 == "Yes" &&
        (healthModel?.question2 == "Yes" || healthModel?.question2 == "N/A") &&
        (healthModel?.question3 == "Yes" || healthModel?.question3 == "N/A") &&
        healthModel?.question4 == "Yes" &&
        (healthModel?.question5 == "Yes" || healthModel?.question5 == "N/A")) {
      benchmark1 = 1;
      print("Benchmark 1: $benchmark1");
    } else {
      benchmark1 = 0;
      print("Benchmark 1 1: $benchmark1");
    }

// Health BenchMark 2 result
    if (healthModel?.question6 == "Yes" &&
        (healthModel?.question7 == "Yes" || healthModel?.question7 == "N/A") &&
        healthModel?.question8 == "Yes" &&
        healthModel?.question9 == "Yes" &&
        (healthModel?.question10 == "Yes" ||
            healthModel?.question10 == "N/A") &&
        healthModel?.question11 == "Yes" &&
        healthModel?.question12 == "Yes" &&
        (healthModel?.question13 == "Yes" ||
            healthModel?.question13 == "N/A") &&
        healthModel?.question14 == "Yes") {
      benchmark2 = 1;
      print("Benchmark 2: $benchmark2");
    } else {
      benchmark2 = 0;
      print("Benchmark 2 2: $benchmark2");
    }

// Health BenchMark 3 result
    if (overallChildrenBenchmark(childrenOptions: firstListOfQuestions).toLowerCase() == "yes" &&
        overallChildrenBenchmark(childrenOptions: secondListOfQuestions).toLowerCase() == "yes" &&
        overallChildrenBenchmark(childrenOptions: thirdListOfQuestions).toLowerCase() == "yes") {
      benchmark3 = 1;
      print("Benchmark 3: $benchmark3");
    } else {
      benchmark3 = 0;
      print("Benchmark 3 3: $benchmark3");
    }

    // Health BenchMark 1 result
    if (healthModel?.question15 == "Yes" &&
        healthModel?.question16 == "Yes" &&
        (healthModel?.question17 == "N/A" ||
            healthModel?.question17 == "Yes") &&
        healthModel?.question18 == "Yes") {
      benchmark4 = 1;
      print("Benchmark 4: $benchmark4");
    } else {
      benchmark4 = 0;
      print("Benchmark 4 4: $benchmark4");
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
    if ((stableModel?.question1 == "Yes" ||
        stableModel?.question1 == "N/A") && (stableModel?.question2 == "Yes" ||
        stableModel?.question2 == "N/A") && (stableModel?.question3 == "Yes")) {
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

    for (SafeChild child in safeModel?.childrenQuestions ?? []) {
      childQuestions.add(child.question1 ?? "No");
    }

    // bool isAllChildrenYes = overallChildrenBenchmark(childrenOptions: childQuestions).toLowerCase() == "yes";

    if (safeModel?.overallQuestion1 == "No" ||
        safeModel?.question1 == "Yes" &&
            safeModel?.question2 == "Yes" &&
            // safeModel?.question3 == "Yes" &&
            safeModel?.question4 == "Yes" &&
            safeModel?.question5 == "Yes" &&
            overallChildrenBenchmark(childrenOptions: childQuestions)
                    .toLowerCase() ==
                "yes") {
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
    int finalBenchmarkScore = schooledBenchmark() +
        healthyBenchmark() +
        stableBenchMark() +
        safeBenchMark();

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

  // update safe model
  void updateCparaOvcModel(CparaOvcSubPopulation cparaOvcSubPopulation) {
    this.cparaOvcSubPopulation = cparaOvcSubPopulation;
    notifyListeners();
  }

  // initialize cpara ovc questions
  void updateCparaOvcQuestions() {
    List<CparaOvcChild> cparaOvcChildren = [];
    // List<CaseLoadModel> models = context.read<CparaProvider>().children ?? [];
    // List<CaseLoadModel> models = children;
    for (CaseLoadModel model in children) {
      cparaOvcChildren.add(
        CparaOvcChild(
          ovcId: model.cpimsId ?? "",
          question1: "Orphans (double or Child headed)",
          question2: "At Risk Adolescent Girls andYoung Women (AGYW)?",
          answer1: false,
          answer2: false,
          name: "${model.ovcFirstName} ${model.ovcSurname}",
        ),
      );
    }
    CparaOvcSubPopulation current = CparaOvcSubPopulation(childrenQuestions: cparaOvcChildren);
    cparaOvcSubPopulation = current;
      notifyListeners();

  }

  // update schooled model
  void updateSchooledModel(SchooledModel schooledModel) {
    this.schooledModel = schooledModel;
    notifyListeners();
  }

  void updateOvcSubPopulationModel(
      OvcSubPopulationModel ovcSubPopulationModel) {
    this.ovcSubPopulationModel = ovcSubPopulationModel;
    notifyListeners();
  }

  void updateCaseLoadModel(CaseLoadModel caseLoadModel) {
    this.caseLoadModel = caseLoadModel;
    // updateChildren(allChildren);
    notifyListeners();
  }

  void updateChildren(List<CaseLoadModel> allChildren) {
    children = allChildren
        .where((element) =>
            element.caregiverNames == caseLoadModel?.caregiverNames)
        .toList();
    notifyListeners();
  }

  // update ovc subpopulation
  void updateOvcSubpopulation(List<Map<CaseLoadModel, List<CheckboxQuestion>>> ovcSubPopulations) {
    this.ovcSubPopulations = ovcSubPopulations;
    notifyListeners();
  }

  // update ovc subpopulation
  void updateOvcSubpopulation1(List<SubOvcModel> ovcSubPopulations) {
    childModules = ovcSubPopulations;
    notifyListeners();
  }

  // update ovc subpopulation
  void updateOvcSubpopulationQuestions({required String childId, required String questionId, required bool questionAnswer}) {
    List<Map<CaseLoadModel, List<CheckboxQuestion>>> empty  = [];
    late CaseLoadModel currentChildModel;
    List<CheckboxQuestion> currentQuestions = [];
    //todo: get the child with that id from list of children
    Map<CaseLoadModel, List<CheckboxQuestion>> child = (ovcSubPopulations ?? empty).where((element){

      return element.keys.first.cpimsId == childId;
    }).first;
    currentChildModel = child.keys.first;
    currentQuestions = child.values.first;
    // todo: retrieve the question with that question  id
    CheckboxQuestion question = child.values.first.where((element) {
      return element.questionID == questionId;
    }).first;
    CheckboxQuestion updatedQuestion = question.copyWith(isChecked: questionAnswer);
    int indexOfQuestion = currentQuestions.indexOf(question);
   for(var p in ovcSubPopulations ?? []){
     // if(p)
   }
    // currentQuestions[indexOfQuestion] = updatedQuestion;
    // currentQuestions.contains(updatedQuestion.questionID) ? currentQuestions[currentQuestions.indexWhere((v) => v == findString)] = replaceWith : currentQuestions;
    // List<CheckboxQuestion> updatedQuestions = currentQuestions.up;
    //todo:  update the questions with the passed answer then update the subpopulation
    // child.update(currentChildModel, (value) => currentQuestions);
    // int indexOfChild = (ovcSubPopulations ?? empty).indexOf(child);
    // List<Map<CaseLoadModel, List<CheckboxQuestion>>> updateChildQuestion  = [];
    // (ovcSubPopulations ?? empty)[indexOfChild] = child;
    notifyListeners();
  }

  // n
  void updateOvcSubpopulationQuestions1({required String childId, required String questionId, required bool questionAnswer}) {
    List<SubOvcModel> listOfOvc = childModules ?? [];
    List<SubOvcModel> newList = [];
    for(var k in listOfOvc){
      if(k.caseLoadModel.cpimsId == childId){
        List<CheckboxQuestion> qs = k.childQuestions;
        int indexQ = 0;
        for(var l in qs){
          if(l.questionID == questionId){
            indexQ = qs.indexOf(l);
          }
        }
        qs[indexQ] = qs[indexQ].copyWith(isChecked: questionAnswer);
        listOfOvc[listOfOvc.indexOf(k)] = k.copyWith(childQuestions: qs);
      }
      else{
        newList.add(k);
      }
    }
    notifyListeners();
  }

  void updateOvcSubpopulationQuestions2({
    required String childId,
    required String questionId,
    required bool questionAnswer,
  }) {
    List<SubOvcModel> listOfOvc = childModules ?? [];
    List<SubOvcModel> updatedList = []; // Create a new list for updates

    for (var k in listOfOvc) {
      if (k.caseLoadModel.cpimsId == childId) {
        List<CheckboxQuestion> qs = k.childQuestions;
        int indexQ = 0;
        for (var l in qs) {
          if (l.questionID == questionId) {
            indexQ = qs.indexOf(l);
          }
        }
        qs[indexQ] = qs[indexQ].copyWith(isChecked: questionAnswer);
        // Create a deep copy of the SubOvcModel with the updated questions
        SubOvcModel updatedSubOvcModel = k.copyWith(childQuestions: List.from(qs));
        updatedList.add(updatedSubOvcModel);
      } else {
        updatedList.add(k); // If it's not the targeted child, add the original SubOvcModel
      }
    }

    // Replace the original list with the updated list
    childModules = List.from(updatedList);

    notifyListeners();
  }


  void upKisumu1({required String childId,}){
    List<Map<CaseLoadModel, List<CheckboxQuestion>>> ovcSubPopulation = ovcSubPopulations ?? [];

    // Update a CheckboxQuestion by its text
    String questionTextToFind = "HEI";
    CheckboxQuestion updatedQuestion = CheckboxQuestion(question: "Updated Question 2", id: 3);

    for (var map in ovcSubPopulation) {
      if(map.keys.first.cpimsId == childId) {
        for (var entry in map.entries) {
          var questions = entry.value;

          for (int i = 0; i < questions.length; i++) {
            var question = questions[i];
            if (question.question == questionTextToFind) {
              questions[i] = updatedQuestion; // Update the question
              print("Updated question: ${updatedQuestion.question}");
            }
          }
        }
      }
    }
    notifyListeners();
  }


  void clearCparaProvider() {
    cparaModel = null;
    detailModel = null;
    healthModel = null;
    stableModel = null;
    safeModel = null;
    schooledModel = null;
    // ovcSubPopulationModel = null;
    // caseLoadModel = null;
    // children = [];
    notifyListeners();
  }
}

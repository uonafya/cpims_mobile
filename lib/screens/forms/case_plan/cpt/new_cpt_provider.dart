import 'package:cpims_mobile/screens/forms/case_plan/cpt/models/healthy_cpt_model.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/models/safe_cpt_model.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/models/stable_cpt_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../Models/case_load_model.dart';
import '../../../../Models/caseplan_form_model.dart';
import '../utils/case_plan_dummy_data.dart';
import 'models/schooled_cpt_model.dart';

class CptProvider extends ChangeNotifier {
  List csAllDomains = allDomains;

  List csDomainList = casePlanDomainList;
  List csGoalList = casePlanGoalList;
  List csNeedsList = casePlanNeedsList;
  List csPriorityActionList = casePlanPriorityActionList;
  List csServicesList = casePlanServiceList;

  //Goals
  List cpGoalsHealth = cp_goals_health;
  List cpGoalsStable = cp_goals_stable;
  List cpGoalsSchool = cp_goal_school;
  List cpGoalsSafe = cp_goal_safe;

  //Gaps
  List cpGapsHealth = cp_gaps_health;
  List cpGapsStable = cp_gaps_stable;
  List cpGapssSchool = cp_gaps_school;
  List cpGapssSafe = cp_gaps_safe;

  //priorities
  List cpPrioritiesHealth = cp_priorities_health;
  List cpPrioritiesStable = cp_priorities_stable;
  List cpPrioritiesSchool = cp_priorities_school;
  List cpPrioritiesSafe = cp_priorities_safe;

  //services
  List cpServicesHealth = cp_services_health;
  List cpServicesStable = cp_services_stable;
  List cpServicesSchool = cp_services_school;
  List cpServicesSafe = cp_services_safe;

  List csPersonsResponsibleList = cp_responsible;
  List csResultsList = casePlanResultsOptions;

  CasePlanHealthyModel? casePlanHealthyModel;
  CasePlanSafeModel? casePlanSafeModel;
  CasePlanschooledModel? casePlanschooledModel;
  CasePlanStableModel? casePlanStableModel;
  List<Map<String, dynamic>> servicesList = [];

  CaseLoadModel? caseLoadModel;

  CptSafeFormData? cptSafeFormData;
  CptStableFormData? cptStableFormData;
  CptschooledFormData? cptschooledFormData;
  CptHealthFormData? cptHealthFormData;
  CptHealthFormData get cptHealth => cptHealthFormData!;

  List<CptHealthFormData> cptHealthFormDataList = [];
  List<CptSafeFormData> cptSafeFormDataList = [];
  List<CptStableFormData> cptStableFormDataList = [];
  List<CptschooledFormData> cptschooledFormDataList = [];

  late CasePlanModel casePlanModel;

  void updateCptFormData(CptHealthFormData cptHealthFormData) {
    this.cptHealthFormData = cptHealthFormData;
    notifyListeners();
  }

  void updateCptSafeFormData(CptSafeFormData cptSafeFormData) {
    this.cptSafeFormData = cptSafeFormData;
    notifyListeners();
  }

  void updateCptStableFormData(CptStableFormData cptStableFormData) {
    this.cptStableFormData = cptStableFormData;
    notifyListeners();
  }

  void updateCptSchooledFormData(CptschooledFormData cptschooledFormData) {
    this.cptschooledFormData = cptschooledFormData;
    notifyListeners();
  }

  void updateDateOfCasePlan(String? dateOfCasePlan) {
    casePlanModel.dateOfEvent = dateOfCasePlan!;
    notifyListeners();
  }

  void clearProviderData() {
    casePlanHealthyModel = null;
    casePlanSafeModel = null;
    casePlanStableModel = null;
    casePlanschooledModel = null;
    cptSafeFormData = null;
    cptStableFormData = null;
    cptHealthFormData = null;
    cptschooledFormData = null;
    caseLoadModel = null;
    notifyListeners();
  }

  //Lists

  void updateCptList(CptHealthFormData formData) {
    cptHealthFormDataList.insert(0, formData);
    cptHealthFormData = null;
    notifyListeners();
  }

  void updateCptSafeList(CptSafeFormData formData) {
    cptSafeFormDataList.insert(0, formData);
    cptSafeFormData = null;
    notifyListeners();
  }

  void updateCptStableList(CptStableFormData formData) {
    cptStableFormDataList.insert(0, formData);
    cptStableFormData = null;
    notifyListeners();
  }

  void updateCptSchooledList(CptschooledFormData formData) {
    cptschooledFormDataList.insert(0, formData);
    cptschooledFormData = null;
    notifyListeners();
  }


  void updateDateOfCasePlanList(String? dateCPlan) {
    casePlanModel.dateOfEvent = dateCPlan!;
    notifyListeners();
  }

  void removeCptHealthList(CptHealthFormData formData) {
    cptHealthFormDataList
        .removeWhere((element) => element.goalId == formData.goalId);
    notifyListeners();
  }

  void removeCptSafeList(CptSafeFormData formData) {
    cptSafeFormDataList
        .removeWhere((element) => element.goalId == formData.goalId);
    notifyListeners();
  }

  void removeCptStableList(CptStableFormData formData) {
    cptStableFormDataList
        .removeWhere((element) => element.goalId == formData.goalId);
    notifyListeners();
  }

  void removeCptSchooledList(CptschooledFormData formData) {
    cptschooledFormDataList
        .removeWhere((element) => element.goalId == formData.goalId);
    notifyListeners();
  }
}

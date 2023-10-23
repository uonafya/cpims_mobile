import 'dart:convert';

import 'package:cpims_mobile/Models/caseplan_form_model.dart';
import 'package:cpims_mobile/screens/forms/case_plan/models/case_plan_main_model.dart';
import 'package:cpims_mobile/services/form_service.dart';
import 'package:cpims_mobile/widgets/custom_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/forms/case_plan/utils/case_plan_dummy_data.dart';

class CasePlanProvider extends ChangeNotifier {
  final CasePlanModelData _casePlanModelData = CasePlanModelData(
    selectedDomain: [],
    selectedServices: [],
    selectedPersonsResponsible: [],
    selectedGoal: [],
    selectedNeed: [],
    selectedPriorityAction: [],
    selectedResult: [],
    ovc_cpims_id: "",
    selectedDate: DateTime.now(),
  );

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

  CasePlanModelData get cpFormData => _casePlanModelData;

  void setFinalFormDataOvcId(String ovcCpimsId) {
    _casePlanModelData.ovc_cpims_id = ovcCpimsId;
    notifyListeners();
  }

  void setSelectedDOE(DateTime dateTime) {
    _casePlanModelData.selectedDate = dateTime;
    notifyListeners();
  }

  void setSelectedDomain(List<ValueItem> domain) {
    _casePlanModelData.selectedDomain.addAll(domain);
    notifyListeners();
  }

  void setSelectedGoal(List<ValueItem> goal) {
    _casePlanModelData.selectedGoal.addAll(goal);
    notifyListeners();
  }

  void setSelectedNeed(List<ValueItem> need) {
    _casePlanModelData.selectedNeed.addAll(need);
    notifyListeners();
  }

  void setSelectedPriorityAction(List<ValueItem> priorityAction) {
    _casePlanModelData.selectedPriorityAction.clear();
    _casePlanModelData.selectedPriorityAction.addAll(priorityAction);
    notifyListeners();
  }

  void setSelectedServicesList(List<ValueItem> services) {
    _casePlanModelData.selectedServices.addAll(services);
    notifyListeners();
  }

  void setSelectedPersonsList(List<ValueItem> persons) {
    _casePlanModelData.selectedPersonsResponsible.addAll(persons);
    notifyListeners();
  }

  void setSelectedResults(List<ValueItem> results) {
    _casePlanModelData.selectedResult.addAll(results);
    notifyListeners();
  }

  void setSelectedDateToBeCompleted(DateTime dateTime) {
    _casePlanModelData.selectedDateToBeCompleted = dateTime;
    notifyListeners();
  }

  void setSelectedReason(String reason) {
    _casePlanModelData.selectedReason = reason;
    notifyListeners();
  }

  List<String> generateServicesList() {
    List<String> servicesList = [];

    for (int i = 0; i < cpFormData.selectedServices.length; i++) {
      final service = cpFormData.selectedServices[i].value;
      servicesList.add(service!);
    }
    return servicesList;
  }

  List<String> generateResponsiblePersonList() {
    List<String> personsList = [];
    for (int i = 0; i < cpFormData.selectedPersonsResponsible.length; i++) {
      final persons = cpFormData.selectedPersonsResponsible[i].value;

      personsList.add(persons!);
    }
    return personsList;
  }

  Map<String, dynamic> generatePayload() {
    List<String> services = generateServicesList();
    List<String> responsibleId = generateResponsiblePersonList();
    String priorityId = "";
    String domainId = "";
    String goalId = "";
    String gapId = "";
    String resultsId = "";
    String reason_is = "";
    String completionDate = "";
    completionDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (_casePlanModelData.selectedPriorityAction.isNotEmpty) {
      priorityId = _casePlanModelData.selectedPriorityAction[0].value!;
    }
    if (_casePlanModelData.selectedDomain.isNotEmpty) {
      domainId = _casePlanModelData.selectedDomain[0].value!;
    }
    if (_casePlanModelData.selectedGoal.isNotEmpty) {
      goalId = _casePlanModelData.selectedGoal[0].value!;
    }
    if (_casePlanModelData.selectedNeed.isNotEmpty) {
      gapId = _casePlanModelData.selectedNeed[0].value!;
    }
    if (_casePlanModelData.selectedResult.isNotEmpty) {
      resultsId = _casePlanModelData.selectedResult[0].value!;
    }
    if(_casePlanModelData.selectedReason.isNotEmpty){
      reason_is = _casePlanModelData.selectedReason;
    }

    // print("goal --->${cpFormData.selectedGoal[0].value}");
    print("priority ---> ${_casePlanModelData.selectedPriorityAction}");
    print("goal ---> ${_casePlanModelData.selectedGoal}");
    print("domain ---> $domainId");
    print("gap ---> $gapId");
    print("results   ----> $resultsId");

    Map<String, dynamic> payload = {
      // 'ovc_cpims_id': cpFormData.ovc_cpims_id,
      'ovc_cpims_id': "1234",
      'date_of_event': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'services': [
        {
          'domain_id': domainId ?? String,
          'service_id': services,
          'goal_id': goalId,
          'gap_id': gapId,
          'priority_id': priorityId,
          'responsible_id': responsibleId,
          'results_id': resultsId,
          'reason_id': reason_is,
          'completion_date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        }
      ]
    };

    print("casePlan Payload------>$payload");
    return payload;
  }

  Future<bool> saveCasaPlanDataLocally() async {
    Map<String, dynamic> payload = generatePayload();

    print("case-plan payload:==========>$payload");
    bool isFormSaved = await CasePlanService.saveCasePlanLocal(
        CasePlanModel.fromJson(payload));
    print("Caseplan data is ${jsonEncode(CasePlanModel.fromJson(payload))}");

    if (isFormSaved == true) {
      resetFormData();
      CustomToastWidget.showToast("Saving...");

      notifyListeners();
    }

    return isFormSaved;
  }

  void resetFormData() {
    _casePlanModelData.selectedDomain.clear();
    _casePlanModelData.selectedServices.clear();
    _casePlanModelData.selectedPersonsResponsible.clear();
    _casePlanModelData.selectedGoal.clear();
    _casePlanModelData.selectedNeed.clear();
    _casePlanModelData.selectedPriorityAction.clear();
    _casePlanModelData.selectedResult.clear();
    _casePlanModelData.ovc_cpims_id = "";
    _casePlanModelData.selectedDate = DateTime.now();

    notifyListeners();
  }

  Future<void> handleSubmitToServer() async {
    var prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('access');
    String bearerAuth = "Bearer $accessToken";
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor());

    Map<String, dynamic> payload = generatePayload();

    try {
      var response = await dio.post("https://dev.cpims.net/api/form/CPT/",
          data: payload,
          options: Options(headers: {"Authorization": bearerAuth}));

      if (response.statusCode == 200) {
        debugPrint("Data sent to server was $payload");
        CustomToastWidget.showToast("Case Plan Saved Successfully");
      }
      print("Caseplan data is ${jsonEncode(CasePlanModel.fromJson(payload))}");
    } catch (e) {
      print("Error posting caseplan form $e");
    }
  }
}

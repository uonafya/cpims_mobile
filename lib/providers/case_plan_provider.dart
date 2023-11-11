import 'package:cpims_mobile/Models/caseplan_form_model.dart';
import 'package:cpims_mobile/screens/forms/case_plan/models/case_plan_main_model.dart';
import 'package:cpims_mobile/services/form_service.dart';
import 'package:cpims_mobile/widgets/custom_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:multi_dropdown/models/value_item.dart';
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
    ovcCpimsId: "",
    selectedDate: DateTime.now(),
    selectedDateToBeCompleted: DateTime.now(),
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
    _casePlanModelData.ovcCpimsId = ovcCpimsId;
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

  Map<String, dynamic> generatePayload(String ovcCpimsId) {
    List<String> services = generateServicesList();
    List<String> responsibleId = generateResponsiblePersonList();
    String priorityId = "";
    String domainId = "";
    String goalId = "";
    String gapId = "";
    String resultsId = "";
    String reasonIs = "";
    String completionDate = "";
    String dateOfCasePlan = "";
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
    if (_casePlanModelData.selectedReason.isNotEmpty) {
      reasonIs = _casePlanModelData.selectedReason;
    }
    dateOfCasePlan = _casePlanModelData.selectedDate.toString();
    completionDate = _casePlanModelData.selectedDateToBeCompleted.toString();

    if (kDebugMode) {
      print("priority ---> ${_casePlanModelData.selectedPriorityAction}");
    }
    if (kDebugMode) {
      print("goal ---> ${_casePlanModelData.selectedGoal}");
    }
    if (kDebugMode) {
      print("need ---> ${_casePlanModelData.selectedNeed}");
    }
    if (kDebugMode) {
      print("services ---> $services");
    }
    if (kDebugMode) {
      print("domain ---> $domainId");
    }
    if (kDebugMode) {
      print("gap ---> $gapId");
    }
    if (kDebugMode) {
      print("responsible ---> $responsibleId");
    }
    if (kDebugMode) {
      print("results   ----> $resultsId");
    }
    if (kDebugMode) {
      print("reason   ----> $reasonIs");
    }
    if (kDebugMode) {
      print("completion date   ----> $completionDate");
    }
    if (kDebugMode) {
      print("ovc cpims id   ----> $ovcCpimsId");
    }

    Map<String, dynamic> payload = {
      'ovc_cpims_id': ovcCpimsId,
      'date_of_event': dateOfCasePlan,
      'services': [
        {
          'domain_id': domainId,
          'service_id': services,
          'goal_id': goalId,
          'gap_id': gapId,
          'priority_id': priorityId,
          'responsible_id': responsibleId,
          'results_id': resultsId,
          'reason_id': reasonIs,
          'completion_date': completionDate
        }
      ]
    };
    if (kDebugMode) {
      print("casePlan Payload------>$payload");
    }
    return payload;
  }

  // Future<bool> saveCasePlanLocally(String ovcCpimsId) async {
  //   Map<String, dynamic> payload = generatePayload(ovcCpimsId);
  //
  //   bool isFormSaved = await CasePlanService.saveCasePlanLocal(
  //       CasePlanModel.fromJson(payload));
  //
  //   if (isFormSaved == true) {
  //     resetFormData();
  //     CustomToastWidget.showToast("Saving...");
  //     notifyListeners();
  //   }
  //
  //   return;
  // }

  void resetFormData() {
    _casePlanModelData.selectedDomain.clear();
    _casePlanModelData.selectedServices.clear();
    _casePlanModelData.selectedPersonsResponsible.clear();
    _casePlanModelData.selectedGoal.clear();
    _casePlanModelData.selectedNeed.clear();
    _casePlanModelData.selectedPriorityAction.clear();
    _casePlanModelData.selectedResult.clear();
    _casePlanModelData.ovcCpimsId = "";
    _casePlanModelData.selectedDate = DateTime.now();

    notifyListeners();
  }

// Future<void> handleSubmitToServer(String ovcCpimsId) async {
//   var prefs = await SharedPreferences.getInstance();
//   var accessToken = prefs.getString('access');
//   String bearerAuth = "Bearer $accessToken";
//   Dio dio = Dio();
//   dio.interceptors.add(LogInterceptor());
//
//   //caseplan from db
//   List<Map<String, dynamic>> maps = await CasePlanService.getCasePlanRecordLocal(ovcCpimsId);
//   List<CasePlanModel> casePlanList = [];
//   for (var map in maps) {
//     casePlanList.add(CasePlanModel.fromJson(map));
//   }
//   var payload = casePlanList[0].toJson();
//   print("caseplan payload is $payload");
//
//   try {
//     var response = await dio.post("https://dev.cpims.net/api/form/CPT/",
//         data: payload,
//         options: Options(headers: {"Authorization": bearerAuth}));
//
//     if (response.statusCode == 200) {
//       debugPrint("Data sent to server was $payload");
//       CustomToastWidget.showToast("Case Plan Saved Successfully");
//     }
//     print("Caseplan data is ${jsonEncode(CasePlanModel.fromJson(payload))}");
//   } catch (e) {
//     print("Error posting caseplan form $e");
//   }
// }
}

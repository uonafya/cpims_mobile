import 'package:cpims_mobile/Models/case_plan_form.dart';
import 'package:cpims_mobile/screens/forms/case_plan/models/case_plan_main_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
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
    ovc_cpims_id: "", selectedDate: DateTime.now(),

  );

  List csDomainList = casePlanDomainList;
  List csGoalList = casePlanGoalList;
  List csNeedsList = casePlanNeedsList;
  List csPriorityActionList = casePlanPriorityActionList;
  List csServicesList = casePlanServiceList;

  List csPersonsResponsibleList = casePlanPersonsResponsibleList;
  List csResultsList = casePlanResultsOptions;

  CasePlanModelData get cpFormData => _casePlanModelData;


  void setFinalFormDataOvcId(String ovc_cpims_id) {
    _casePlanModelData.ovc_cpims_id = ovc_cpims_id;
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

      servicesList.add(
         service!
      );
    }
    return servicesList;
  }

  List<String> generateResponsiblePersonList() {
    List<String> personsList = [];
    for (int i = 0; i < cpFormData.selectedPersonsResponsible.length; i++) {
      final persons = cpFormData.selectedPersonsResponsible[i].value;

      personsList.add(
          persons!
      );
    }
    return personsList;
  }

  void saveCasaPlanData() {
    List<String> services = generateServicesList();
    List<String> responsibleId = generateResponsiblePersonList();
    String priorityId = "";
    String domainId = "";
    String goalId = "";
    String gapId = "";
    String resultsId = "";
    String completionDate = "";
    completionDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if(cpFormData.selectedPriorityAction.isNotEmpty){
      priorityId = cpFormData.selectedPriorityAction[0].value!;
    }
    if(cpFormData.selectedDomain.isNotEmpty){
      domainId = cpFormData.selectedPriorityAction[0].value!;
    }
    if(cpFormData.selectedGoal.isNotEmpty){
      goalId = cpFormData.selectedGoal[0].value!;
    }
    if(cpFormData.selectedNeed.isNotEmpty){
      gapId = cpFormData.selectedNeed[0].value!;
    }
    if(cpFormData.selectedResult.isNotEmpty){
      resultsId = cpFormData.selectedResult[0].value!;
    }



    print("goal$goalId");
    print("goal$priorityId");
    print("goal$domainId");
    print("gap$gapId");
    print("payload$gapId");
    print("payload$resultsId");



    Map<String, dynamic> payload = {
      'ovc_cpims_id': cpFormData.ovc_cpims_id,
      'date_of_event': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'services': [
        {
          'domain_id': domainId,
          'service_id': services,
          'goal_id': goalId,
          'gap_id': gapId,
          'priority_id': priorityId,
          'responsible_id': responsibleId,
          'results_id': resultsId,
          'reason_id': '', // You can set this as needed
          'completion_date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        }
      ]
    };

    print("casePlan Payload$payload");

  }




}






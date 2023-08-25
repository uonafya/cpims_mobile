import 'package:cpims_mobile/Models/case_plan_form.dart';
import 'package:cpims_mobile/screens/forms/case_plan/models/case_plan_main_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_dropdown/models/value_item.dart';
import '../screens/forms/case_plan/utils/case_plan_dummy_data.dart';

class CasePlanProvider extends ChangeNotifier {
  final CasePlanModelData _casePlanModelData = CasePlanModelData();


  List csDomainList = casePlanDomainList;
  List csGoalList = casePlanGoalList;
  List csNeedsList = casePlanNeedsList;
  List csPriorityActionList = casePlanPriorityActionList;
  List csServicesList = casePlanServiceList;

  List csPersonsResponsibleList = casePlanPersonsResponsibleList;
  List csResultsList = casePlanResultsOptions;

  void setSelectedDate(DateTime dateTime){
    _casePlanModelData.selectedDate = dateTime;
    notifyListeners();
  }
  void setSelectedDomain(String domain){
    _casePlanModelData.selectedDomain = domain;
    notifyListeners();
  }
  void setSelectedGoal(String goal){
    _casePlanModelData.selectedGoal = goal;
    notifyListeners();
  }
  void setSelectedNeed(String need){
    _casePlanModelData.selectedNeed = need;
    notifyListeners();
  }
  void setSelectedPriorityAction(String priorityAction){
    _casePlanModelData.selectedPriorityAction = priorityAction;
    notifyListeners();
  }
  void setSelectedServicesList(List<ValueItem> services){
    _casePlanModelData.selectedServices = services;
    notifyListeners();
  }
  void setSelectedPersonsList(List<ValueItem> persons){
    _casePlanModelData.selectedPersonsResponsible = persons;
    notifyListeners();
  }
  void setSelectedResults(String results){
    _casePlanModelData.selectedResult = results;
    notifyListeners();
  }
  void setSelectedDateToBeCompleted(DateTime dateTime){
    _casePlanModelData.selectedDateToBeCompleted = dateTime;
    notifyListeners();
  }
  void setSelectedReason(String reason){
    _casePlanModelData.selectedReason = reason;
    notifyListeners();
  }




}

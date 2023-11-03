import 'package:multi_dropdown/models/value_item.dart';

class CasePlanModelData {
  late List<ValueItem> selectedServices;
  late List<ValueItem> selectedPersonsResponsible;
  late DateTime selectedDate;
  DateTime selectedDateToBeCompleted;
  late List<ValueItem> selectedDomain;

  late List<ValueItem> selectedGoal;

  late List<ValueItem> selectedNeed;

  late List<ValueItem> selectedPriorityAction;

  late List<ValueItem> selectedResult;

  String selectedReason = "";
  late String ovc_cpims_id;

  CasePlanModelData({
    required this.selectedDomain,
    required this.selectedServices,
    required this.selectedPersonsResponsible,
    required this.selectedGoal,
    required this.selectedNeed,
    required this.selectedPriorityAction,
    required this.selectedResult,
    required this.ovc_cpims_id,
    required this.selectedDate,
    required this.selectedDateToBeCompleted,
  });
}

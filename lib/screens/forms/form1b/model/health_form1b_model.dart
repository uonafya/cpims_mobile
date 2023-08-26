import 'package:multi_dropdown/models/value_item.dart';

class HealthFormData {
  late List<ValueItem> selectedServices;
  late List<ValueItem> personsResponsible;
  late DateTime selectedDate;
  late String domainId;
  late String goalId;
  late String needId;
  late String priorityActionId;
  late String resultId;
  late String reasons;

  HealthFormData({required this.selectedServices, required this.selectedDate, required this.domainId});
}
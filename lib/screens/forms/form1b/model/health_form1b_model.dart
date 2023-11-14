import 'package:multi_dropdown/models/value_item.dart';

class HealthFormData {
  late List<ValueItem> selectedServices;
  late List<ValueItem> personsResponsible;
  late String? selectedDate;
  late String domainId;
  late String goalId;
  late String needId;
  late String priorityActionId;
  late String resultId;
  late String reasons;

  HealthFormData(
      {required this.selectedServices,
      required this.selectedDate,
      required this.domainId,
      personsResponsible,
      goalId,
      needId,
      priorityActionId,
      resultId,
      reasons});

  Map<String, dynamic> toJson() {
    return {
      'selectedServices':
          selectedServices.map((item) => item.toJson()).toList(),
      'personsResponsible':
          personsResponsible.map((item) => item.toJson()).toList(),
      'selectedDate': selectedDate,
      'domainId': domainId,
      'goalId': goalId,
      'needId': needId,
      'priorityActionId': priorityActionId,
      'resultId': resultId,
      'reasons': reasons,
    };
  }

  factory HealthFormData.fromJson(Map<String, dynamic> json) {
    return HealthFormData(
      selectedServices: json['selectedServices']
          .map((item) => ValueItem.fromJson(item))
          .toList(),
      personsResponsible: json['personsResponsible']
          .map((item) => ValueItem.fromJson(item))
          .toList(),
      selectedDate: json['selectedDate'],
      domainId: json['domainId'],
      goalId: json['goalId'],
      needId: json['needId'],
      priorityActionId: json['priorityActionId'],
      resultId: json['resultId'],
      reasons: json['reasons'],
    );
  }

  @override
  String toString() {
    return 'HealthFormData{selectedServices: $selectedServices,  selectedDate: $selectedDate, domainId: $domainId}';
  }
}

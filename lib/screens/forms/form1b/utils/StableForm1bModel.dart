import 'package:multi_dropdown/models/value_item.dart';

class StableFormData {
  late final List<ValueItem> selectedServices;
  late String domainId;

  StableFormData({required this.selectedServices, required this.domainId});

  Map<String, dynamic> toJson() {
    return {
      'selectedServices': selectedServices.map((item) => item.toJson()).toList(),
      'domainId': domainId,
    };
  }

  factory StableFormData.fromJson(Map<String, dynamic> json) {
    return StableFormData(
      selectedServices: json['selectedServices'].map((item) => ValueItem.fromJson(item)).toList(),
      domainId: json['domainId'],
    );
  }

  @override
  String toString() {
    return 'StableFormData{selectedServices: $selectedServices, domainId: $domainId}';
  }
}

class SchooledFormData {
  late final List<ValueItem> selectedServices;
  late String domainId;

  SchooledFormData({required this.selectedServices, required this.domainId});
}

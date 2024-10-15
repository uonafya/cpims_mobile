import 'package:multi_dropdown/models/value_item.dart';

class SafeFormData {
  late final List<ValueItem> selectedServices;
  late String domainId;

  SafeFormData({required this.selectedServices, required this.domainId});

  Map<String, dynamic> toJson() {
    return {
      'selectedServices': selectedServices.map((item) => item.toJson()).toList(),
      'domainId': domainId,
    };
  }

  factory SafeFormData.fromJson(Map<String, dynamic> json) {
    return SafeFormData(
      selectedServices: json['selectedServices'].map((item) => ValueItem.fromJson(item)).toList(),
      domainId: json['domainId'],
    );
  }

  @override
  String toString() {
    return 'SafeFormData{selectedServices: $selectedServices, domainId: $domainId}';
  }
}

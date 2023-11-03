import 'package:multi_dropdown/models/value_item.dart';

class StableFormData {
  late final List<ValueItem> selectedServices;
  late String domainId;

  StableFormData({required this.selectedServices, required this.domainId});
}

class SchooledFormData {
  late final List<ValueItem> selectedServices;
  late String domainId;

  SchooledFormData({required this.selectedServices, required this.domainId});
}

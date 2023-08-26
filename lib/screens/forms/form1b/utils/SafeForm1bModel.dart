import 'package:multi_dropdown/models/value_item.dart';

class SafeFormData {
  late final List<ValueItem> selectedServices;
  late String domainId;

  SafeFormData({required this.selectedServices, required this.domainId});
}

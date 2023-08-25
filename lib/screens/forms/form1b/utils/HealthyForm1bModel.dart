import 'package:multi_dropdown/models/value_item.dart';

class HealthFormData {
  late List<ValueItem> selectedServices;
  late DateTime selectedDate;
  late String domainId ;

  HealthFormData({required this.selectedServices, required this.selectedDate, required this.domainId});
}
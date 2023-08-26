import 'package:flutter/material.dart';
import 'package:multi_dropdown/models/value_item.dart';

class CriticalFormDate {
  late List<ValueItem> selectedEvents;
  late DateTime selectedDate;
  late String domainId;

  CriticalFormDate({required this.selectedEvents, required this.selectedDate});
}

class Form1AProvider extends ChangeNotifier {
  void setSelectedEvents(List<ValueItem> selectedEvents) {
    notifyListeners();
  }
}

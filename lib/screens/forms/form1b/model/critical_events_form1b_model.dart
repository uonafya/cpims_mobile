import 'package:multi_dropdown/models/value_item.dart';

class CriticalEventDataForm1b {
  List<ValueItem> selectedEvents;
  String selectedDate;

  CriticalEventDataForm1b({required this.selectedEvents, required this.selectedDate});

  Map<String, dynamic> toJson() {
    return {
      'selectedEvents': selectedEvents.map((item) => item.toJson()).toList(),
      'selectedDate': selectedDate,
    };
  }

  factory CriticalEventDataForm1b.fromJson(Map<String, dynamic> json) {
    return CriticalEventDataForm1b(
      selectedEvents: json['selectedEvents'].map((item) => ValueItem.fromJson(item)).toList(),
      selectedDate: json['selectedDate'],
    );
  }

  @override
  String toString() {
    return 'CriticalEventDataForm1b{selectedEvents: $selectedEvents, selectedDate: $selectedDate}';
  }
}

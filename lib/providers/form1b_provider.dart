import 'package:flutter/material.dart';

class HealthFormData {
  late final List<String> selectedServices;
  late final DateTime selectedDate;

  HealthFormData({required this.selectedServices, required this.selectedDate});
}

class Form1bProvider extends ChangeNotifier {
  final HealthFormData _formData = HealthFormData(selectedServices: [], selectedDate: DateTime.now());

  HealthFormData get formData => _formData;

  void setSelectedServices(List<String> selectedServices) {
    _formData.selectedServices = selectedServices;
    notifyListeners();
  }

  void setSelectedDate(DateTime selectedDate) {
    _formData.selectedDate = selectedDate;
    notifyListeners();
  }
}

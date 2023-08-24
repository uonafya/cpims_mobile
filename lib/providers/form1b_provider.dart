import 'package:flutter/material.dart';

import '../widgets/custom_toast.dart';

class HealthFormData {
  late final List selectedServices;
  late final DateTime selectedDate;

  HealthFormData({required this.selectedServices, required this.selectedDate});
}

class Form1bProvider extends ChangeNotifier {
  final HealthFormData _formData = HealthFormData(
      selectedServices: [],
      selectedDate: DateTime.now()
  );

  HealthFormData get formData => _formData;

  void setSelectedServices(List selectedServices) {
    _formData.selectedServices.clear(); // Clear the current list
    _formData.selectedServices.addAll(selectedServices);
    notifyListeners();
  }

  void setSelectedDate(DateTime selectedDate) {
    _formData.selectedDate = selectedDate;
    notifyListeners();
  }


  bool _showToast = false;

  bool get showToast => _showToast;

  void saveData(String toastData) {
    // Save data logic
    CustomToastWidget.showToast('Data saved successfully!${toastData}');
    notifyListeners();
  }


}

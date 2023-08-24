import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/custom_toast.dart';

class HealthFormData {
  late final List selectedServices;
  late final String selectedDate;
  late final String domainId;


  HealthFormData({required this.selectedServices, required this.selectedDate});
}

class StableFormData {
  late final List selectedServices;
  late final String domainId;

  StableFormData({required this.selectedServices, required this.domainId});
}

class SafeFormData {
  late final List selectedServices;
  late final String domainId;

  SafeFormData({required this.selectedServices, required this.domainId});
}

class Form1bProvider extends ChangeNotifier {
  final HealthFormData _formData = HealthFormData(
      selectedServices: [],
      selectedDate: ""
  );

  HealthFormData get formData => _formData;

  void setSelectedServices(List selectedServices) {
    _formData.selectedServices.clear(); // Clear the current list
    _formData.selectedServices.addAll(selectedServices);
    notifyListeners();
  }

  void setSelectedDate(DateTime selectedDate) {
    // _formData.selectedDate = selectedDate;
    // CustomToastWidget.showToast(selectedDate);
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    _formData.selectedDate = formattedDate;
    notifyListeners();
  }

  void saveData(String toastData) {
    CustomToastWidget.showToast('Data saved successfuy!$toastData');
    notifyListeners();
  }


}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';
import '../widgets/custom_toast.dart';

class HealthFormData {
  late final List<ValueItem> selectedServices;
  late final String selectedDate;
  late final String domainId;


  HealthFormData({required this.selectedServices, required this.selectedDate});
}

class StableFormData {
  late final List<ValueItem> selectedServices;
  late final String domainId;

  StableFormData({required this.selectedServices, required this.domainId});
}

class SafeFormData {
  late final List selectedServices;
  late final String domainId;

  SafeFormData({required this.selectedServices, required this.domainId});
}

//this is the broken down list of the grouped domains
class MasterServicesFormData {
  late final String selectedServiceId;
  late final String domainId;

  MasterServicesFormData({required this.selectedServiceId, required this.domainId});
}



class Form1bProvider extends ChangeNotifier {
  final HealthFormData _formData = HealthFormData(
      selectedServices: [],
      selectedDate: ""
  );
  final StableFormData _stableFormData = StableFormData(
      selectedServices: [],
      domainId: ""
  );

  final SafeFormData _safeFormData = SafeFormData(
      selectedServices: [],
      domainId: ""
  );

  HealthFormData get formData => _formData;
  StableFormData get stableFormData => _stableFormData;
  SafeFormData get safeFormData => _safeFormData;

  void setSelectedServices(List<ValueItem> selectedServices) {
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

  void setStableFormData(List<ValueItem> selectedServices, String domainId){
    _stableFormData.selectedServices.clear();
    _stableFormData.selectedServices = selectedServices;
    _stableFormData.domainId= domainId;
  }

  void setSafeFormData(List selectedServices, String domainId){
    _safeFormData.selectedServices.clear();
    _safeFormData.selectedServices = selectedServices;
    _safeFormData.domainId= domainId;

  }

  void saveData(String toastData) {
    CustomToastWidget.showToast('Data saved successfuy!$toastData');
    notifyListeners();
  }


}

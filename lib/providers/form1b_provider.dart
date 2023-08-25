import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';
import '../widgets/custom_toast.dart';

class HealthFormData {
  late List<ValueItem> selectedServices;
  late DateTime selectedDate;
  late String domainId ;

  HealthFormData({required this.selectedServices, required this.selectedDate, required this.domainId});
}


class StableFormData {
  late final List<ValueItem> selectedServices;
  late final String domainId;

  StableFormData({required this.selectedServices, required this.domainId});
}
class SafeFormData {
  late final List<ValueItem> selectedServices;
  late final String domainId;

  SafeFormData({required this.selectedServices, required this.domainId});
}

//this is the broken down list of the grouped domains
class MasterServicesFormData {
  late final String? selectedServiceId;
  late final String domainId;
  late final String dateOfEvent;

  MasterServicesFormData({required this.selectedServiceId, required this.domainId, required this.dateOfEvent});
}







class Form1bProvider extends ChangeNotifier {
  final HealthFormData _formData = HealthFormData(
      selectedServices: [],
      selectedDate: DateTime.now(),
      domainId: '1234'
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

  void setSelectedServices(List<ValueItem> selectedServices, String domainId) {
    _formData.selectedServices.clear(); // Clear the current list
    _formData.selectedServices.addAll(selectedServices);
    _formData.domainId = domainId;
    notifyListeners();
  }

  void setSelectedSafeFormDataServices(List<ValueItem> selectedServices, String domainId) {
    _safeFormData.selectedServices.clear(); // Clear the current list
    _safeFormData.selectedServices.addAll(selectedServices);
    _safeFormData.domainId = domainId;
    notifyListeners();
  }

  void setSelectedStableFormDataServices(List<ValueItem> selectedServices, String domainId) {
    _stableFormData.selectedServices.clear(); // Clear the current list
    _stableFormData.selectedServices.addAll(selectedServices);
    _stableFormData.domainId = domainId;
    notifyListeners();
  }
  void setSelectedDate(DateTime selectedDate) {
    // _formData.selectedDate = selectedDate;
    // CustomToastWidget.showToast(selectedDate);
    // final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    _formData.selectedDate = selectedDate;
    notifyListeners();
  }



  void setStableFormData(List<ValueItem> selectedServices, String domainId){
    _stableFormData.selectedServices.clear();
    _stableFormData.selectedServices = selectedServices;
    _stableFormData.domainId= domainId;
  }

  void setSafeFormData(List<ValueItem> selectedServices, String domainId){
    _safeFormData.selectedServices.clear();
    _safeFormData.selectedServices = selectedServices;
    _safeFormData.domainId= domainId;
  }

  void saveData(HealthFormData healthFormData) {
    List<MasterServicesFormData> healthFormDataList = convertToMasterServicesFormData(healthFormData);
    CustomToastWidget.showToast('Data saved successfully!${healthFormDataList[0].dateOfEvent}');
    notifyListeners();
  }




  //this is a function for converting a health form data to a list digestable for saving locally and remote
  List<MasterServicesFormData> convertToMasterServicesFormData(HealthFormData healthFormData) {
    List<MasterServicesFormData> masterServicesList = [];

    //convert the healthy form data
    for (ValueItem serviceItem in healthFormData.selectedServices) {
      masterServicesList.add(
        MasterServicesFormData(
          selectedServiceId: serviceItem.value,
          domainId: healthFormData.domainId,
          dateOfEvent: DateFormat('yyyy-MM-dd').format(healthFormData.selectedDate),
        ),
      );
    }


    // Convert StableFormData selected services
    for (ValueItem serviceItem in stableFormData.selectedServices) {
      masterServicesList.add(
        MasterServicesFormData(
          selectedServiceId: serviceItem.value,
          domainId: stableFormData.domainId,
          dateOfEvent: DateFormat('yyyy-MM-dd').format(healthFormData.selectedDate),
        ),
      );
    }

    // Convert SafeFormData selected services
    for (dynamic serviceItem in safeFormData.selectedServices) {
      masterServicesList.add(
        MasterServicesFormData(
          selectedServiceId: serviceItem.toString(),
          domainId: safeFormData.domainId,
          dateOfEvent: DateFormat('yyyy-MM-dd').format(healthFormData.selectedDate),
        ),
      );
    }



    return masterServicesList;
  }
}




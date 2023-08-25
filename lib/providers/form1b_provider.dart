import 'package:cpims_mobile/Models/form1_data_basemodel.dart';
import 'package:cpims_mobile/Models/form_1b.dart';
import 'package:cpims_mobile/services/form_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';
import '../screens/forms/form1b/model/health_form1b_model.dart';
import '../screens/forms/form1b/utils/FinalServicesForm1bModel.dart';
import '../screens/forms/form1b/utils/MasterServicesForm1bModel.dart';
import '../screens/forms/form1b/utils/SafeForm1bModel.dart';
import '../screens/forms/form1b/utils/StableForm1bModel.dart';
import '../widgets/custom_toast.dart';

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
  final FinalServicesFormData _finalServicesFormData = FinalServicesFormData(
      masterServicesList: [],
      dateOfEvent: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      ovc_cpims_id: "",
  );

  HealthFormData get formData => _formData;
  StableFormData get stableFormData => _stableFormData;
  SafeFormData get safeFormData => _safeFormData;
  FinalServicesFormData get finalServicesFormData => _finalServicesFormData;

  void setSelectedHealthServices(List<ValueItem> selectedServices, String domainId) {
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
     // CustomToastWidget.showToast(selectedDate);
    _formData.selectedDate = selectedDate;
    notifyListeners();
  }



  //these are methods to be worked on just before our form is saved
  void setFinalFormDataOvcId(String ovc_cpims_id) {
    _finalServicesFormData.ovc_cpims_id = ovc_cpims_id;
    notifyListeners();
  }
  void setFinalFormDataDOE(DateTime dateOfEvent){
    //we get the date as date time and save it as a string in yyyy-mm--dd
    _finalServicesFormData.dateOfEvent = DateFormat('yyyy-MM-dd').format(dateOfEvent);
    notifyListeners();
  }
  void setFinalFormDataServices(List<MasterServicesFormData> masterServicesList){
    _finalServicesFormData.masterServicesList = masterServicesList;
    notifyListeners();
  }
  void saveForm1bData(HealthFormData healthFormData) {
    List<MasterServicesFormData> masterServicesList = convertToMasterServicesFormData();
    //creating our data to be sent for saving
    setFinalFormDataServices(masterServicesList);
    setFinalFormDataOvcId("ovc_cpims_675748");
    setFinalFormDataDOE(formData.selectedDate);


    // print('Date of Event: ${finalServicesFormData.dateOfEvent}');
    // print('OVC CPIMS ID: ${finalServicesFormData.ovc_cpims_id}');
    // print('Master Services List:');
    // for (MasterServicesFormData masterFormData in finalServicesFormData.masterServicesList ?? []) {
    //   print('- Domain ID: ${masterFormData.domainId}');
    //   print('- Selected Service ID: ${masterFormData.selectedServiceId}');
    //   print('---');
    // }



    List<Form1ServicesModel> servicesList = [];

    for (MasterServicesFormData masterFormData in finalServicesFormData.masterServicesList ?? []) {
      Form1ServicesModel entry = Form1ServicesModel(domainId: masterFormData.domainId, serviceId: masterFormData.selectedServiceId);
      servicesList.add(entry);
    }

    Form1BDataModel toDbData = Form1BDataModel(ovcCpimsId: finalServicesFormData.ovc_cpims_id, dateOfEvent: finalServicesFormData.dateOfEvent, services: servicesList);
    print("ourData${toDbData}");

    Form1Service.saveFormLocal("form1b", toDbData);


    // print("Form1bData: ${form1bListData.length}");
    // for (MasterServicesFormData msFormData in form1bListData) {
    //   print("Form1bData: ");
    //   print('Domain ID: ${msFormData.domainId}');
    //   print('Selected Service ID: ${msFormData.selectedServiceId}');
    //   print('Date of Event: ${msFormData.dateOfEvent}');
    //   print('----------------------');
    // }
    // CustomToastWidget.showToast('Data saved successfully!${form1bListData[0].dateOfEvent}');
    notifyListeners();
  }







  //converting the various services from the domains into one Services list with domain id and service id
  List<MasterServicesFormData> convertToMasterServicesFormData() {
    List<MasterServicesFormData> masterServicesList = [];
    HealthFormData healthFormData = formData;
    //convert the healthy form data
    for (ValueItem serviceItem in healthFormData.selectedServices) {
      masterServicesList.add(
        MasterServicesFormData(
          selectedServiceId: serviceItem.value,
          domainId: healthFormData.domainId,
          // dateOfEvent: DateFormat('yyyy-MM-dd').format(healthFormData.selectedDate),
        ),
      );
    }
    // Convert StableFormData selected services
    for (ValueItem serviceItem in stableFormData.selectedServices) {
      masterServicesList.add(
        MasterServicesFormData(
          selectedServiceId: serviceItem.value,
          domainId: stableFormData.domainId,
          // dateOfEvent: DateFormat('yyyy-MM-dd').format(healthFormData.selectedDate),
        ),
      );
    }
    // Convert SafeFormData selected services
    for (dynamic serviceItem in safeFormData.selectedServices) {
      masterServicesList.add(
        MasterServicesFormData(
          selectedServiceId: serviceItem.value,
          domainId: safeFormData.domainId,
          // dateOfEvent: DateFormat('yyyy-MM-dd').format(healthFormData.selectedDate),
        ),
      );
    }

    return masterServicesList;
  }
}




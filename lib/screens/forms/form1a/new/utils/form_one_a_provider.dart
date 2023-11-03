import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Models/form_1_model.dart';
import '../../../../../providers/connection_provider.dart';
import '../../../../../providers/db_provider.dart';
import '../../../../../services/form_service.dart';
import '../../../form1b/model/critical_events_form1b_model.dart';
import '../../../form1b/model/health_form1b_model.dart';
import '../../../form1b/utils/FinalServicesForm1bModel.dart';
import '../../../form1b/utils/MasterServicesForm1bModel.dart';
import '../../../form1b/utils/SafeForm1bModel.dart';
import '../../../form1b/utils/StableForm1bModel.dart';

class Form1AProviderNew extends ChangeNotifier {
  final HealthFormData _formData = HealthFormData(
      selectedServices: [], selectedDate: DateTime.now(), domainId: "");
  final StableFormData _stableFormData =
      StableFormData(selectedServices: [], domainId: "");
  final SchooledFormData _schooledFormData =
      SchooledFormData(selectedServices: [], domainId: "");
  final SafeFormData _safeFormData =
      SafeFormData(selectedServices: [], domainId: "");
  final FinalServicesFormData _finalServicesFormData = FinalServicesFormData(
    services: [],
    date_of_event: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    ovc_cpims_id: "",
  );

  final CriticalEventDataForm1b _criticalEventDataForm1b =
      CriticalEventDataForm1b(
    selectedEvents: [],
    selectedDate: DateTime.now(),
  );

  HealthFormData get formData => _formData;

  StableFormData get stableFormData => _stableFormData;

  SafeFormData get safeFormData => _safeFormData;

  SchooledFormData get schooledFormData => _schooledFormData;

  CriticalEventDataForm1b get criticalEventDataForm1b =>
      _criticalEventDataForm1b;

  FinalServicesFormData get finalServicesFormData => _finalServicesFormData;

  void setSelectedHealthServices(
      List<ValueItem> selectedServices, String domainId) {
    _formData.selectedServices.clear(); // Clear the current list
    _formData.selectedServices.addAll(selectedServices);
    _formData.domainId = domainId;
    notifyListeners();
  }

  void setSelectedSafeFormDataServices(
      List<ValueItem> selectedServices, String domainId) {
    _safeFormData.selectedServices.clear(); // Clear the current list
    _safeFormData.selectedServices.addAll(selectedServices);
    _safeFormData.domainId = domainId;
    notifyListeners();
  }

  void setSelectedStableFormDataServices(
      List<ValueItem> selectedServices, String domainId) {
    _stableFormData.selectedServices.clear(); // Clear the current list
    _stableFormData.selectedServices.addAll(selectedServices);
    _stableFormData.domainId = domainId;
    notifyListeners();
  }

  void setSelectedSchooledFormDataServices(
      List<ValueItem> selectedServices, String domainId) {
    _schooledFormData.selectedServices.clear(); // Clear the current list
    _schooledFormData.selectedServices.addAll(selectedServices);
    _schooledFormData.domainId = domainId;
    notifyListeners();
  }

  void setSelectedDate(DateTime selectedDate) {
    _formData.selectedDate = selectedDate;
    notifyListeners();
  }

  void setCriticalEventsSelectedDate(DateTime selectedDate) {
    _criticalEventDataForm1b.selectedDate = selectedDate;
    notifyListeners();
  }

  void setCriticalEventsSelectedEvents(List<ValueItem> selectedEvents) {
    _criticalEventDataForm1b.selectedEvents.clear();
    _criticalEventDataForm1b.selectedEvents.addAll(selectedEvents);
    notifyListeners();
  }

  void setFinalFormDataOvcId(String ovc_cpims_id) {
    _finalServicesFormData.ovc_cpims_id = ovc_cpims_id;
    notifyListeners();
  }

  void setFinalFormDataDOE(DateTime? dateOfEvent) {
    _finalServicesFormData.date_of_event =
        DateFormat('yyyy-MM-dd').format(dateOfEvent!);
    _criticalEventDataForm1b.selectedDate = dateOfEvent;
    notifyListeners();
  }

  void setFinalFormDataServices(
      List<MasterServicesFormData> masterServicesList) {
    _finalServicesFormData.services = masterServicesList;
    notifyListeners();
  }

  List<Form1CriticalEventsModel> getFinalCriticalEventsFormData() {
    List<Form1CriticalEventsModel> criticalEvents =
        generateCriticalEventsDS(criticalEventDataForm1b);
    return criticalEvents;
  }

  Future<bool> saveForm1AData(
      HealthFormData healthFormData, String latitude, String longitude) async {
    List<MasterServicesFormData> masterServicesList =
        convertToMasterServicesFormData();
    setFinalFormDataServices(masterServicesList);
    setFinalFormDataOvcId(_finalServicesFormData.ovc_cpims_id);
    setFinalFormDataDOE(formData.selectedDate);
    List<Form1CriticalEventsModel> criticalEventsFormData =
        getFinalCriticalEventsFormData();

    List<Form1ServicesModel> servicesList = [];

    for (MasterServicesFormData masterFormData
        in finalServicesFormData.services ?? []) {
      Form1ServicesModel entry = Form1ServicesModel(
          domainId: masterFormData.domainId,
          serviceId: masterFormData.selectedServiceId);
      servicesList.add(entry);
    }

    List<Form1CriticalEventsModel> criticalEventsList = [];
    for (var criticalEvent in criticalEventsFormData) {
      Form1CriticalEventsModel entry = Form1CriticalEventsModel(
          event_id: criticalEvent.event_id,
          event_date: criticalEvent.event_date);
      criticalEventsList.add(entry);
    }

    Form1DataModel toDbData = Form1DataModel(
      ovcCpimsId: finalServicesFormData.ovc_cpims_id,
      date_of_event: finalServicesFormData.date_of_event,
      services: servicesList,
      criticalEvents: criticalEventsList,
      location_lat: latitude,
      location_long: longitude,
    );
    String data = jsonEncode(toDbData);
    print("The json data for form 1 a is $data");
    print("form1b payload:==========>$criticalEventsList");

    bool isFormSaved = await Form1Service.saveFormLocal("form1a", toDbData);
    if (isFormSaved == true) {
      resetFormData();
      notifyListeners();
    }
    return isFormSaved;
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

    for (dynamic serviceItem in schooledFormData.selectedServices) {
      masterServicesList.add(
        MasterServicesFormData(
          selectedServiceId: serviceItem.value,
          domainId: schooledFormData.domainId,
        ),
      );
    }

    return masterServicesList;
  }

  List<Form1CriticalEventsModel> generateCriticalEventsDS(
      CriticalEventDataForm1b criticalEventDataForm1b) {
    List<Form1CriticalEventsModel> eventsList = [];

    for (int i = 0; i < criticalEventDataForm1b.selectedEvents.length; i++) {
      final eventId = criticalEventDataForm1b.selectedEvents[i].value;
      final eventDate =
          DateFormat('yyyy-MM-dd').format(criticalEventDataForm1b.selectedDate);

      eventsList.add(
        Form1CriticalEventsModel(event_id: eventId!, event_date: eventDate),
      );
    }

    return eventsList;
  }

  List<Map<String, dynamic>> form1bFetchedData = [];

  Future<void> fetchSavedDataFromDb() async {
    try {
      List<Map<String, dynamic>> updatedForm1Rows =
          await Form1Service.getAllForms("form1b");

      form1bFetchedData = updatedForm1Rows;

      print(form1bFetchedData);
      notifyListeners();
    } catch (e) {
      print("Error fetching form1b data: $e");
    }
  }

  void resetFormData() {
    _formData.selectedServices.clear();
    _formData.selectedDate = DateTime.now();
    _formData.domainId = '1234';

    _stableFormData.selectedServices.clear();
    _stableFormData.domainId = '';

    _safeFormData.selectedServices.clear();
    _safeFormData.domainId = '';

    _finalServicesFormData.services.clear();
    _finalServicesFormData.date_of_event =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    _finalServicesFormData.ovc_cpims_id = '';

    _criticalEventDataForm1b.selectedEvents.clear();
    _criticalEventDataForm1b.selectedDate = DateTime.now();

    notifyListeners();
  }

  Future<void> handleSubmitToServer(
      String data, Form1DataModel formOneAData) async {
    final localDb = LocalDb.instance;
    var prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('access');
    String bearerAuth = "Bearer $accessToken";

    final dio = Dio();
    const apiEndpoint = "https://dev.cpims.net/api/form/F1B/";

    final options = Options(
      headers: {"Authorization": bearerAuth},
    );

    final hasConnection = await Provider.of<ConnectivityProvider>(
      Get.context!,
      listen: false,
    ).checkInternetConnection();
    try {
      if (hasConnection) {
        final formOneApiResponse =
            await dio.post(apiEndpoint, data: data, options: options);
        if (formOneApiResponse.statusCode == 200) {
          print("Data posted  successfully to server is $data");
          Get.snackbar(
            'Success',
            'Form 1A submitted to the server successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Failed',
            'No Internet Connection.Try again',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        try {
          Form1Service.saveFormLocal("form1a", formOneAData);
          Get.snackbar(
            'Success',
            'Saved data locally.Ensure to sync on internet connection',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.yellow,
            colorText: Colors.white,
          );
        } catch (e) {
          Get.snackbar(
            'Failed',
            'Failed to save locally',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }
}

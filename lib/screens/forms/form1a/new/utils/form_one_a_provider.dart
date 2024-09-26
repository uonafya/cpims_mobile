import 'dart:convert';

import 'package:cpims_mobile/Models/unapproved_form_1_model.dart';
import 'package:cpims_mobile/services/unapproved_data_service.dart';
import 'package:cpims_mobile/utils/app_form_metadata.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:uuid/uuid.dart';

import '../../../../../Models/form_1_model.dart';
import '../../../../../services/form_service.dart';
import '../../../form1b/model/critical_events_form1b_model.dart';
import '../../../form1b/model/health_form1b_model.dart';
import '../../../form1b/utils/FinalServicesForm1bModel.dart';
import '../../../form1b/utils/MasterServicesForm1bModel.dart';
import '../../../form1b/utils/SafeForm1bModel.dart';
import '../../../form1b/utils/StableForm1bModel.dart';

class Form1AProviderNew extends ChangeNotifier {
  final HealthFormData _formData =
      HealthFormData(selectedServices: [], selectedDate: "", domainId: "");
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
    careGiverId: "",
  );

  final CriticalEventDataForm1b _criticalEventDataForm1b =
      CriticalEventDataForm1b(
    selectedEvents: [],
    selectedDate: "",
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

  // void setSelectedDate(DateTime selectedDate) {
  //   _formData.selectedDate = selectedDate;
  //   notifyListeners();
  // }

  void setSelectedDateOfEvent(String selectedDate) {
    _formData.selectedDate = selectedDate;
    notifyListeners();
  }

  void setCriticalEventsSelectedDate(String selectedDate) {
    _criticalEventDataForm1b.selectedDate = selectedDate;
    notifyListeners();
  }

  void setCriticalEventsSelectedEvents(List<ValueItem> selectedEvents) {
    _criticalEventDataForm1b.selectedEvents.clear();
    _criticalEventDataForm1b.selectedEvents.addAll(selectedEvents);
    notifyListeners();
  }

  void setFinalFormDataOvcId(String ovcCpimsId) {
    _finalServicesFormData.ovc_cpims_id = ovcCpimsId;
    notifyListeners();
  }

  void setFinalFormDataCareGiverId(String careGiverId) {
    _finalServicesFormData.careGiverId = careGiverId;
    notifyListeners();
  }

  void setFinalFormDataDOE(String? dateOfEvent) {
    _finalServicesFormData.date_of_event = dateOfEvent!;
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
      HealthFormData healthFormData, String startInterviewTime, UnapprovedForm1DataModel? unapprovedForm1) async {
    List<MasterServicesFormData> masterServicesList =
        convertToMasterServicesFormData();
    setFinalFormDataServices(masterServicesList);
    setFinalFormDataOvcId(_finalServicesFormData.ovc_cpims_id);
    setFinalFormDataCareGiverId(_finalServicesFormData.careGiverId);
    setFinalFormDataDOE(formData.selectedDate);
    List<Form1CriticalEventsModel> criticalEventsFormData =
        getFinalCriticalEventsFormData();

    List<Form1ServicesModel> servicesList = [];

    for (MasterServicesFormData masterFormData
        in finalServicesFormData.services) {
      Form1ServicesModel entry = Form1ServicesModel(
          domainId: masterFormData.domainId,
          serviceId: masterFormData.selectedServiceId);
      servicesList.add(entry);
    }

    List<Form1CriticalEventsModel> criticalEventsList = [];
    for (var criticalEvent in criticalEventsFormData) {
      Form1CriticalEventsModel entry = Form1CriticalEventsModel(
          eventId: criticalEvent.eventId, eventDate: criticalEvent.eventDate);
      criticalEventsList.add(entry);
    }

    String formUUID = unapprovedForm1?.formUuid ?? const Uuid().v4();

    AppFormMetaData appFormMetaData = AppFormMetaData(
      formId: formUUID,
      startOfInterview: startInterviewTime,
      formType: "form1a",
      location_lat: unapprovedForm1!.appFormMetaData.location_lat,
      location_long: unapprovedForm1.appFormMetaData.location_long,
    );

    if (!(finalServicesFormData.date_of_event == "")) {
      Form1DataModel toDbData = Form1DataModel(
        ovcCpimsId: finalServicesFormData.ovc_cpims_id,
        caregiverCpimsId: finalServicesFormData.careGiverId,
        dateOfEvent: finalServicesFormData.date_of_event,
        services: servicesList,
        criticalEvents: criticalEventsList,
        formUuid: formUUID,
      );
      String data = jsonEncode(toDbData);
      if (kDebugMode) {
        print("The json data for form 1 a is $data");
      }
      if (kDebugMode) {
        print("form1b payload:==========>$criticalEventsList");
      }

      bool isFormSaved = await Form1Service.saveFormLocal(
        "form1a",
        toDbData,
        appFormMetaData,
        formUUID,
      );
      if (unapprovedForm1.localId != null) {
        bool isUnapprovedDeleted = await UnapprovedDataService.deleteUnapprovedForm1(unapprovedForm1.localId!);
        if (isUnapprovedDeleted) {
          debugPrint("Unapproved delete success");
        } else {
          debugPrint("Unapproved delete not success");
        }
      }
      if (isFormSaved == true) {
        resetFormData();
        notifyListeners();
      }

      return isFormSaved;
    } else {
      Get.snackbar(
        'Error',
        'Please select date of event',
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
    }
    return false;
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
      final eventDate = criticalEventDataForm1b.selectedDate;
      if (eventDate.isNotEmpty) {
        eventsList.add(
          Form1CriticalEventsModel(eventId: eventId!, eventDate: eventDate),
        );
      }
    }

    return eventsList;
  }

  List<Map<String, dynamic>> form1bFetchedData = [];

  void resetFormData() {
    _formData.selectedServices.clear();
    _formData.selectedDate = '';
    _formData.domainId = '1234';

    _stableFormData.selectedServices.clear();
    _stableFormData.domainId = '';

    _safeFormData.selectedServices.clear();
    _safeFormData.domainId = '';

    _finalServicesFormData.services.clear();
    _finalServicesFormData.date_of_event =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    _finalServicesFormData.ovc_cpims_id = '';
    _finalServicesFormData.careGiverId = '';

    _criticalEventDataForm1b.selectedEvents.clear();
    _criticalEventDataForm1b.selectedDate = '';

    notifyListeners();
  }
}

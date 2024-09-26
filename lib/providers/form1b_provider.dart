// import 'package:cpims_mobile/Models/form1_data_basemodel.dart';
// import 'package:cpims_mobile/Models/form_1b.dart';

import 'package:cpims_mobile/services/form_service.dart';
import 'package:cpims_mobile/utils/app_form_metadata.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:uuid/uuid.dart';
import '../Models/form_1_model.dart';
import '../Models/unapproved_form_1_model.dart';
import '../screens/forms/form1b/model/critical_events_form1b_model.dart';
import '../screens/forms/form1b/model/health_form1b_model.dart';
import '../screens/forms/form1b/utils/FinalServicesForm1bModel.dart';
import '../screens/forms/form1b/utils/MasterServicesForm1bModel.dart';
import '../screens/forms/form1b/utils/SafeForm1bModel.dart';
import '../screens/forms/form1b/utils/StableForm1bModel.dart';
import '../services/unapproved_data_service.dart';

class Form1bProvider extends ChangeNotifier {
  final HealthFormData _formData =
      HealthFormData(selectedServices: [], selectedDate: "", domainId: "");
  final StableFormData _stableFormData =
      StableFormData(selectedServices: [], domainId: "");
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

  void setSelectedDate(String selectedDate) {
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

  void setFinalFormDataDOE(String dateOfEvent) {
    _finalServicesFormData.date_of_event = dateOfEvent;
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

  Future<bool> saveForm1bData(
    HealthFormData healthFormData,
    String startInterviewTime,
    BuildContext context,
      UnapprovedForm1DataModel? unapprovedForm1
  ) async {
    List<MasterServicesFormData> masterServicesList =
        convertToMasterServicesFormData();
    //creating our data to be sent for saving
    setFinalFormDataServices(masterServicesList);
    setFinalFormDataOvcId(_finalServicesFormData.ovc_cpims_id);
    setFinalFormDataCareGiverId(_finalServicesFormData.careGiverId);
    setFinalFormDataDOE(formData.selectedDate!);
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

    String formUuid = unapprovedForm1?.formUuid ?? const Uuid().v4();
    AppFormMetaData appFormMetaData = AppFormMetaData(
      formType: "form1b",
      formId: formUuid,
      startOfInterview: startInterviewTime,
      location_lat: unapprovedForm1!.appFormMetaData.location_lat,
      location_long: unapprovedForm1.appFormMetaData.location_long,
    );

    if (!(finalServicesFormData.date_of_event == '')) {
      Form1DataModel toDbData = Form1DataModel(
        formUuid: formUuid,
        ovcCpimsId: finalServicesFormData.ovc_cpims_id,
        caregiverCpimsId: finalServicesFormData.careGiverId,
        dateOfEvent: finalServicesFormData.date_of_event,
        services: servicesList,
        criticalEvents: criticalEventsList,

      );

      bool isFormSaved = await Form1Service.saveFormLocal(
        "form1b",
        toDbData,
        appFormMetaData,
        formUuid,
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

    return masterServicesList;
  }

  List<Form1CriticalEventsModel> generateCriticalEventsDS(
      CriticalEventDataForm1b criticalEventDataForm1b) {
    List<Form1CriticalEventsModel> eventsList = [];

    for (int i = 0; i < criticalEventDataForm1b.selectedEvents.length; i++) {
      final eventId = criticalEventDataForm1b.selectedEvents[i].value;
      final eventDate = criticalEventDataForm1b.selectedDate;

      if (eventDate != "") {
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
    _formData.selectedDate = "";
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
    _criticalEventDataForm1b.selectedDate = "";

    notifyListeners();
  }
}

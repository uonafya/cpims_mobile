import 'dart:convert';

import 'package:cpims_mobile/services/form_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../Models/case_load_model.dart';
import '../Models/form_1_model.dart';

class CriticalFormData {
  late List<ValueItem> selectedEvents;
  late DateTime selectedDate;

  CriticalFormData({required this.selectedEvents, required this.selectedDate});
}

class ServiceFormData {
  late List<ValueItem> selectedDomain;
  late List<ValueItem> selectedService;
  late DateTime selectedEventDate;

  ServiceFormData(
      {required this.selectedDomain,
        required this.selectedEventDate,
        required this.selectedService});
}

class Form1AProvider extends ChangeNotifier {
  final CriticalFormData _criticalFormData =
  CriticalFormData(selectedEvents: [], selectedDate: DateTime.now());

  final ServiceFormData _serviceFormData = ServiceFormData(
      selectedDomain: [],
      selectedEventDate: DateTime.now(),
      selectedService: []);

  CriticalFormData get criticalFormData => _criticalFormData;
  ServiceFormData get serviceFormData => _serviceFormData;

  void setSelectedEvents(List<ValueItem> selectedEvents) {
    _criticalFormData.selectedEvents.clear();
    _criticalFormData.selectedEvents.addAll(selectedEvents);
    notifyListeners();
  }

  void setEventSelectedDate(DateTime selectedDate) {
    _criticalFormData.selectedDate = selectedDate;
    notifyListeners();
  }

  void setSelectedDomain(List<ValueItem> selectedDomain) {
    _serviceFormData.selectedDomain.clear();
    _serviceFormData.selectedDomain.addAll(selectedDomain);
    notifyListeners();
  }

  void setSelectedSubDomain(List<ValueItem> selectedService) {
    _serviceFormData.selectedService.clear();
    _serviceFormData.selectedService.addAll(selectedService);
    notifyListeners();
  }

  void setServiceSelectedDate(DateTime selectedEventDate) {
    _serviceFormData.selectedEventDate = selectedEventDate;
    notifyListeners();
  }

  void submitCriticalData() {
    String formattedDate =
    DateFormat('yyyy-MM-dd').format(_criticalFormData.selectedDate);

    List<Map<String, dynamic>> criticalEvents = [];
    for (var valueItem in _criticalFormData.selectedEvents) {
      Map<String, dynamic> criticalEvent = {
        "event_date": formattedDate,
        "event_id": valueItem.value,
      };
      criticalEvents.add(criticalEvent);
    }
    eventData = criticalEvents;
    print(criticalEvents);
  }

  void submitServicesData() {
    List<Map<String, dynamic>> service_of_domains = [];
    for (var valueItem in _serviceFormData.selectedDomain) {
      String domainId = valueItem.value ?? '';
      for (var serviceItem in _serviceFormData.selectedService) {
        String serviceId = serviceItem.value ?? '';
        Map<String, dynamic> item = {
          'domainId': domainId,
          'serviceId': serviceId,
        };
        service_of_domains.add(item);
        print(service_of_domains);
        services = service_of_domains;
      }
    }
  }

  List<Map<String, dynamic>> eventData = [];
  List<Map<String, dynamic>> services = [];

  void submitCriticalServices(cpimsId) {
    print(cpimsId);
    String dateOfEvent =
    DateFormat('yyyy-MM-dd').format(_criticalFormData.selectedDate);

    Map<String, dynamic> payload = {
      'ovc_cpims_id': cpimsId,
      'date_of_event': dateOfEvent,
      'services': services,
      // 'critical_events': eventData,
    };
    String form1A = jsonEncode(payload);
    print(form1A);

    List<Form1ServicesModel> servicesList = [];
    List<Form1CriticalEventsModel> eventsList = [];

    for (var event in eventData ?? []) {
      if (event != null && event['event_id'] != null && event['event_date'] != null) {
        Form1CriticalEventsModel entry = Form1CriticalEventsModel(
          eventId: event['event_id'],
          eventDate: dateOfEvent,
        );
        eventsList.add(entry);
      }
    }

    for (var service in services) {
      Form1ServicesModel entry1 = Form1ServicesModel(
        domainId: service['domainId'],
        serviceId: service['serviceId'],
      );
      servicesList.add(entry1);
    }

    Form1DataModel toDbData = Form1DataModel(
      ovcCpimsId: cpimsId,
      dateOfEvent: dateOfEvent,
      services: servicesList,
      criticalEvents: eventsList,
    );
    print("ourData${toDbData}");

    Form1Service.saveFormLocal("form1a", toDbData);
    Form1Service.getAllForms("form1a");

    _criticalFormData.selectedEvents.clear();
    _serviceFormData.selectedDomain.clear();
    _serviceFormData.selectedService.clear();
    _serviceFormData.selectedEventDate = DateTime.now();
    _criticalFormData.selectedDate = DateTime.now();
    notifyListeners();
  }
  // CaseLoad

  late CaseLoadModel _caseLoadModel;

  set caseLoadModel(CaseLoadModel value) {
    _caseLoadModel = value;
    notifyListeners();
  }

  void updateCaseLoadModel(CaseLoadModel caseLoadModel) {
    _caseLoadModel = caseLoadModel;
    notifyListeners();
  }
}

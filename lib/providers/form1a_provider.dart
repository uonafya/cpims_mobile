import 'dart:convert';

import 'package:cpims_mobile/services/form_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';

import '../Models/form_1a.dart';

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
  // <<<<<<<<<<<critical events >>>>>>>>>>>>>>>>>>>>>>>>>>>>
  final CriticalFormData _criticalFormData =
  CriticalFormData(selectedEvents: [], selectedDate: DateTime.now());

  // <<<<<<<<<<<< Service >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  final ServiceFormData _serviceFormData = ServiceFormData(
      selectedDomain: [],
      selectedEventDate: DateTime.now(),
      selectedService: []);

//<<<<<<<<<<<<<<<<<<<<<Critical events >>>>>>>>>>>>>>>>>>>>>

  CriticalFormData get criticalFormData => _criticalFormData;
  ServiceFormData get serviceFormData => _serviceFormData;

  // <<<<<<<<<<<<<<<Set Methods >>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  // <<<<<<<<<<<<<<<Critical methods >>>>>>>>>>>>>>>>>>>>>>>>
  void setSelectedEvents(List<ValueItem> selectedEvents) {
    _criticalFormData.selectedEvents.clear();
    _criticalFormData.selectedEvents.addAll(selectedEvents);
    notifyListeners();
  }

  void setEventSelectedDate(DateTime selectedDate) {
    criticalFormData.selectedDate = selectedDate;
    notifyListeners();
  }

  // <<<<<<<<<<<<<<<<<<<<Services >>>>>>>>>>>>>>>>>>>>>>>>>>>
  // <<<<<<<<<<<<<<<Domain >>>>>>>>>>>>>>>>>>>>>>>>>>>

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
  }

  // <<<<<<<<<<<<<<<Submit critical >>>>>>>>>>>>>>>>>>>
  void submitCriticalData() {
    String formattedDate =
    DateFormat('yyyy-MM-dd').format(_criticalFormData.selectedDate);

    List<Map<String, dynamic>> criticalEvents = [];
    Map<String, dynamic> criticalEvent = {};
    for (var valueItem in _criticalFormData.selectedEvents) {
      criticalEvent["event_date"] = formattedDate;
      criticalEvent["event_id"] = valueItem.value;
      criticalEvents.add(criticalEvent);
      eventData = criticalEvents;
      print(criticalEvents);
    }
  }

// <<<<<<<<<<<<<Submit Services >>>>>>>>>>>>>>>>>>>>>>>
  void submitServicesData() {
    List<Map<String, dynamic>> data = [];
    for (var valueItem in _serviceFormData.selectedDomain) {
      String domainId = valueItem.value ?? '';
      for (var serviceItem in _serviceFormData.selectedService) {
        String serviceId = serviceItem.value ?? '';
        Map<String, dynamic> item = {
          'domain_id': domainId,
          'service_id': serviceId,
        };
        data.add(item);
        print(data);
        services = data;
      }
    }
  }

  List<Map<String, dynamic>> eventData = [];
  List<Map<String, dynamic>> services = [];

  void submitCriticalServices() {
    String dateOfEvent =
    DateFormat('yyyy-MM-dd').format(_criticalFormData.selectedDate);



    // <<<<<<<<<<<<Saving the form 1A to DB >>>>>>>>>>>



    // <<<<<<<<<<< Rest Form >>>>>>>>>>>>>>>>>>>>>>>>>>>


    notifyListeners();
  }
}
// <<<<<<<<<<<<< testing code >>>>>>>>>>>>>>>>
// Map<String, dynamic> payload = {};
// payload.addAll({
//   'ovc_cpims_id': 12344,
//   'date_of_event': dateOfEvent,
//   'services': serviceData,
//   'critical_events': eventData,
// });
// String form1A = jsonEncode(payload);
// print(form1A);
//

// Form1Service.getAllForms('form1a').then((forms) {
//   print('Retrieved Form1A data: $forms');
// });

//    setSelectedEvents([]);
//     setSelectedDomain([]);
//     setSelectedSubDomain([]);
//     setEventSelectedDate(DateTime.now());
//     setServiceSelectedDate(DateTime.now());
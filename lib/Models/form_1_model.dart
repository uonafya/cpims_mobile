import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/utils/app_form_metadata.dart';

class Form1DataModel {
  final int? localId;
  final String id;
  final String ovcCpimsId;
  final String dateOfEvent;
  final List<Form1ServicesModel> services;
  final List<Form1CriticalEventsModel> criticalEvents;
  final AppFormMetaData appFormMetaData;
   String ? device_id ="";

  Form1DataModel({
    required this.id,
    this.localId,
    required this.ovcCpimsId,
    required this.dateOfEvent,
    required this.services,
    required this.criticalEvents,
    this.device_id,
    this.appFormMetaData = const AppFormMetaData(
      formType: "",
      formId: "",
      startOfInterview: "",
    ),
  });

  factory Form1DataModel.fromJson(Map<String, dynamic> json) {
    List<Form1ServicesModel> services = [];
    List<Form1CriticalEventsModel> criticalEvents = [];

    if (json['services'] != null) {
      for (var serviceJson in json['services']) {
        services.add(Form1ServicesModel.fromJson(serviceJson));
      }
    }

    if (json['critical_events'] != null) {
      for (var eventsJson in json['critical_events']) {
        criticalEvents.add(Form1CriticalEventsModel.fromJson(eventsJson));
      }
    }

    return Form1DataModel(
      localId: json['local_id'] as int,
      id: json['id'] as String,
      ovcCpimsId: json['ovc_cpims_id'] as String,
      dateOfEvent: json['date_of_event'] as String,
      services: services,
      criticalEvents: criticalEvents,
      appFormMetaData: AppFormMetaData.fromJson(json['app_form_metadata']),
      device_id: json['device_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ovc_cpims_id': ovcCpimsId,
      'id': id,
      'date_of_event': dateOfEvent,
      'services': services.map((service) => service.toJson()).toList(),
      'critical_events': criticalEvents.map((event) => event.toJson()).toList(),
      'app_form_metadata': appFormMetaData.toJson(),
      'device_id': device_id,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'ovc_cpims_id': ovcCpimsId,
      'id': id,
      'date_of_event': dateOfEvent,
      'services': services.map((service) => service.toMap()).toList(),
      'critical_events': criticalEvents.map((event) => event.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return 'Form1DataModel{ovcCpimsId: $ovcCpimsId, date_of_event: $dateOfEvent, services: $services, criticalEvents: $criticalEvents},id: $id';
  }
}

class Form1ServicesModel {
  final String domainId;
  final String? serviceId;
  final String? message;

  Form1ServicesModel({
    required this.domainId,
    required this.serviceId,
    this.message
  });

  factory Form1ServicesModel.fromJson(Map<String, dynamic> json) {
    return Form1ServicesModel(
      domainId: json['domain_id'] as String,
      serviceId: json['service_id'],
      message: json['message']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'domain_id': domainId,
      'service_id': serviceId,
      'message' : message
    };
  }

  @override
  String toString() {
    return 'Form1ServicesModel{domainId: $domainId, serviceId: $serviceId, message: $message}';
  }

  Map<String, dynamic> toMap() {
    return {
      'domain_id': domainId,
      'service_id': serviceId,
      'message' : message
    };
  }
}

class Form1CriticalEventsModel {
  final String eventId;
  final String eventDate;
  final String? message;

  Form1CriticalEventsModel({
    required this.eventId,
    required this.eventDate,
    this.message
  });

  factory Form1CriticalEventsModel.fromJson(Map<String, dynamic> json) {
    return Form1CriticalEventsModel(
      eventId: json['event_id'] as String,
      eventDate: json['event_date'],
      message: json['message']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'event_date': eventDate,
      'message' : message
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'event_id': eventId,
      'event_date': eventDate,
      'message' : message
    };
  }

  @override
  String toString() {
    return 'Form1CriticalEventsModel{event_id: $eventId, event_date: $eventDate, message: $message}';
  }
}

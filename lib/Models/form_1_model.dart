class Form1DataModel {
  final String ovcCpimsId;
  final String dateOfEvent;
  final List<Form1ServicesModel> services;
  final List<Form1CriticalEventsModel> criticalEvents;

  Form1DataModel({
    required this.ovcCpimsId,
    required this.dateOfEvent,
    required this.services,
    required this.criticalEvents,
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
      ovcCpimsId: json['ovc_cpims_id'] as String,
      dateOfEvent: json['date_of_event'] as String,
      services: services,
      criticalEvents: criticalEvents,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ovc_cpims_id': ovcCpimsId,
      'date_of_event': dateOfEvent,
      'services': services.map((service) => service.toJson()).toList(),
      'critical_events': criticalEvents.map((event) => event.toJson()).toList(),
    };
  }
}

class Form1ServicesModel {
  final String domainId;
  final List<String> serviceIds;

  Form1ServicesModel({
    required this.domainId,
    required this.serviceIds,
  });

  factory Form1ServicesModel.fromJson(Map<String, dynamic> json) {
    return Form1ServicesModel(
      domainId: json['domain_id'] as String,
      serviceIds: List<String>.from(json['service_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'domain_id': domainId,
      'service_id': serviceIds,
    };
  }
}

class Form1CriticalEventsModel {
  final String eventId;
  final List<String> eventDateIds;

  Form1CriticalEventsModel({
    required this.eventId,
    required this.eventDateIds,
  });

  factory Form1CriticalEventsModel.fromJson(Map<String, dynamic> json) {
    return Form1CriticalEventsModel(
      eventId: json['event_id'] as String,
      eventDateIds: List<String>.from(json['event_date_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'event_date_id': eventDateIds,
    };
  }
}

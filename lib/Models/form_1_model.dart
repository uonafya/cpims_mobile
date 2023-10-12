class Form1DataModel {
  final String ovcCpimsId;
  final String date_of_event;
  final List<Form1ServicesModel> services;
  final List<Form1CriticalEventsModel> criticalEvents;

  Form1DataModel({
    required this.ovcCpimsId,
    required this.date_of_event,
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
      date_of_event: json['date_of_event'] as String,
      services: services,
      criticalEvents: criticalEvents,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ovc_cpims_id': ovcCpimsId,
      'date_of_event': date_of_event,
      'services': services.map((service) => service.toJson()).toList(),
      'critical_events': criticalEvents.map((event) => event.toJson()).toList(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'ovc_cpims_id': ovcCpimsId,
      'date_of_event': date_of_event,
      'services': services.map((service) => service.toMap()).toList(),
      'critical_events': criticalEvents.map((event) => event.toMap()).toList(),
    };
  }



  @override
  String toString() {
    return 'Form1DataModel{ovcCpimsId: $ovcCpimsId, dateOfEvent: $date_of_event, services: $services, criticalEvents: $criticalEvents}';
  }
}


class Form1ServicesModel {
  final String domainId;
  final String? serviceId;

  Form1ServicesModel({
    required this.domainId,
    required this.serviceId,
  });

  factory Form1ServicesModel.fromJson(Map<String, dynamic> json) {
    return Form1ServicesModel(
      domainId: json['domain_id'] as String,
      serviceId: json['service_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'domain_id': domainId,
      'service_id': serviceId,
    };
  }

  @override
  String toString() {
    return 'Form1ServicesModel{domainId: $domainId, serviceId: $serviceId}';
  }

  Map<String, dynamic> toMap() {
    return {
      'domain_id': domainId,
      'service_id': serviceId,
    };
  }
}


class Form1CriticalEventsModel {
  final String event_id;
  final String event_date;

  Form1CriticalEventsModel({
    required this.event_id,
    required this.event_date,
  });

  factory Form1CriticalEventsModel.fromJson(Map<String, dynamic> json) {
    return Form1CriticalEventsModel(
      event_id: json['event_id'] as String,
      event_date: json['event_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': event_id,
      'event_date': event_date,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'event_id': event_id,
      'event_date': event_date,
    };
  }

  @override
  String toString() {
    return 'Form1CriticalEventsModel{event_id: $event_id, event_date: $event_date}';
  }
}

import 'form1_data_basemodel.dart';


class Form1ADataModel extends Form1DataBaseModel {
  final List<Form1ACriticalEventsModel> criticalEvents;

  Form1ADataModel({
    required String ovcCpimsId,
    required String dateOfEvent,
    required List<Form1ServicesModel> services,
    required this.criticalEvents,
  }) : super(
    ovcCpimsId: ovcCpimsId,
    dateOfEvent: dateOfEvent,
    services: services,
  );

  factory Form1ADataModel.fromJson(Map<String, dynamic> json) {
    List<Form1ServicesModel> services = [];
    List<Form1ACriticalEventsModel> criticalEvents = [];
    if (json['services'] != null) {
      // Parse the list of services
      for (var serviceJson in json['services']) {
        services.add(Form1ServicesModel.fromJson(serviceJson));
      }
    }
    if (json['critical_events'] != null) {
      // Parse the list of services
      for (var eventsJson in json['critical_events']) {
        criticalEvents.add(Form1ACriticalEventsModel.fromJson(eventsJson));
      }
    }
    return Form1ADataModel(
      ovcCpimsId: json['ovc_cpims_id'],
      dateOfEvent: json['date_of_event'],
      services: services,
      criticalEvents: criticalEvents,
    );


  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'critical_events': criticalEvents,
    };
  }
}

class Form1ACriticalEventsModel {
  late final String eventId;
  late final List<String> eventDateId;

  Form1ACriticalEventsModel({
    required this.eventId,
    required this.eventDateId,
  });

  factory Form1ACriticalEventsModel.fromJson(Map<String, dynamic> json) {
    return Form1ACriticalEventsModel(
      eventId: json['event_id'] as String,
      eventDateId: List<String>.from(json['date_of_event']),

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'event_id': eventId,
      'event_date_id': eventDateId,
    };
  }

}
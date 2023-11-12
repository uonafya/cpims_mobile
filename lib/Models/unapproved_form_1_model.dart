import '../utils/app_form_metadata.dart';
import 'form_1_model.dart';

class UnapprovedForm1DataModel extends Form1DataModel {
  final String message;

  UnapprovedForm1DataModel({
    super.localId,
    required super.id,
    required super.ovcCpimsId,
    required super.dateOfEvent,
    required super.services,
    required super.criticalEvents,
    super.appFormMetaData,
    required this.message,
  });

  factory UnapprovedForm1DataModel.fromJson(Map<String, dynamic> json) {
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

    return UnapprovedForm1DataModel(
      localId: json['local_id'] as int?,
      id: json['id'] as String,
      ovcCpimsId: json['ovc_cpims_id'] as String,
      dateOfEvent: json['date_of_event'] as String,
      services: services,
      criticalEvents: criticalEvents,
      appFormMetaData: AppFormMetaData.fromJson(json['app_form_metadata']),
      message: json['message'] as String, // Add the 'message' field
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> baseJson = super.toJson();
    baseJson['message'] = message; // Add the 'message' field
    return baseJson;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> baseMap = super.toMap();
    baseMap['message'] = message; // Add the 'message' field
    return baseMap;
  }

  @override
  String toString() {
    return 'UnapprovedForm1DataModel{ovcCpimsId: $ovcCpimsId, date_of_event: $dateOfEvent, services: $services, criticalEvents: $criticalEvents, id: $id, message: $message}';
  }
}

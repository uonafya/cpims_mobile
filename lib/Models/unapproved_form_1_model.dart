import '../utils/app_form_metadata.dart';
import 'form_1_model.dart';

class UnapprovedForm1DataModel extends Form1DataModel {
  final String message;

  UnapprovedForm1DataModel({
    super.localId,
    required super.formUuid,
    super.caregiverCpimsId = "",
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
      formUuid: json['id']?.toString() ?? "",
      ovcCpimsId: json['ovc_cpims_id']?.toString() ?? "",
      dateOfEvent: json['date_of_event'] as String? ?? "",
      caregiverCpimsId: json['caregiver_cpims_id']?.toString() ?? "N/A",
      services: services,
      criticalEvents: criticalEvents,
      appFormMetaData: json['app_form_metadata'] != null
          ? AppFormMetaData.fromJson(json['app_form_metadata'] as Map<String, dynamic>)
          : const AppFormMetaData(),
      message: json['message'] as String? ?? "",
    );
  }

  factory UnapprovedForm1DataModel.fromJsonUnApproved(Map<String, dynamic> json) {
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
      formUuid: json['form_uuid'] == null ? "" : json['form_uuid'].toString(),
      ovcCpimsId: json['ovc_cpims_id'].toString(),
      dateOfEvent: json['date_of_event'] as String,
      caregiverCpimsId: json['caregiver_cpims_id'] == null ? "N/A" : json['caregiver_cpims_id'].toString(),
      services: services,
      criticalEvents: criticalEvents,
      appFormMetaData: AppFormMetaData.fromJson(json['app_form_metadata']),
      message: json['message']?? "", // Add the 'message' field
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
    return 'UnapprovedForm1DataModel{ovcCpimsId: $ovcCpimsId, date_of_event: $dateOfEvent, services: $services, criticalEvents: $criticalEvents, id: $formUuid, message: $message}';
  }
}

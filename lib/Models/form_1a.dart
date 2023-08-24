import 'baseForm1Data.dart';


class Form1AData extends BaseForm1Data {
  final List<Map<String, dynamic>> criticalEvents;

  Form1AData({
    required String ovcCpimsId,
    required String dateOfEvent,
    required List<Map<String, dynamic>> services,
    required this.criticalEvents,
  }) : super(
    ovcCpimsId: ovcCpimsId,
    dateOfEvent: dateOfEvent,
    services: services,
  );

  factory Form1AData.fromJson(Map<String, dynamic> json) {
    return Form1AData(
      ovcCpimsId: json['ovc_cpims_id'],
      dateOfEvent: json['date_of_event'],
      services: json['services'],
      criticalEvents: json['critical_events'],
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
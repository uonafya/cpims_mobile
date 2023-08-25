import 'baseForm1Data.dart';

class Form1BData extends BaseForm1Data {
  Form1BData({
    required String ovcCpimsId,
    required String dateOfEvent,
    required List<Map<String, dynamic>> services,
  }) : super(
    ovcCpimsId: ovcCpimsId,
    dateOfEvent: dateOfEvent,
    services: services,
  );

  factory Form1BData.fromJson(Map<String, dynamic> json) {
    return Form1BData(
      ovcCpimsId: json['ovc_cpims_id'],
      dateOfEvent: json['date_of_event'],
      services: json['services'],
    );
  }
}




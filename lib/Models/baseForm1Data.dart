abstract class BaseForm1Data {
  final String ovcCpimsId;
  final String dateOfEvent;
  final List<Map<String, dynamic>> services;

  BaseForm1Data({
    required this.ovcCpimsId,
    required this.dateOfEvent,
    required this.services,
  });

  Map<String, dynamic> toMap() {
    return {
      'ovc_cpims_id': ovcCpimsId,
      'date_of_event': dateOfEvent,
      'services': services,
    };
  }
}

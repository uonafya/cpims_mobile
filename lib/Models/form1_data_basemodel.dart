abstract class Form1DataBaseModel {
  final String ovcCpimsId;
  final String dateOfEvent;
  final List<Form1ServicesModel> services;

  Form1DataBaseModel({
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

class Form1ServicesModel {
  late final String domainId;
  late final List<String> serviceId;


  Form1ServicesModel({
    required this.domainId,
    required this.serviceId,
  });

  factory Form1ServicesModel.fromJson(Map<String, dynamic> json) {
    return Form1ServicesModel(
      domainId: json['domain_id'] as String,
      serviceId: List<String>.from(json['service_id']),
    );
  }
}
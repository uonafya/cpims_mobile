import 'form1_data_basemodel.dart';

class Form1BDataModel extends Form1DataBaseModel {
  Form1BDataModel({
    required String ovcCpimsId,
    required String dateOfEvent,
    required List<Form1ServicesModel> services,
  }) : super(
    ovcCpimsId: ovcCpimsId,
    dateOfEvent: dateOfEvent,
    services: services,
  );

  factory Form1BDataModel.fromJson(Map<String, dynamic> json) {
    List<Form1ServicesModel> services = [];
    if (json['services'] != null) {
      // Parse the list of services
      for (var serviceJson in json['services']) {
        services.add(Form1ServicesModel.fromJson(serviceJson));
      }
    }

    return Form1BDataModel(
      ovcCpimsId: json['ovc_cpims_id'],
      dateOfEvent: json['date_of_event'],
      services: services,
    );
  }
}




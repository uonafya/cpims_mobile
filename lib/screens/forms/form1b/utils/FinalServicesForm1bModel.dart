import 'MasterServicesForm1bModel.dart';



class FinalServicesFormData {
  List<MasterServicesFormData> services;
  String date_of_event;
  String ovc_cpims_id;

  FinalServicesFormData({
    required this.services,
    required this.date_of_event,
    required this.ovc_cpims_id,
  });

  // Factory constructor to create an instance from a JSON Map
  factory FinalServicesFormData.fromJson(Map<String, dynamic> json) {
    List<MasterServicesFormData> masterServicesList = [];

    if (json['services'] != null) {
      for (var serviceJson in json['services']) {
        masterServicesList.add(MasterServicesFormData.fromJson(serviceJson));
      }
    }

    return FinalServicesFormData(
      services: masterServicesList,
      date_of_event: json['date_of_event'],
      ovc_cpims_id: json['ovc_cpims_id'],
    );
  }

  // Method to convert the object to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'services': services.map((item) => item.toJson()).toList(),
      'date_of_event': date_of_event,
      'ovc_cpims_id': ovc_cpims_id,
    };
  }

  // Optional: Override the toString method for debugging
  @override
  String toString() {
    return 'FinalServicesFormData{services: $services, date_of_event: $date_of_event, ovc_cpims_id: $ovc_cpims_id}';
  }
}

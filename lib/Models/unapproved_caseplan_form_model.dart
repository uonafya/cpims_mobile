import 'caseplan_form_model.dart';

class UnapprovedCasePlanModel extends CasePlanModel {

  final String message;

  UnapprovedCasePlanModel({
    super.id,
    required super.caregiverCpimsId,
    required super.ovcCpimsId,
    required super.dateOfEvent,
    required super.services,
    required this.message,
  });

  factory UnapprovedCasePlanModel.fromJson(Map<String, dynamic> json) {
    List<CasePlanServiceModel> services = [];
    if (json['services'] != null) {
      if (json['services'] is List) {
        for (var serviceJson in json['services']) {
          services.add(CasePlanServiceModel.fromJsonUnApproved(serviceJson));
        }
      }
    }
    return UnapprovedCasePlanModel(
      id: json['id'],
      caregiverCpimsId: json['caregiver_cpims_id'] as String? ?? '',
      ovcCpimsId: json['ovc_cpims_id'].toString(),
      dateOfEvent: json['date_of_event'] as String? ?? '',
      services: services,
      message: json['message'] == null ? '' : json['message'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> baseJson = super.toJson();
    baseJson['message'] = message; // Add the 'message' field
    return baseJson;
  }

  @override
  String toString() {
    return 'UnapprovedCasePlanModel {'
        'ovcCpimsId: $ovcCpimsId, '
        'dateOfEvent: $dateOfEvent, '
        'services: $services, '
        'message: $message, '
        'caregiverCpimsId: $caregiverCpimsId, '
        '}';
  }

}
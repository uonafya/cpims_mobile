import '../utils/app_form_metadata.dart';

class CasePlanModel {
  final int? id;
  late final String ovcCpimsId;
  late final String caregiverCpimsId;
  late final String dateOfEvent;
  late final List<CasePlanServiceModel> services;
  final AppFormMetaData appFormMetaData;

  CasePlanModel({
    required this.ovcCpimsId,
    required this.dateOfEvent,
    required this.services,
    required  this.caregiverCpimsId,
    this.id,
    this.appFormMetaData = const AppFormMetaData(
      formId: '',
      formType: '',
      startOfInterview: '',
    ),
  });

  factory CasePlanModel.fromJson(Map<String, dynamic> json) {
    List<CasePlanServiceModel> services = [];
    if (json['services'] != null) {
      if (json['services'] is List) {
        // Check if 'services' is a list
        for (var serviceJson in json['services']) {
          services.add(CasePlanServiceModel.fromJson(serviceJson));
        }
      }
    }
    return CasePlanModel(
      id: json['id'],
      ovcCpimsId: json['ovc_cpims_id'] as String? ?? '',
      caregiverCpimsId: json['caregiver_cpims_id'] as String? ?? '',
      // Handle possible null value
      dateOfEvent: json['date_of_event'] as String? ?? '',
      // Handle possible null value
      services: services,
      appFormMetaData: (json['app_form_metadata'] != null)
          ? AppFormMetaData.fromJson(json['app_form_metadata'])
          : const AppFormMetaData(
              formId: '',
              formType: '',
              startOfInterview: '',
              location_long: '',
              location_lat: '',
              endOfInterview: '',
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ovc_cpims_id': ovcCpimsId,
      'caregiver_cpims_id': caregiverCpimsId,
      'date_of_event': dateOfEvent,
      'services': services.map((service) => service.toJson()).toList(),
      'app_form_metadata': appFormMetaData.toJson(),
    };
  }

  @override
  String toString() {
    return 'CasePlanModel {'
        'ovcCpimsId: $ovcCpimsId, '
        'dateOfEvent: $dateOfEvent, '
        'services: $services'
        '}';
  }
}

class CasePlanServiceModel {
  late final String domainId;
  late final List<String?> serviceIds;
  late final String goalId;
  late final String gapId;
  late final String priorityId;
  late final List<String?> responsibleIds;
  late final String resultsId;
  late final String reasonId;
  late String? completionDate = "";

  CasePlanServiceModel({
    required this.domainId,
    required this.serviceIds,
    required this.goalId,
    required this.gapId,
    required this.priorityId,
    required this.responsibleIds,
    required this.resultsId,
    required this.reasonId,
    required this.completionDate,
  });

  factory CasePlanServiceModel.fromJson(Map<String, dynamic> json) {
    return CasePlanServiceModel(
      domainId: json['domain_id'] as String? ?? '',
      // Handle possible null value
      serviceIds: List<String>.from(json['service_id'] ?? []),
      // Handle possible null value
      goalId: json['goal_id'] as String? ?? '',
      // Handle possible null value
      gapId: json['gap_id'] as String? ?? '',
      // Handle possible null value
      priorityId: json['priority_id'] as String? ?? '',
      // Handle possible null value
      responsibleIds: List<String>.from(json['responsible_id'] ?? []),
      // Handle possible null value
      resultsId: json['results_id'] as String? ?? '',
      // Handle possible null value
      reasonId: json['reason_id'] as String? ?? '',
      // Handle possible null value
      completionDate: json['completion_date'] as String? ??
          '', // Handle possible null value
    );
  }
  factory CasePlanServiceModel.fromJsonUnApproved(Map<String, dynamic> json) {
    return CasePlanServiceModel(
      domainId: json['domain_id'] as String? ?? '',
      // Handle possible null value
      serviceIds: json['service_id'] is Iterable
          ? List<String>.from(json['service_id'])
          : [],
      // Handle possible null value
      goalId: json['goal_id'] as String? ?? '',
      // Handle possible null value
      gapId: json['gap_id'] as String? ?? '',
      // Handle possible null value
      priorityId: json['priority_id'] as String? ?? '',
      // Handle possible null value
      responsibleIds: json['responsible_id'] is Iterable
          ? List<String>.from(json['responsible_id'])
          : [],
      // Handle possible null value
      resultsId: json['results_id'] as String? ?? '',
      // Handle possible null value
      reasonId: json['reason_id'] as String? ?? '',
      // Handle possible null value
      completionDate: json['completion_date'] as String? ??
          '', // Handle possible null value
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'domain_id': domainId,
      'service_id': serviceIds,
      'goal_id': goalId,
      'gap_id': gapId,
      'priority_id': priorityId,
      'responsible_id': responsibleIds,
      'results_id': resultsId,
      'reason_id': reasonId,
      'completion_date': completionDate,
    };
  }

  @override
  String toString() {
    return 'CasePlanServiceModel {'
        'domainId: $domainId, '
        'serviceIds: $serviceIds, '
        'goalId: $goalId, '
        'gapId: $gapId, '
        'priorityId: $priorityId, '
        'responsibleIds: $responsibleIds, '
        'resultsId: $resultsId, '
        'reasonId: $reasonId, '
        'completionDate: $completionDate'
        '}';
  }
}

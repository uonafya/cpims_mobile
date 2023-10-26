class CasePlanModel {
  final int? id;
  late final String ovcCpimsId;
  late final String dateOfEvent;
  late final List<CasePlanServiceModel> services;

  CasePlanModel({
    required this.ovcCpimsId,
    required this.dateOfEvent,
    required this.services,
    this.id
  });

  factory CasePlanModel.fromJson(Map<String, dynamic> json) {
    List<CasePlanServiceModel> services = [];
    if (json['services'] != null) {
      // Parse the list of services
      for (var serviceJson in json['services']) {
        services.add(CasePlanServiceModel.fromJson(serviceJson));
      }
    }

    return CasePlanModel(
      id: json['id'],
      ovcCpimsId: json['ovc_cpims_id'] as String,
      dateOfEvent: json['date_of_event'] as String,
      services: services,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ovc_cpims_id': ovcCpimsId,
      'date_of_event': dateOfEvent,
      'services': services.map((service) => service.toJson()).toList(),
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
  late final String completionDate;

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
      domainId: json['domain_id'] as String,
      serviceIds: List<String>.from(json['service_id']),
      goalId: json['goal_id'] as String,
      gapId: json['gap_id'] as String,
      priorityId: json['priority_id'] as String,
      responsibleIds: List<String>.from(json['responsible_id']),
      resultsId: json['results_id'] as String,
      reasonId: json['reason_id'] as String,
      completionDate: json['completion_date'] as String,
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

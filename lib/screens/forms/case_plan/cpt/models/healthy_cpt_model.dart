
import '../../../../../Models/caseplan_form_model.dart';

class CasePlanHealthyModel {
  late final int? id;
  late final String? ovcCpimsId;
  late final String? caregiverCpimsId;
  late final String? dateOfEvent;
  late final List<CasePlanServiceHealthyModel>? services;

  CasePlanHealthyModel(
      {this.ovcCpimsId,
      this.caregiverCpimsId,
        this.dateOfEvent, this.services, this.id});

  factory CasePlanHealthyModel.fromJson(Map<String, dynamic> json) {
    List<CasePlanServiceHealthyModel> services = [];
    if (json['services'] != null) {
      // Parse the list of services
      for (var serviceJson in json['services']) {
        services.add(CasePlanServiceHealthyModel.fromJson(serviceJson));
      }
    }

    return CasePlanHealthyModel(
      id: json['id'],
      caregiverCpimsId: json['caregiver_cpims_id'] as String? ?? '',
      ovcCpimsId: json['ovc_cpims_id'] as String,
      dateOfEvent: json['date_of_event'] as String,
      services: services,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'caregiver_cpims_id': caregiverCpimsId,
      'ovc_cpims_id': ovcCpimsId,
      'date_of_event': dateOfEvent,
      'services': services?.map((service) => service.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'CasePlanModel {'
        'ovcCpimsId: $ovcCpimsId, '
        'dateOfEvent: $dateOfEvent, '
        'services: $services, '
        'caregiverCpimsId: $caregiverCpimsId, '
        '}';
  }

  CasePlanHealthyModel copyWith({
    String? ovcCpimsId,
    String? caregiverCpimsId,
    String? dateOfEvent,
    List<CasePlanServiceHealthyModel>? services,
    int? id,
  }) {
    return CasePlanHealthyModel(
      caregiverCpimsId: caregiverCpimsId ?? this.caregiverCpimsId,
      ovcCpimsId: ovcCpimsId ?? this.ovcCpimsId,
      dateOfEvent: dateOfEvent ?? this.dateOfEvent,
      services: services ?? this.services,
      id: id ?? this.id,
    );
  }
}

class CasePlanServiceHealthyModel {
  late final String domainId;
  late final List<String?> serviceIds;
  late final String goalId;
  late final String gapId;
  late final String priorityId;
  late final List<String?> responsibleIds;
  late final String resultsId;
  late final String reasonId;
  late final String completionDate;

  CasePlanServiceHealthyModel({
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

  factory CasePlanServiceHealthyModel.fromJson(Map<String, dynamic> json) {
    return CasePlanServiceHealthyModel(
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

  CasePlanServiceHealthyModel copyWith({
    String? domainId,
    List<String?>? serviceIds,
    String? goalId,
    String? gapId,
    String? priorityId,
    List<String?>? responsibleIds,
    String? resultsId,
    String? reasonId,
    String? completionDate,
  }) {
    return CasePlanServiceHealthyModel(
      domainId: domainId ?? this.domainId,
      serviceIds: serviceIds ?? this.serviceIds,
      goalId: goalId ?? this.goalId,
      gapId: gapId ?? this.gapId,
      priorityId: priorityId ?? this.priorityId,
      responsibleIds: responsibleIds ?? this.responsibleIds,
      resultsId: resultsId ?? this.resultsId,
      reasonId: reasonId ?? this.reasonId,
      completionDate: completionDate ?? this.completionDate,
    );
  }
}

class CptHealthFormData {
  String? domainId = "DHNU";
  final List<String?>? serviceIds;
  late final String? goalId;
  final String? gapId;
  final String? priorityId;
  final List<String?>? responsibleIds;
  final String? resultsId;
  final String? reasonId;
  final String? completionDate;

  CptHealthFormData({
    this.domainId,
    this.serviceIds,
    this.goalId,
    this.gapId,
    this.priorityId,
    this.responsibleIds,
    this.resultsId,
    this.reasonId,
    this.completionDate,
  });

  CptHealthFormData copyWith({
    String? ovcCpimsId,
    String? dateOfEvent,
    String? domainId,
    List<String?>? serviceIds,
    String? goalId,
    String? gapId,
    String? priorityId,
    List<String?>? responsibleIds,
    String? resultsId,
    String? reasonId,
    String? completionDate,
  }) {
    return CptHealthFormData(
      domainId: domainId ?? this.domainId,
      serviceIds: serviceIds ?? this.serviceIds,
      goalId: goalId ?? this.goalId,
      gapId: gapId ?? this.gapId,
      priorityId: priorityId ?? this.priorityId,
      responsibleIds: responsibleIds ?? this.responsibleIds,
      resultsId: resultsId ?? this.resultsId,
      reasonId: reasonId ?? this.reasonId,
      completionDate: completionDate ?? this.completionDate,
    );
  }

  @override
  String toString() {
    return 'CptHealthFormData('
        'domainId: $domainId, '
        'serviceIds: $serviceIds, '
        'goalId: $goalId, '
        'gapId: $gapId, '
        'priorityId: $priorityId, '
        'responsibleIds: $responsibleIds, '
        'resultsId: $resultsId, '
        'reasonId: $reasonId, '
        'completionDate: $completionDate)';
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

  factory CptHealthFormData.fromJson(Map<String, dynamic> json) {
    return CptHealthFormData(
      domainId: json['domain_id'],
      serviceIds: List<String?>.from(json['service_id']),
      goalId: json['goal_id'],
      gapId: json['gap_id'],
      priorityId: json['priority_id'],
      responsibleIds: List<String?>.from(json['responsible_id']),
      resultsId: json['results_id'],
      reasonId: json['reason_id'],
      completionDate: json['completion_date'],
    );
  }
}

CasePlanHealthyModel mapCptHealthFormDataToCasePlan(
    CptHealthFormData formData) {
  List<CasePlanServiceHealthyModel> services = [];
  if (formData.serviceIds != null) {
    List<String?> combinedServiceIds = [];
    for (String? serviceId in formData.serviceIds!) {
      if (serviceId != null) {
        combinedServiceIds.add(serviceId);
      }
    }

    if (combinedServiceIds.isNotEmpty) {
      services.add(CasePlanServiceHealthyModel(
        domainId: formData.domainId!,
        serviceIds: combinedServiceIds,
        goalId: formData.goalId!,
        gapId: formData.gapId!,
        priorityId: formData.priorityId!,
        responsibleIds: formData.responsibleIds!,
        resultsId: formData.resultsId!,
        reasonId: formData.reasonId ?? "",
        completionDate: formData.completionDate!,
      ));
    }
  }

  return CasePlanHealthyModel(
    services: services,
  );
}

CasePlanModel mapCasePlanHealthyToCasePlan(CasePlanHealthyModel healthyModel) {
  // Map the services
  List<CasePlanServiceModel> services = [];
  if (healthyModel.services != null) {
    for (CasePlanServiceHealthyModel serviceHealthy in healthyModel.services!) {
      // Convert serviceHealthy to serviceModel
      List<String?> serviceIds = serviceHealthy.serviceIds;
      CasePlanServiceModel serviceModel = CasePlanServiceModel(
        domainId: serviceHealthy.domainId,
        serviceIds: serviceIds,
        goalId: serviceHealthy.goalId,
        gapId: serviceHealthy.gapId,
        priorityId: serviceHealthy.priorityId,
        responsibleIds: serviceHealthy.responsibleIds,
        resultsId: serviceHealthy.resultsId,
        reasonId: serviceHealthy.reasonId,
        completionDate: serviceHealthy.completionDate,
      );
      services.add(serviceModel);
    }
  }

  return CasePlanModel(
    id: healthyModel.id,
    caregiverCpimsId: healthyModel.caregiverCpimsId ?? "",
    ovcCpimsId: healthyModel.ovcCpimsId ?? "",
    dateOfEvent: healthyModel.dateOfEvent ?? "",
    services: services,
  );
}

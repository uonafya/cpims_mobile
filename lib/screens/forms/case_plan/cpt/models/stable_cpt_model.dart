import 'dart:convert';

import '../../../../../Models/caseplan_form_model.dart';
import 'healthy_cpt_model.dart';

class CasePlanStableModel {
  late final int? id;
  late final String? ovcCpimsId;
  late final String? dateOfEvent;
  late final List<CasePlanServiceStableModel>? services;

  CasePlanStableModel(
      {this.ovcCpimsId, this.dateOfEvent, this.services, this.id});

  factory CasePlanStableModel.fromJson(Map<String, dynamic> json) {
    List<CasePlanServiceStableModel> services = [];
    if (json['services'] != null) {
      // Parse the list of services
      for (var serviceJson in json['services']) {
        services.add(CasePlanServiceStableModel.fromJson(serviceJson));
      }
    }

    return CasePlanStableModel(
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
      'services': services?.map((service) => service.toJson()).toList(),
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

  CasePlanStableModel copyWith({
    String? ovcCpimsId,
    String? dateOfEvent,
    List<CasePlanServiceStableModel>? services,
    int? id,
  }) {
    return CasePlanStableModel(
      ovcCpimsId: ovcCpimsId ?? this.ovcCpimsId,
      dateOfEvent: dateOfEvent ?? this.dateOfEvent,
      services: services ?? this.services,
      id: id ?? this.id,
    );
  }
}

class CasePlanServiceStableModel {
  late final String domainId;
  late final List<String?> serviceIds;
  late final String goalId;
  late final String gapId;
  late final String priorityId;
  late final List<String?> responsibleIds;
  late final String resultsId;
  late final String reasonId;
  late final String completionDate;

  CasePlanServiceStableModel({
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

  factory CasePlanServiceStableModel.fromJson(Map<String, dynamic> json) {
    return CasePlanServiceStableModel(
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

  CasePlanServiceStableModel copyWith({
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
    return CasePlanServiceStableModel(
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

class CptStableFormData {
  String? domainId = "DHES";
  final List<String?>? serviceIds;
  final String? goalId;
  final String? gapId;
  final String? priorityId;
  final List<String?>? responsibleIds;
  final String? resultsId;
  final String? reasonId;
  final String? completionDate;

  CptStableFormData({
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

  CptStableFormData copyWith({
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
    return CptStableFormData(
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
    return 'CptStableFormData('
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

  factory CptStableFormData.fromJson(Map<String, dynamic> json) {
    return CptStableFormData(
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

CasePlanStableModel mapCptStableFormDataToCasePlan(CptStableFormData formData) {
  List<CasePlanServiceStableModel> services = [];
  if (formData.serviceIds != null) {
    List<String?> combinedServiceIds = [];
    for (String? serviceId in formData.serviceIds!) {
      if (serviceId != null) {
        combinedServiceIds.add(serviceId);
      }
    }

    if (combinedServiceIds.isNotEmpty) {
      services.add(CasePlanServiceStableModel(
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

  return CasePlanStableModel(
    services: services,
  );
}

CasePlanModel mapCasePlanStableToCasePlan(CasePlanStableModel stableModel) {
  // Map the services
  List<CasePlanServiceModel> services = [];
  if (stableModel.services != null) {
    for (CasePlanServiceStableModel serviceStable in stableModel.services!) {
      // Convert serviceHealthy to serviceModel
      List<String?> serviceIds = serviceStable.serviceIds;
      CasePlanServiceModel serviceModel = CasePlanServiceModel(
        domainId: serviceStable.domainId,
        serviceIds: serviceIds,
        goalId: serviceStable.goalId,
        gapId: serviceStable.gapId,
        priorityId: serviceStable.priorityId,
        responsibleIds: serviceStable.responsibleIds,
        resultsId: serviceStable.resultsId,
        reasonId: serviceStable.reasonId,
        completionDate: serviceStable.completionDate,
      );
      services.add(serviceModel);
    }
  }

  return CasePlanModel(
    id: stableModel.id,
    ovcCpimsId: stableModel.ovcCpimsId ?? "",
    dateOfEvent: stableModel.dateOfEvent ?? "",
    services: services,
  );
}

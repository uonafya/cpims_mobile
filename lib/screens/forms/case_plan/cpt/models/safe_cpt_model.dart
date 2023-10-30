import 'dart:convert';

import '../../../../../Models/caseplan_form_model.dart';
import 'healthy_cpt_model.dart';

class CasePlanSafeModel {
  late final int? id;
  late final String? ovcCpimsId;
  late final String? dateOfEvent;
  late final List<CasePlanServiceSafeModel>? services;

  CasePlanSafeModel(
      {this.ovcCpimsId, this.dateOfEvent, this.services, this.id});

  factory CasePlanSafeModel.fromJson(Map<String, dynamic> json) {
    List<CasePlanServiceSafeModel> services = [];
    if (json['services'] != null) {
      // Parse the list of services
      for (var serviceJson in json['services']) {
        services.add(CasePlanServiceSafeModel.fromJson(serviceJson));
      }
    }

    return CasePlanSafeModel(
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

  CasePlanSafeModel copyWith({
    String? ovcCpimsId,
    String? dateOfEvent,
    List<CasePlanServiceSafeModel>? services,
    int? id,
  }) {
    return CasePlanSafeModel(
      ovcCpimsId: ovcCpimsId ?? this.ovcCpimsId,
      dateOfEvent: dateOfEvent ?? this.dateOfEvent,
      services: services ?? this.services,
      id: id ?? this.id,
    );
  }
}

class CasePlanServiceSafeModel {
  late final String domainId;
  late final List<String?> serviceIds;
  late final String goalId;
  late final String gapId;
  late final String priorityId;
  late final List<String?> responsibleIds;
  late final String resultsId;
  late final String reasonId;
  late final String completionDate;

  CasePlanServiceSafeModel({
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

  factory CasePlanServiceSafeModel.fromJson(Map<String, dynamic> json) {
    return CasePlanServiceSafeModel(
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

  CasePlanServiceSafeModel copyWith({
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
    return CasePlanServiceSafeModel(
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

class CptSafeFormData {
  String? domainId = "DPRO";
  final List<String?>? serviceIds;
  final String? goalId;
  final String? gapId;
  final String? priorityId;
  final List<String?>? responsibleIds;
  final String? resultsId;
  final String? reasonId;
  final String? completionDate;

  CptSafeFormData({
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

  CptSafeFormData copyWith({
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
    return CptSafeFormData(
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
    return 'CptSafeFormData('
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
      'domainId': domainId,
      'serviceIds': serviceIds,
      'goalId': goalId,
      'gapId': gapId,
      'priorityId': priorityId,
      'responsibleIds': responsibleIds,
      'resultsId': resultsId,
      'reasonId': reasonId,
      'completionDate': completionDate,
    };
  }

  factory CptSafeFormData.fromJson(Map<String, dynamic> json) {
    return CptSafeFormData(
      domainId: json['domainId'],
      serviceIds: List<String?>.from(json['serviceIds']),
      goalId: json['goalId'],
      gapId: json['gapId'],
      priorityId: json['priorityId'],
      responsibleIds: List<String?>.from(json['responsibleIds']),
      resultsId: json['resultsId'],
      reasonId: json['reasonId'],
      completionDate: json['completionDate'],
    );
  }
}

CasePlanSafeModel mapCptSafeFormDataToCasePlan(CptSafeFormData formData) {
  List<CasePlanServiceSafeModel> services = [];
  if (formData.serviceIds != null) {
    List<String?> combinedServiceIds = [];
    for (String? serviceId in formData.serviceIds!) {
      if (serviceId != null) {
        combinedServiceIds.add(serviceId);
      }
    }

    if (combinedServiceIds.isNotEmpty) {
      services.add(CasePlanServiceSafeModel(
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

  return CasePlanSafeModel(
    services: services,
  );
}

CasePlanModel mapCasePlanSafeToCasePlan(CasePlanSafeModel safeModel) {
  // Map the services
  List<CasePlanServiceModel> services = [];
  if (safeModel.services != null) {
    for (CasePlanServiceSafeModel serviceSafe in safeModel.services!) {
      // Convert serviceHealthy to serviceModel
      List<String?> serviceIds = serviceSafe.serviceIds;
      CasePlanServiceModel serviceModel = CasePlanServiceModel(
        domainId: serviceSafe.domainId,
        serviceIds: serviceIds,
        goalId: serviceSafe.goalId,
        gapId: serviceSafe.gapId,
        priorityId: serviceSafe.priorityId,
        responsibleIds: serviceSafe.responsibleIds,
        resultsId: serviceSafe.resultsId,
        reasonId: serviceSafe.reasonId,
        completionDate: serviceSafe.completionDate,
      );
      services.add(serviceModel);
    }
  }

  return CasePlanModel(
    id: safeModel.id,
    ovcCpimsId: safeModel.ovcCpimsId ?? "",
    dateOfEvent: DateTime.parse(jsonDecode(safeModel.dateOfEvent!)),
    services: services,
  );
}

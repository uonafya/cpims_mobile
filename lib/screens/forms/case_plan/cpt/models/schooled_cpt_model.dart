import 'dart:convert';

import '../../../../../Models/caseplan_form_model.dart';
import 'healthy_cpt_model.dart';

class CasePlanschooledModel {
  late final int? id;
  late final String? ovcCpimsId;
  late final String? dateOfEvent;
  late final List<CasePlanServiceschooledModel>? services;

  CasePlanschooledModel(
      {this.ovcCpimsId, this.dateOfEvent, this.services, this.id});

  factory CasePlanschooledModel.fromJson(Map<String, dynamic> json) {
    List<CasePlanServiceschooledModel> services = [];
    if (json['services'] != null) {
      // Parse the list of services
      for (var serviceJson in json['services']) {
        services.add(CasePlanServiceschooledModel.fromJson(serviceJson));
      }
    }

    return CasePlanschooledModel(
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

  CasePlanschooledModel copyWith({
    String? ovcCpimsId,
    String? dateOfEvent,
    List<CasePlanServiceschooledModel>? services,
    int? id,
  }) {
    return CasePlanschooledModel(
      ovcCpimsId: ovcCpimsId ?? this.ovcCpimsId,
      dateOfEvent: dateOfEvent ?? this.dateOfEvent,
      services: services ?? this.services,
      id: id ?? this.id,
    );
  }
}

class CasePlanServiceschooledModel {
  late final String domainId;
  late final List<String?> serviceIds;
  late final String goalId;
  late final String gapId;
  late final String priorityId;
  late final List<String?> responsibleIds;
  late final String resultsId;
  late final String reasonId;
  late final String completionDate;

  CasePlanServiceschooledModel({
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

  factory CasePlanServiceschooledModel.fromJson(Map<String, dynamic> json) {
    return CasePlanServiceschooledModel(
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

  CasePlanServiceschooledModel copyWith({
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
    return CasePlanServiceschooledModel(
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

class CptschooledFormData {
  String? domainId = "DEDU";
  final List<String?>? serviceIds;
  final String? goalId;
  final String? gapId;
  final String? priorityId;
  final List<String?>? responsibleIds;
  final String? resultsId;
  final String? reasonId;
  final String? completionDate;

  CptschooledFormData({
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

  CptschooledFormData copyWith({
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
    return CptschooledFormData(
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
    return 'CptschooledFormData('
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

  factory CptschooledFormData.fromJson(Map<String, dynamic> json) {
    return CptschooledFormData(
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

CasePlanschooledModel mapCptschooledFormDataToCasePlan(
    CptschooledFormData formData) {
  List<CasePlanServiceschooledModel> services = [];
  if (formData.serviceIds != null) {
    List<String?> combinedServiceIds = [];
    for (String? serviceId in formData.serviceIds!) {
      if (serviceId != null) {
        combinedServiceIds.add(serviceId);
      }
    }

    if (combinedServiceIds.isNotEmpty) {
      services.add(CasePlanServiceschooledModel(
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

  return CasePlanschooledModel(
    services: services,
  );
}

CasePlanModel mapCasePlanschooledToCasePlan(
    CasePlanschooledModel schooledModel) {
  // Map the services
  List<CasePlanServiceModel> services = [];
  if (schooledModel.services != null) {
    for (CasePlanServiceschooledModel serviceschooled
        in schooledModel.services!) {
      // Convert serviceHealthy to serviceModel
      List<String?> serviceIds = serviceschooled.serviceIds;
      CasePlanServiceModel serviceModel = CasePlanServiceModel(
        domainId: serviceschooled.domainId,
        serviceIds: serviceIds,
        goalId: serviceschooled.goalId,
        gapId: serviceschooled.gapId,
        priorityId: serviceschooled.priorityId,
        responsibleIds: serviceschooled.responsibleIds,
        resultsId: serviceschooled.resultsId,
        reasonId: serviceschooled.reasonId,
        completionDate: serviceschooled.completionDate,
      );
      services.add(serviceModel);
    }
  }

  return CasePlanModel(
    id: schooledModel.id,
    ovcCpimsId: schooledModel.ovcCpimsId ?? "",
    dateOfEvent: DateTime.parse(jsonDecode(schooledModel.dateOfEvent!)),
    services: services,
  );
}

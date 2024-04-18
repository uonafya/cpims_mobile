import 'package:cpims_mobile/screens/forms/graduation_monitoring/model/graduation_monitoring_form_model.dart';

import '../../../../utils/app_form_metadata.dart';

class UnApprovedGraduationFormModel extends GraduationMonitoringFormModel {
  final String? message;
  final String? ovcCpimsId;
  final String? caregiverCpimsId;
  final String? formUuid;
  final AppFormMetaData? appFormMetaData;

  UnApprovedGraduationFormModel({
    String? formType,
    String? dateOfMonitoring,
    String? benchmark1,
    String? benchmark2,
    String? benchmark3,
    String? benchmark4,
    String? benchmark5,
    String? benchmark6,
    String? benchmark7,
    String? benchmark8,
    String? benchmark9,
    String? householdReadyToExit,
    String? caseDeterminedReadyForClosure,
    this.message,
    this.ovcCpimsId,
    this.caregiverCpimsId,
    this.formUuid,
    this.appFormMetaData,
  }) : super(
          formType: formType,
          dateOfMonitoring: dateOfMonitoring,
          benchmark1: benchmark1,
          benchmark2: benchmark2,
          benchmark3: benchmark3,
          benchmark4: benchmark4,
          benchmark5: benchmark5,
          benchmark6: benchmark6,
          benchmark7: benchmark7,
          benchmark8: benchmark8,
          benchmark9: benchmark9,
          householdReadyToExit: householdReadyToExit,
          caseDeterminedReadyForClosure: caseDeterminedReadyForClosure,
        );

  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'message': message,
      'ovcCpimsId': ovcCpimsId,
      'caregiverCpimsId': caregiverCpimsId,
      'formUuid': formUuid,
      'appFormMetaData': appFormMetaData?.toJson() ?? '',
    });
    return map;
  }

  factory UnApprovedGraduationFormModel.fromMap(Map<String, dynamic> map) {
    return UnApprovedGraduationFormModel(
      formType: map['formType'],
      dateOfMonitoring: map['dateOfMonitoring'],
      benchmark1: map['benchmark1'],
      benchmark2: map['benchmark2'],
      benchmark3: map['benchmark3'],
      benchmark4: map['benchmark4'],
      benchmark5: map['benchmark5'],
      benchmark6: map['benchmark6'],
      benchmark7: map['benchmark7'],
      benchmark8: map['benchmark8'],
      benchmark9: map['benchmark9'],
      householdReadyToExit: map['householdReadyToExit'],
      caseDeterminedReadyForClosure: map['caseDeterminedReadyForClosure'],
      message: map['message'] ?? '',
      ovcCpimsId: map['ovcCpimsId'],
      caregiverCpimsId: map['caregiverCpimsId'],
      formUuid: map['formUuid'],
      appFormMetaData: AppFormMetaData.fromJson(map['appFormMetaData']),
    );
  }

  UnApprovedGraduationFormModel copyWith({
    String? formType,
    String? dateOfMonitoring,
    String? benchmark1,
    String? benchmark2,
    String? benchmark3,
    String? benchmark4,
    String? benchmark5,
    String? benchmark6,
    String? benchmark7,
    String? benchmark8,
    String? benchmark9,
    String? householdReadyToExit,
    String? caseDeterminedReadyForClosure,
    String? message,
    String? ovcCpimsId,
    String? caregiverCpimsId,
    String? formUuid,
    AppFormMetaData? appFormMetaData,
  }) {
    return UnApprovedGraduationFormModel(
      formType: formType ?? this.formType,
      dateOfMonitoring: dateOfMonitoring ?? this.dateOfMonitoring,
      benchmark1: benchmark1 ?? this.benchmark1,
      benchmark2: benchmark2 ?? this.benchmark2,
      benchmark3: benchmark3 ?? this.benchmark3,
      benchmark4: benchmark4 ?? this.benchmark4,
      benchmark5: benchmark5 ?? this.benchmark5,
      benchmark6: benchmark6 ?? this.benchmark6,
      benchmark7: benchmark7 ?? this.benchmark7,
      benchmark8: benchmark8 ?? this.benchmark8,
      benchmark9: benchmark9 ?? this.benchmark9,
      householdReadyToExit: householdReadyToExit ?? this.householdReadyToExit,
      caseDeterminedReadyForClosure:
          caseDeterminedReadyForClosure ?? this.caseDeterminedReadyForClosure,
      message: message ?? this.message,
      ovcCpimsId: ovcCpimsId ?? this.ovcCpimsId,
      caregiverCpimsId: caregiverCpimsId ?? this.caregiverCpimsId,
      formUuid: formUuid ?? this.formUuid,
      appFormMetaData: appFormMetaData ?? this.appFormMetaData,
    );
  }

  @override
  String toString() {
    return 'UnApprovedGraduationFormModel(formType: $formType, dateOfMonitoring: $dateOfMonitoring, benchmark1: $benchmark1, benchmark2: $benchmark2, benchmark3: $benchmark3, benchmark4: $benchmark4, benchmark5: $benchmark5, benchmark6: $benchmark6, benchmark7: $benchmark7, benchmark8: $benchmark8, benchmark9: $benchmark9, householdReadyToExit: $householdReadyToExit, caseDeterminedReadyForClosure: $caseDeterminedReadyForClosure, message: $message, ovcCpimsId: $ovcCpimsId, caregiverCpimsId: $caregiverCpimsId, formUuid: $formUuid)';
  }
}

import 'package:cpims_mobile/screens/forms/graduation_monitoring/model/graduation_monitoring_form_model.dart';
import 'package:flutter/cupertino.dart';

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
          form_type: formType,
          gm1d: dateOfMonitoring,
          cm2q: benchmark1,
          cm3q: benchmark2,
          cm4q: benchmark3,
          cm5q: benchmark4,
          cm6q: benchmark5,
          cm7q: benchmark6,
          cm8q: benchmark7,
          cm9q: benchmark8,
          cm10q: benchmark9,
          cm13q: householdReadyToExit,
          cm14q: caseDeterminedReadyForClosure,
        );

  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'message': message,
      'ovc_cpims_id': ovcCpimsId,
      'caregiverCpimsId': caregiverCpimsId,
      'formUuid': formUuid,
      'app_form_metadata': appFormMetaData?.toJson() ?? '',
    });
    return map;
  }

  factory UnApprovedGraduationFormModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return UnApprovedGraduationFormModel();

    final appFormMetaData = map['app_form_metadata'] != null
        ? AppFormMetaData.fromJson(map['app_form_metadata'])
        : null;

    return UnApprovedGraduationFormModel(
      formType: appFormMetaData?.formType ?? '',
      dateOfMonitoring: map['gm1d'] ?? '',
      benchmark1: map['cm2q'] != null ? map['cm2q'].toString() : '',
      benchmark2: map['cm3q'] != null ? map['cm3q'].toString() : '',
      benchmark3: map['cm4q'] != null ? map['cm4q'].toString() : '',
      benchmark4: map['cm5q'] != null ? map['cm5q'].toString() : '',
      benchmark5: map['cm6q'] != null ? map['cm6q'].toString() : '',
      benchmark6: map['cm7q'] != null ? map['cm7q'].toString() : '',
      benchmark7: map['cm8q'] != null ? map['cm8q'].toString() : '',
      benchmark8: map['cm9q'] != null ? map['cm9q'].toString() : '',
      benchmark9: map['cm10q'] != null ? map['cm10q'].toString() : '',
      householdReadyToExit: map['cm13q'] != null ? map['cm13q'].toString() : '',
      caseDeterminedReadyForClosure:
      map['cm14q'] != null ? map['cm14q'].toString() : '',
      message: map['message'] ?? '',
      ovcCpimsId: map['ovc_cpims_id'] != null ? map['ovc_cpims_id'].toString() : '',
      caregiverCpimsId: map['caregiverCpimsId'] ?? '',
      formUuid: map['uuid'] ?? '',
      appFormMetaData: appFormMetaData,
    );
  }

  factory UnApprovedGraduationFormModel.fromMapTwo(Map<String, dynamic>? map) {
    if (map == null) return UnApprovedGraduationFormModel();

    final appFormMetaData = map['app_form_metadata'] != null
        ? AppFormMetaData.fromJson(map['app_form_metadata'])
        : null;

    return UnApprovedGraduationFormModel(
      formType: appFormMetaData?.formType ?? '',
      dateOfMonitoring: map['gm1d'] ?? '',
      benchmark1: map['cm2q'] != null ? map['cm2q'].toString() : '',
      benchmark2: map['cm3q'] != null ? map['cm3q'].toString() : '',
      benchmark3: map['cm4q'] != null ? map['cm4q'].toString() : '',
      benchmark4: map['cm5q'] != null ? map['cm5q'].toString() : '',
      benchmark5: map['cm6q'] != null ? map['cm6q'].toString() : '',
      benchmark6: map['cm7q'] != null ? map['cm7q'].toString() : '',
      benchmark7: map['cm8q'] != null ? map['cm8q'].toString() : '',
      benchmark8: map['cm9q'] != null ? map['cm9q'].toString() : '',
      benchmark9: map['cm10q'] != null ? map['cm10q'].toString() : '',
      householdReadyToExit: map['cm13q'] != null ? map['cm13q'].toString() : '',
      caseDeterminedReadyForClosure:
      map['cm14q'] != null ? map['cm14q'].toString() : '',
      message: map['message'] ?? '',
      ovcCpimsId: map['ovc_cpims_id'] != null ? map['ovc_cpims_id'].toString() : '',
      caregiverCpimsId: map['caregiverCpimsId'] ?? '',
      formUuid: map['obm_id'] ?? '',
      appFormMetaData: appFormMetaData,
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
      formType: formType ?? this.form_type,
      dateOfMonitoring: dateOfMonitoring ?? this.gm1d,
      benchmark1: benchmark1 ?? this.cm2q,
      benchmark2: benchmark2 ?? this.cm3q,
      benchmark3: benchmark3 ?? this.cm4q,
      benchmark4: benchmark4 ?? this.cm5q,
      benchmark5: benchmark5 ?? this.cm6q,
      benchmark6: benchmark6 ?? this.cm7q,
      benchmark7: benchmark7 ?? this.cm8q,
      benchmark8: benchmark8 ?? this.cm9q,
      benchmark9: benchmark9 ?? this.cm10q,
      householdReadyToExit: householdReadyToExit ?? this.cm13q,
      caseDeterminedReadyForClosure:
          caseDeterminedReadyForClosure ?? this.cm14q,
      message: message ?? this.message,
      ovcCpimsId: ovcCpimsId ?? this.ovcCpimsId,
      caregiverCpimsId: caregiverCpimsId ?? this.caregiverCpimsId,
      formUuid: formUuid ?? this.formUuid,
      appFormMetaData: appFormMetaData ?? this.appFormMetaData,
    );
  }

  @override
  String toString() {
    return 'UnApprovedGraduationFormModel(formType: $form_type, dateOfMonitoring: $gm1d, benchmark1: $cm2q, benchmark2: $cm3q, benchmark3: $cm4q, benchmark4: $cm5q, benchmark5: $cm6q, benchmark6: $cm7q, benchmark7: $cm8q, benchmark8: $cm9q, benchmark9: $cm10q, householdReadyToExit: $cm13q, caseDeterminedReadyForClosure: $cm14q, message: $message, ovcCpimsId: $ovcCpimsId, caregiverCpimsId: $caregiverCpimsId, formUuid: $formUuid, appFormMetaData: $appFormMetaData)';
  }
}

import 'package:cpims_mobile/screens/cpara/model/cpara_model.dart';
import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/model/health_model.dart';
import 'package:cpims_mobile/screens/cpara/model/safe_model.dart';
import 'package:cpims_mobile/screens/cpara/model/schooled_model.dart';
import 'package:cpims_mobile/screens/cpara/model/stable_model.dart';
import 'package:cpims_mobile/utils/app_form_metadata.dart';

class UnapprovedCparaModel extends CparaModel {
  final String message;

  UnapprovedCparaModel({
    required super.detail,
    required super.safe,
    required super.stable,
    required super.schooled,
    required super.health,
    super.ovcSubPopulations,
    super.uuid = "",
    super.appFormMetaData,
    required this.message,
  });

  @override
  String toString() {
    return 'UnapprovedCparaModel {\n'
        '  detail: $detail,\n'
        '  safe: $safe,\n'
        '  stable: $stable,\n'
        '  schooled: $schooled,\n'
        '  health: $health,\n'
        '  appFormMetaData: $appFormMetaData, \n'
        '  uuid $uuid, \n'
        '  subpopulation: $ovcSubPopulations,\n'
        '  message: $message\n'
        '}';
  }

  factory UnapprovedCparaModel.fromJson(Map<String, dynamic> json) {
    return UnapprovedCparaModel(
      detail: DetailModel.fromJson(json['detail']),
      safe: SafeModel.fromJson(json['safe']),
      stable: StableModel.fromJson(json['stable']),
      schooled: SchooledModel.fromJson(json['schooled']),
      health: HealthModel.fromJson(json['health']),
      ovcSubPopulations: json['ovc_subpopulation'],
      uuid: json['uuid'],
      appFormMetaData: AppFormMetaData.fromJson(json['appFormMetaData']),
      message: json['message'],
    );
  }
}

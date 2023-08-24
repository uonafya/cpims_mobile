import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/model/health_model.dart';
import 'package:cpims_mobile/screens/cpara/model/safe_model.dart';
import 'package:cpims_mobile/screens/cpara/model/schooled_model.dart';
import 'package:cpims_mobile/screens/cpara/model/stable_model.dart';

class CparaModel {
  final DetailModel detail;
  final SafeModel safe;
  final StableModel stable;
  final SchooledModel schooled;
  final HealthModel health;

  CparaModel({
    required this.detail,
    required this.safe,
    required this.stable,
    required this.schooled,
    required this.health,
  });

  factory CparaModel.fromJson(Map<String, dynamic> json) {
    return CparaModel(
      detail: DetailModel.fromJson(json['detail']),
      safe: SafeModel.fromJson(json['safe']),
      stable: StableModel.fromJson(json['stable']),
      schooled: SchooledModel.fromJson(json['schooled']),
      health: HealthModel.fromJson(json['health']),
    );
  }

}
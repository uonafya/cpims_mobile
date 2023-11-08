import 'package:cpims_mobile/screens/cpara/model/cpara_model.dart';

class UnapprovedCparaModel extends CparaModel {
  final String message;

  UnapprovedCparaModel({
    required super.appFormMetaData,
    required super.detail,
    required super.health,
    required super.ovcSubPopulations,
    required super.safe,
    required super.schooled,
    required super.stable,
    required super.uuid,
    required this.message
  });
}

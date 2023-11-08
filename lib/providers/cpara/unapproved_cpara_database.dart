import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/screens/cpara/model/cpara_model.dart';
import 'package:sqflite/sqflite.dart';

var cannot_store_unapproved_cpara = "Could Not Store Unapproved CPARA Data";

class UnapprovedCparaModel extends CparaModel {
  final String message;
  final String cpmis_id;

  UnapprovedCparaModel({
    required super.appFormMetaData,
    required super.detail,
    required super.health,
    required super.ovcSubPopulations,
    required super.safe,
    required super.schooled,
    required super.stable,
    required super.uuid,
    required this.message,
    required this.cpmis_id,
  });
}

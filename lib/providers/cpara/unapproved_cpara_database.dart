// Due to the large difference between how the CPARA model stores CPARA data
// and how the database stores CPARA data it is easier to create an intermediary
// class to bridge the gap
import 'package:cpims_mobile/screens/cpara/model/db_model.dart';

class UnapprovedCPARADatabase extends CPARADatabase {
  final String message;

  UnapprovedCPARADatabase(
      {required super.appFormMetaData,
      required super.childQuestions,
      required super.cparaFormId,
      required super.dateOfEvent,
      required super.ovcCpimsId,
      required super.listOfSubOvcs,
      required super.questions,
      required this.message});
}

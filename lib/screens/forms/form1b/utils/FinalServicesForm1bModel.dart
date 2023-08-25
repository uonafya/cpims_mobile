import 'MasterServicesForm1bModel.dart';

class FinalServicesFormData {
  late  List<MasterServicesFormData> masterServicesList;
  late  String dateOfEvent;
  late String ovc_cpims_id;

  FinalServicesFormData({
    required this.masterServicesList,
    required this.dateOfEvent,
    required this.ovc_cpims_id
  });
}
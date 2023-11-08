import 'package:cpims_mobile/screens/cpara/model/db_model.dart';
import 'package:cpims_mobile/screens/cpara/model/sub_ovc_child.dart';
import 'package:cpims_mobile/utils/app_form_metadata.dart';

class UnapprovedCparaDatabase extends CPARADatabase{
 final String message;

 UnapprovedCparaDatabase({
    required this.message,
   super.cparaFormId,
   super.ovcCpimsId,
   super.appFormMetaData,
   super.childQuestions,
   super.dateOfEvent,
   super.listOfSubOvcs,
   super.questions,
  });

 static UnapprovedCparaDatabase fromJson(Map<String, dynamic> json){
   return UnapprovedCparaDatabase(
       message: json['message'],
     cparaFormId:  json['form_id'],
     ovcCpimsId:  json['ovc_cpims_id'],
     appFormMetaData: AppFormMetaData.fromJson(json['app_form_metadata']),
     childQuestions: List<CPARAChildQuestions>.from(json["individual_questions"].map((x) => CPARAChildQuestions.fromJSON(x))),
     dateOfEvent: json["date_of_event"],
     listOfSubOvcs: List<SubOvcChild>.from(json["sub_population"].map((x) => SubOvcChild.fromJson(x))),
     questions:  List<CPARADatabaseQuestions>.from(json["questions"].map((x) => CPARADatabaseQuestions.fromJSON(x))),

   );
 }
}

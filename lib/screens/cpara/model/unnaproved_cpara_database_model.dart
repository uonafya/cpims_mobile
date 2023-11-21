import 'package:cpims_mobile/screens/cpara/model/db_model.dart';
import 'package:cpims_mobile/screens/cpara/model/sub_ovc_child.dart';
import 'package:cpims_mobile/utils/app_form_metadata.dart';

class UnapprovedCparaDatabase extends CPARADatabase {
  final String message;

  UnapprovedCparaDatabase({
    required this.message,
    required super.cparaFormId,
    super.ovcCpimsId,
    super.appFormMetaData,
    super.childQuestions,
    super.dateOfEvent,
    super.listOfSubOvcs,
    super.questions,
  });

  static UnapprovedCparaDatabase fromJson(Map<String, dynamic> json) {
    return UnapprovedCparaDatabase(
      message:
          json['message'] ?? "The form was rejected due to inaccurate details",
      cparaFormId: json['id'] ?? "",
      ovcCpimsId: "${json['ovc_cpims_id']}",
      appFormMetaData: json['app_form_metadata'] == null
          ? AppFormMetaData(
              formId: json['id'] ?? "",
              location_lat: "",
              location_long: "",
              startOfInterview: "",
              endOfInterview: "",
              formType: 'cpara')
          : AppFormMetaData.fromJson(json['app_form_metadata']),
      childQuestions: (json["individual_questions"] != null &&
              json["individual_questions"].isNotEmpty)
          ? List<CPARAChildQuestions>.from(json["individual_questions"]
              .map((x) => CPARAChildQuestions.fromJsonRemote(x)))
          : [],
      dateOfEvent: json["date_of_event"],
      listOfSubOvcs:
          (json["sub_population"] != null && json["sub_population"].isNotEmpty)
              ? List<SubOvcChild>.from(
                  json["sub_population"].map((x) => SubOvcChild.fromJson(x)))
              : [],
      questions: (json["questions"] != null && json["questions"].isNotEmpty)
          ? List<CPARADatabaseQuestions>.from(
              json["questions"].map((x) => CPARADatabaseQuestions.fromJSON(x)))
          : [],
    );
  }
}

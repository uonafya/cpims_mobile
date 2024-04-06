import 'package:cpims_mobile/screens/forms/hiv_management/models/hiv_management_form_model.dart';

// class UnapprovedHIVDataModel {
//   final ARTTherapyHIVFormModel artTherapyHIVFormModel;
//   final HIVVisitationFormModel hivVisitationFormModel;
//   final String message;
//   final String ovcCpimsId;
//
//   UnapprovedHIVDataModel(
//     this.message, this.ovcCpimsId, {
//     required this.artTherapyHIVFormModel,
//     required this.hivVisitationFormModel,
//   });
//
//   factory UnapprovedHIVDataModel.fromJson(Map<String, dynamic> json) {
//     return UnapprovedHIVDataModel(
//       json['message'] as String,
//       json['ovc_cpims_id'] as String,
//       artTherapyHIVFormModel: ARTTherapyHIVFormModel.fromJson(json),
//       hivVisitationFormModel: HIVVisitationFormModel.fromJson(json),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final toJsonData = {
//       ...artTherapyHIVFormModel.toJson(),
//       ...hivVisitationFormModel.toJson(),
//     };
//     return {
//       'message': message,
//       ...toJsonData,
//     };
//   }
//
//   @override
//   String toString() {
//     return 'UnapprovedHIVDataModel {'
//         'message: $message, '
//         'art_therapy_hiv_form_model: $artTherapyHIVFormModel, '
//         'hiv_visitation_form_model: $hivVisitationFormModel, '
//         '}';
//   }
// }

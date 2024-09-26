import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/models/hiv_management_form_model.dart';
import 'package:flutter/foundation.dart';



class HIVManagementFormProvider extends ChangeNotifier {
  HivManagementFormModel _hivManagementFormModel = HivManagementFormModel();

  HivManagementFormModel get hivManagementFormModel => _hivManagementFormModel;

  final CaseLoadModel _caseLoadModel = CaseLoadModel();

  CaseLoadModel get caseLoadModel => _caseLoadModel;

  String? formUuid;

  void updateFormHivManagementModel({
    String? dateHIVConfirmedPositive,
    String? dateTreatmentInitiated,
    String? baselineHEILoad,
    String? dateStartedFirstLine,
    String? arvsSubWithFirstLine,
    String? arvsSubWithFirstLineDate,
    String? switchToSecondLine,
    String? switchToSecondLineDate,
    String? switchToThirdLine,
    String? switchToThirdLineDate,
    String? visitDate,
    String? durationOnARTs,
    String? height,
    String? mUAC,
    String? arvDrugsAdherence,
    String? arvDrugsDuration,
    String? adherenceCounseling,
    String? treatmentSupporter,
    String? treatmentSupporterSex,
    String? treatmentSupporterAge,
    String? treatmentSupporterHIVStatus,
    String? viralLoadResults,
    String? labInvestigationsDate,
    String? detectableViralLoadInterventions,
    String? disclosure,
    String? mUACScore,
    String? zScore,
    List<String>? nutritionalSupport,
    String? supportGroupStatus,
    String? nhifEnrollment,
    String? nhifEnrollmentStatus,
    String? referralServices,
    String? nextAppointmentDate,
    String? peerEducatorName,
    String? peerEducatorContact,
  }) {
    _hivManagementFormModel = _hivManagementFormModel.copyWith(
      dateHIVConfirmedPositive: dateHIVConfirmedPositive,
      dateTreatmentInitiated: dateTreatmentInitiated,
      baselineHEILoad: baselineHEILoad,
      dateStartedFirstLine: dateStartedFirstLine,
      arvsSubWithFirstLine: arvsSubWithFirstLine,
      arvsSubWithFirstLineDate: arvsSubWithFirstLineDate,
      switchToSecondLine: switchToSecondLine,
      switchToSecondLineDate: switchToSecondLineDate,
      switchToThirdLine: switchToThirdLine,
      switchToThirdLineDate: switchToThirdLineDate,
      visitDate: visitDate,
      durationOnARTs: durationOnARTs,
      height: height,
      mUAC: mUAC,
      arvDrugsAdherence: arvDrugsAdherence,
      arvDrugsDuration: arvDrugsDuration,
      adherenceCounseling: adherenceCounseling,
      treatmentSupporter: treatmentSupporter,
      treatmentSupporterSex: treatmentSupporterSex,
      treatmentSupporterAge: treatmentSupporterAge,
      treatmentSupporterHIVStatus: treatmentSupporterHIVStatus,
      viralLoadResults: viralLoadResults,
      labInvestigationsDate: labInvestigationsDate,
      detectableViralLoadInterventions: detectableViralLoadInterventions,
      disclosure: disclosure,
      mUACScore: mUACScore,
      zScore: zScore,
      nutritionalSupport: nutritionalSupport,
      supportGroupStatus: supportGroupStatus,
      nhifEnrollment: nhifEnrollment,
      nhifEnrollmentStatus: nhifEnrollmentStatus,
      referralServices: referralServices,
      nextAppointmentDate: nextAppointmentDate,
      peerEducatorName: peerEducatorName,
      peerEducatorContact: peerEducatorContact,
    );
    notifyListeners();
  }

  // Check if all fields are filled
  bool areAllFieldsFilled() {
    return _hivManagementFormModel.dateHIVConfirmedPositive.isNotEmpty &&
        _hivManagementFormModel.dateTreatmentInitiated.isNotEmpty &&
        _hivManagementFormModel.baselineHEILoad.isNotEmpty &&
        _hivManagementFormModel.dateStartedFirstLine.isNotEmpty &&
        _hivManagementFormModel.arvsSubWithFirstLine.isNotEmpty &&
        _hivManagementFormModel.switchToSecondLine.isNotEmpty &&
        _hivManagementFormModel.switchToThirdLine.isNotEmpty &&
        _hivManagementFormModel.visitDate.isNotEmpty &&
        _hivManagementFormModel.durationOnARTs.isNotEmpty &&
        _hivManagementFormModel.height.isNotEmpty &&
        _hivManagementFormModel.mUAC.isNotEmpty &&
        _hivManagementFormModel.arvDrugsAdherence.isNotEmpty &&
        _hivManagementFormModel.arvDrugsDuration.isNotEmpty &&
        _hivManagementFormModel.adherenceCounseling.isNotEmpty &&
        _hivManagementFormModel.treatmentSupporter.isNotEmpty &&
        _hivManagementFormModel.treatmentSupporterSex.isNotEmpty &&
        _hivManagementFormModel.treatmentSupporterAge.isNotEmpty &&
        _hivManagementFormModel.treatmentSupporterHIVStatus.isNotEmpty &&
        _hivManagementFormModel.viralLoadResults.isNotEmpty &&
        _hivManagementFormModel.labInvestigationsDate.isNotEmpty &&
        _hivManagementFormModel.detectableViralLoadInterventions.isNotEmpty &&
        _hivManagementFormModel.disclosure.isNotEmpty &&
        _hivManagementFormModel.mUACScore.isNotEmpty &&
        _hivManagementFormModel.zScore.isNotEmpty &&
        _hivManagementFormModel.nutritionalSupport.isNotEmpty &&
        _hivManagementFormModel.supportGroupStatus.isNotEmpty &&
        _hivManagementFormModel.nhifEnrollment.isNotEmpty &&
        _hivManagementFormModel.nhifEnrollmentStatus.isNotEmpty &&
        _hivManagementFormModel.referralServices.isNotEmpty &&
        _hivManagementFormModel.nextAppointmentDate.isNotEmpty &&
        _hivManagementFormModel.peerEducatorName.isNotEmpty &&
        _hivManagementFormModel.peerEducatorContact.isNotEmpty;
  }

  // Clear the form
  void clearFormHmF() {
    _hivManagementFormModel = HivManagementFormModel();
    notifyListeners();
  }


  Future<bool> submitHIVManagementForm(
      String? cpimsID,
      String? caregiverCpimsId,
      String uuid,
      String startTimeInterview,
      String formType,
      ) async {
    try {
      final formData = {
        'ovc_cpims_id': cpimsID,
        'caregiver_cpims_id': caregiverCpimsId,
        ..._hivManagementFormModel.toJson()
      };

      print("The data being saved is $formData");

      if (kDebugMode) {
        print("The data being saved is $formData");
      }

      if (kDebugMode) {
        print(_hivManagementFormModel.nutritionalSupport);
      }

      // save data locally
      bool isFormSaved = await LocalDb.instance.insertHMFFormData(
        cpimsID!,
        caregiverCpimsId!,
        _hivManagementFormModel,
        uuid,
        startTimeInterview,
        formType,
        false,
        null,
      );

      if (isFormSaved) {
        clearFormHmF();
        return true; // Form saved successfully
      } else {
        return false; // Form save failed
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false; // Exception occurred during form save
    }
  }
}

// class HIVManagementFormProvider extends ChangeNotifier {
//   HivManagementFormModel _hivManagementFormModel = HivManagementFormModel();
//
//   HivManagementFormModel get hivManagementFormModel => _hivManagementFormModel;
//
//   final CaseLoadModel _caseLoadModel = CaseLoadModel();
//
//   CaseLoadModel get caseLoadModel => _caseLoadModel;
//
//   String? formUuid;
//
//   void updateHIVVisitationModel(HivManagementFormModel formModel) {
//     _hivManagementFormModel = formModel;
//     notifyListeners();
//     if (kDebugMode) {
//       print(_hivManagementFormModel.toJson());
//     }
//   }
//
//   // clear form data
//   void clearForms() {
//     _hivManagementFormModel = HivManagementFormModel();
//     notifyListeners();
//   }
//
//   void updateFormUuid(String? formUuid) {
//     this.formUuid = formUuid;
//     notifyListeners();
//   }
//
//   // submit form
//   Future<bool> submitHIVManagementForm(
//       String? cpimsID,
//       String? caregiverCpimsId,
//       String uuid,
//       String startTimeInterview,
//       String formType,
//       ) async {
//     try {
//       final formData = {
//         'ovc_cpims_id': cpimsID,
//         'caregiver_cpims_id': caregiverCpimsId,
//         ..._hivManagementFormModel.toJson()
//       };
//
//       print("The data being saved is $formData");
//
//       if (kDebugMode) {
//         print("The data being saved is $formData");
//       }
//
//       if (kDebugMode) {
//         print(_hivManagementFormModel.nutritionalSupport);
//       }
//
//       // save data locally
//       bool isFormSaved = await LocalDb.instance.insertHMFFormData(
//         cpimsID!,
//         caregiverCpimsId!,
//         _hivManagementFormModel,
//         uuid,
//         startTimeInterview,
//         formType,
//         false,
//         null,
//       );
//
//       if (isFormSaved) {
//         clearForms();
//         return true; // Form saved successfully
//       } else {
//         return false; // Form save failed
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//       return false; // Exception occurred during form save
//     }
//   }
// }

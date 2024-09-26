
// class UnapprovedHIVManagementProvider {
//   Future<void> createTable(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE IF NOT EXISTS unapproved_hiv (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         ovc_cpims_id TEXT,
//         date_of_event TEXT,
//         HIV_MGMT_1_A TEXT,
//         HIV_MGMT_1_B TEXT,
//         HIV_MGMT_1_C TEXT,
//         HIV_MGMT_1_D TEXT,
//         HIV_MGMT_1_E TEXT,
//         HIV_MGMT_1_E_DATE TEXT,
//         HIV_MGMT_1_F TEXT,
//         HIV_MGMT_1_F_DATE TEXT,
//         HIV_MGMT_1_G TEXT,
//         HIV_MGMT_1_G_DATE TEXT,
//         HIV_MGMT_2_A TEXT,
//         HIV_MGMT_2_B TEXT,
//         HIV_MGMT_2_C TEXT,
//         HIV_MGMT_2_D TEXT,
//         HIV_MGMT_2_E TEXT,
//         HIV_MGMT_2_F TEXT,
//         HIV_MGMT_2_G TEXT,
//         HIV_MGMT_2_H_2 TEXT,
//         HIV_MGMT_2_H_3 TEXT,
//         HIV_MGMT_2_H_4 TEXT,
//         HIV_MGMT_2_H_5 TEXT,
//         HIV_MGMT_2_I_1 TEXT,
//         HIV_MGMT_2_I_DATE TEXT,
//         HIV_MGMT_2_J TEXT,
//         HIV_MGMT_2_K TEXT,
//         HIV_MGMT_2_L_1 TEXT,
//         HIV_MGMT_2_L_2 TEXT,
//         HIV_MGMT_2_M TEXT,
//         HIV_MGMT_2_N TEXT,
//         HIV_MGMT_2_O_1 TEXT,
//         HIV_MGMT_2_O_2 TEXT,
//         HIV_MGMT_2_P TEXT,
//         HIV_MGMT_2_Q TEXT,
//         HIV_MGMT_2_R TEXT,
//         HIV_MGMT_2_S TEXT,
//         message TEXT NOT NULL
//       )
//     ''');
//   }
//
//   Future<void> insertUnapprovedHIVManagementData(
//       Database db, UnapprovedHIVDataModel unapprovedHIVD) async {
//     try {
//       await db.insert("unapproved_hiv", {
//         'ovc_cpims_id': unapprovedHIVD.ovcCpimsId,
//         'date_of_event': unapprovedHIVD.artTherapyHIVFormModel.dateOfEvent,
//         'HIV_MGMT_1_A':
//             unapprovedHIVD.artTherapyHIVFormModel.dateHIVConfirmedPositive,
//         'HIV_MGMT_1_B':
//             unapprovedHIVD.artTherapyHIVFormModel.dateTreatmentInitiated,
//         'HIV_MGMT_1_C': unapprovedHIVD.artTherapyHIVFormModel.baselineHEILoad,
//         'HIV_MGMT_1_D':
//             unapprovedHIVD.artTherapyHIVFormModel.dateStartedFirstLine,
//         'HIV_MGMT_1_E':
//             unapprovedHIVD.artTherapyHIVFormModel.arvsSubWithFirstLine,
//         'HIV_MGMT_1_E_DATE':
//             unapprovedHIVD.artTherapyHIVFormModel.arvsSubWithFirstLineDate,
//         'HIV_MGMT_1_F':
//             unapprovedHIVD.artTherapyHIVFormModel.switchToSecondLine,
//         'HIV_MGMT_1_F_DATE':
//             unapprovedHIVD.artTherapyHIVFormModel.switchToSecondLineDate,
//         'HIV_MGMT_1_G': unapprovedHIVD.artTherapyHIVFormModel.switchToThirdLine,
//         'HIV_MGMT_1_G_DATE':
//             unapprovedHIVD.artTherapyHIVFormModel.switchToThirdLineDate,
//         'HIV_MGMT_2_A': unapprovedHIVD.hivVisitationFormModel.visitDate,
//         'HIV_MGMT_2_B': unapprovedHIVD.hivVisitationFormModel.durationOnARTs,
//         'HIV_MGMT_2_C': unapprovedHIVD.hivVisitationFormModel.height,
//         'HIV_MGMT_2_D': unapprovedHIVD.hivVisitationFormModel.mUAC,
//         'HIV_MGMT_2_E': unapprovedHIVD.hivVisitationFormModel.arvDrugsAdherence,
//         'HIV_MGMT_2_F': unapprovedHIVD.hivVisitationFormModel.arvDrugsDuration,
//         'HIV_MGMT_2_G':
//             unapprovedHIVD.hivVisitationFormModel.adherenceCounseling,
//         'HIV_MGMT_2_H_2':
//             unapprovedHIVD.hivVisitationFormModel.treatmentSupporter,
//         'HIV_MGMT_2_H_3':
//             unapprovedHIVD.hivVisitationFormModel.treatmentSupporterSex,
//         'HIV_MGMT_2_H_4':
//             unapprovedHIVD.hivVisitationFormModel.treatmentSupporterAge,
//         'HIV_MGMT_2_H_5':
//             unapprovedHIVD.hivVisitationFormModel.treatmentSupporterHIVStatus,
//         'HIV_MGMT_2_I_1':
//             unapprovedHIVD.hivVisitationFormModel.viralLoadResults,
//         'HIV_MGMT_2_I_DATE':
//             unapprovedHIVD.hivVisitationFormModel.labInvestigationsDate,
//         'HIV_MGMT_2_J': unapprovedHIVD
//             .hivVisitationFormModel.detectableViralLoadInterventions,
//         'HIV_MGMT_2_K': unapprovedHIVD.hivVisitationFormModel.disclosure,
//         'HIV_MGMT_2_L_1': unapprovedHIVD.hivVisitationFormModel.mUACScore,
//         'HIV_MGMT_2_L_2': unapprovedHIVD.hivVisitationFormModel,
//         'HIV_MGMT_2_M':
//             unapprovedHIVD.hivVisitationFormModel.nhifEnrollmentStatus,
//         'HIV_MGMT_2_N':
//             unapprovedHIVD.hivVisitationFormModel.supportGroupStatus,
//         'HIV_MGMT_2_O_1': unapprovedHIVD.hivVisitationFormModel.nhifEnrollment,
//         'HIV_MGMT_2_O_2':
//             unapprovedHIVD.hivVisitationFormModel.nhifEnrollmentStatus,
//         'HIV_MGMT_2_P': unapprovedHIVD.hivVisitationFormModel.referralServices,
//         'HIV_MGMT_2_Q':
//             unapprovedHIVD.hivVisitationFormModel.nextAppointmentDate,
//         'HIV_MGMT_2_R': unapprovedHIVD.hivVisitationFormModel.peerEducatorName,
//         'HIV_MGMT_2_S':
//             unapprovedHIVD.hivVisitationFormModel.peerEducatorContact,
//         'message': unapprovedHIVD.message,
//       });
//     } catch (e, stackTrace) {
//       if (kDebugMode) {
//         print('Error inserting case plan: $e');
//       }
//       if (kDebugMode) {
//         print('Stack trace: $stackTrace');
//       }
//     }
//   }
//
//   Future<List<Map<String, dynamic>>> fetchUnapprovedHMFFormData(
//       Database db) async {
//     try {
//       final res = await db.rawQuery('''
//         SELECT * FROM unapproved_hiv
//       ''');
//
//       List<Map<String, dynamic>> unapprovedHIVList = [];
//
//       for (var result in res) {
//         unapprovedHIVList.add(result);
//       }
//
//       return unapprovedHIVList;
//     } catch (e, stackTrace) {
//       if (kDebugMode) {
//         print('Error inserting case plan: $e');
//       }
//       if (kDebugMode) {
//         print('Stack trace: $stackTrace');
//       }
//     }
//     return [];
//   }
//
//   Future<void> deleteUnapprovedHIVData(Database db, int id) async {
//     try {
//       await db.delete('unapproved_hiv', where: 'id = ?', whereArgs: [id]);
//     } catch (e, stackTrace) {
//       if (kDebugMode) {
//         print('Error deleting unapproved hiv data: $e');
//       }
//       if (kDebugMode) {
//         print('Stack trace: $stackTrace');
//       }
//     }
//   }
// }

import 'package:cpims_mobile/Models/caseplan_form_model.dart';
import 'package:cpims_mobile/Models/unapproved_caseplan_form_model.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common/sqlite_api.dart';

class UnapprovedCptProvider {
  Future<void> createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS unapproved_cpt (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ovc_cpims_id TEXT NOT NULL,
        date_of_event TEXT NOT NULL,
        form_date_synced TEXT NULL,
        message TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertUnapprovedCasePlanData(
      Database db, UnapprovedCasePlanModel unapprovedCasePlan) async {
    try {
      // insert data into table
      await db.transaction((txn) async {
        final unapprovedCasePlanId = await txn.insert(
          "unapproved_cpt",
          {
            "ovc_cpims_id": unapprovedCasePlan.ovcCpimsId,
            "date_of_event": unapprovedCasePlan.dateOfEvent,
            "form_date_synced": null,
            "message": unapprovedCasePlan.message,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        for (var service in unapprovedCasePlan.services) {
          final serviceIdList = service.serviceIds.join(',');
          final responsibleIdList = service.responsibleIds.join(',');

          await txn.insert("case_plan_services", {
            'unapproved_form_id': unapprovedCasePlanId,
            'domain_id': service.domainId,
            'goal_id': service.goalId,
            'gap_id': service.gapId,
            'priority_id': service.priorityId,
            'results_id': service.resultsId,
            'reason_id': service.reasonId,
            'completion_date': service.completionDate ?? '',
            'service_ids': serviceIdList,
            'responsible_ids': responsibleIdList,
          });
        }
      });
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error inserting case plan: $e');
      }
      if (kDebugMode) {
        print('Stack trace: $stackTrace');
      }
    }
  }

  // function to get all unapproved caseplan data
  Future<List<UnapprovedCasePlanModel>> getAllUnapprovedCasePlanData(
      Database db) async {
    try {
      final res = await db.rawQuery('''
  SELECT * FROM unapproved_cpt
''');

      List<UnapprovedCasePlanModel> unapprovedCasePlanList = [];

      for (var result in res) {
        final unapprovedCasePlanId = result['id'];

        final serviceRes = await db.rawQuery('''
      SELECT * FROM case_plan_services WHERE unapproved_form_id = $unapprovedCasePlanId
    ''');

        print("Service Response $serviceRes");

        List<CasePlanServiceModel> serviceList = [];
        for (var service in serviceRes) {
          serviceList.add(CasePlanServiceModel(
            domainId: service['domain_id'] as String,
            serviceIds: (service['service_ids'] as String).split(','),
            goalId: service['goal_id'] as String,
            gapId: service['gap_id'] as String,
            priorityId: service['priority_id'] as String,
            responsibleIds: (service['responsible_ids'] as String).split(','),
            resultsId: service['results_id'] as String,
            reasonId: service['reason_id'] as String,
            completionDate: service['completion_date'] as String,
          ));
        }

        print("Service List $serviceList");

        unapprovedCasePlanList.add(UnapprovedCasePlanModel(
          id: result['id'] as int,
          ovcCpimsId: result['ovc_cpims_id'] as String,
          dateOfEvent: result['date_of_event'] as String,
          services: serviceList,
          message: result['message'] as String,
        ));

        print("Unapproved list $unapprovedCasePlanList");
      }
      return unapprovedCasePlanList;
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving case plans: $e');
      }
      return [];
    }
    return [];
  }

// function to delete unapproved caseplan data
  Future<void> deleteUnapprovedCasePlanData(Database db, int id) async {
    try {
      await db.delete('unapproved_cpt', where: 'id = ?', whereArgs: [id]);
      await db
          .delete('case_plan_services', where: 'form_id = ?', whereArgs: [id]);
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting case plan: $e');
      }
    }
  }

}
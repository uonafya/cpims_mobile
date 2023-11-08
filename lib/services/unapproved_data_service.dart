import 'dart:convert';
import 'dart:ffi';
import 'package:cpims_mobile/Models/unapproved_caseplan_form_model.dart';
import 'package:cpims_mobile/Models/unapproved_form_1_model.dart';

import '../providers/db_provider.dart';
import '../providers/unapproved_cpt_provider.dart';

const String _formType1A = "form1a";
const String _formType1B = "form1b";

class UnapprovedDataService {
  static Future<void> fetchRemoteUnapprovedData(access) async {
    var endpoints = [
      "mobile/unaccepted_records/F1A/",
      "mobile/unaccepted_records/F1B/",
      "mobile/unaccepted_records/caseplan/",
      "mobile/unaccepted_records/cpara/"
    ];

    List<Future<void>> futures = endpoints.map((endpoint) async {
      final db = LocalDb.instance;
      // var response = await ApiService().getSecureData(endpoint, access);
      // final List<Map<String, dynamic>> jsonData = json.decode(response.body);
      var jsonData = json.decode(
          '[{"ovc_cpims_id":"4027465","uuid":"7ec23585-8e56-44bc-8a92-d68c490421ca","date_of_event":"2023-11-05","services":[{"domain_id":"DEDU","service_id":"CP92SCs"}],"critical_events":[{"event_id":"CEOCE4","event_date":"2023-11-05"}],"app_form_metadata":{"form_id":"7ec23585-8e56-44bc-8a92-d68c490421ca","location_lat":"-1.3093283","location_long":"36.81252","start_of_interview":"2023-11-07 15:53:54.935785","end_of_interview":"2023-11-07T15:54:29.973195","form_type":"form1a"}, "message" : "Reason for rejection"}]');
      var cptJsonData = json.decode(
          "[{\"id\":1,\"ovc_cpims_id\":\"3437286\",\"date_of_event\":\"2023-11-08T12:15:08.131838\",\"message\":\"Reasonforunapproval\",\"services\":[{\"domain_id\":\"DHNU\",\"service_id\":[\"CP14HE\"],\"goal_id\":\"GH2HE\",\"gap_id\":\"GN12HE\",\"priority_id\":\"P13HE\",\"responsible_id\":[\"RCHV\"],\"results_id\":\"AC\",\"reason_id\":\"Reasons\",\"completion_date\":\"2023-11-08T00:00:00.000\"},{\"domain_id\":\"DPRO\",\"service_id\":[\"CP62SA\",\"CP64SA\"],\"goal_id\":\"GH6SA\",\"gap_id\":\"GN63SA\",\"priority_id\":\"P63SA\",\"responsible_id\":[\"RCHV\",\"RDCS\",\"RHHM\"],\"results_id\":\"AC\",\"reason_id\":\"Reasons\",\"completion_date\":\"\"},{\"domain_id\":\"DHES\",\"service_id\":[\"CP51ST\",\"CP53ST\"],\"goal_id\":\"GH5ST\",\"gap_id\":\"GN51ST\",\"priority_id\":\"P52ST\",\"responsible_id\":[\"RCHV\"],\"results_id\":\"NA\",\"reason_id\":\"Reasonslast\",\"completion_date\":\"\"},{\"domain_id\":\"DEDU\",\"service_id\":[\"CP93SC\",\"CP94SC\",\"CP91SC\"],\"goal_id\":\"GH9SC\",\"gap_id\":\"GN93SC\",\"priority_id\":\"P92SC\",\"responsible_id\":[\"RCHV\",\"RNGO\"],\"results_id\":\"NA\",\"reason_id\":\"Reasons\",\"completion_date\":\"2023-11-08T00:00:00.000\"}]}]");

      if (endpoint == endpoints[0]) {
        for (var map in jsonData) {
          final unapprovedForm1A = UnapprovedForm1DataModel.fromJson(map);
          db.insertUnapprovedForm1Data(_formType1A, unapprovedForm1A,
              unapprovedForm1A.appFormMetaData, unapprovedForm1A.uuid);
        }
      } else if (endpoint == endpoints[1]) {
        for (var map in jsonData) {
          final unapprovedForm1B = UnapprovedForm1DataModel.fromJson(map);
          db.insertUnapprovedForm1Data(_formType1B, unapprovedForm1B,
              unapprovedForm1B.appFormMetaData, unapprovedForm1B.uuid);
        }
      } else if (endpoint == endpoints[2]) {
        for (var map in cptJsonData) {
          final unapprovedCptData = UnapprovedCasePlanModel.fromJson(map);
          final unapprovedCpt = UnapprovedCptProvider();
          var localdb = await db.database;
          unapprovedCpt.insertUnapprovedCasePlanData(localdb, unapprovedCptData);
        }
      } else if (endpoint == endpoints[3]) {
        // Handle CPara
      }
      return;
    }).toList();

    await Future.wait(futures);
    return;
  }

  static Future<List<UnapprovedForm1DataModel>>
      fetchLocalUnapprovedForm1AData() async {
    final db = LocalDb.instance;
    List<Map<String, dynamic>> maps =
        await db.queryAllUnapprovedForm1Rows(_formType1A);
    List<UnapprovedForm1DataModel> unapprovedForm1Data = [];
    for (var map in maps) {
      unapprovedForm1Data.add(UnapprovedForm1DataModel.fromJson(map));
    }
    return unapprovedForm1Data;
  }

  static Future<List<UnapprovedForm1DataModel>>
      fetchLocalUnapprovedForm1BData() async {
    final db = LocalDb.instance;
    List<Map<String, dynamic>> maps =
        await db.queryAllUnapprovedForm1Rows(_formType1B);
    List<UnapprovedForm1DataModel> unapprovedForm1Data = [];
    for (var map in maps) {
      unapprovedForm1Data.add(UnapprovedForm1DataModel.fromJson(map));
    }
    return unapprovedForm1Data;
  }

  static Future<List<UnapprovedCasePlanModel>> fetchLocalUnapprovedCasePlanData() async {
    final db = LocalDb.instance;
    final unapprovedCpt = UnapprovedCptProvider();
    var localdb = await db.database;
    List<UnapprovedCasePlanModel> unapprovedCptList = await unapprovedCpt.getAllUnapprovedCasePlanData(localdb);
    return unapprovedCptList;
  }
}

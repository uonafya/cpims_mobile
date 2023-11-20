import 'dart:convert';
import 'dart:ffi';
import 'package:cpims_mobile/Models/unapproved_caseplan_form_model.dart';
import 'package:cpims_mobile/Models/unapproved_form_1_model.dart';

import '../providers/db_provider.dart';
import '../providers/unapproved_cpt_provider.dart';
import 'api_service.dart';

const String _formType1A = "form1a";
const String _formType1B = "form1b";

class UnapprovedDataService {
  static Future<void> fetchRemoteUnapprovedData(access) async {
    var endpoints = [
      "mobile/unaccepted_records/F1A/",
      "mobile/unaccepted_records/F1B/",
      "mobile/unaccepted_records/cpt/",
      "mobile/unaccepted_records/cpara/"
    ];

    List<Future<void>> futures = endpoints.map((endpoint) async {
      final db = LocalDb.instance;
      var response = await ApiService().getSecureData(endpoint, access);
      final List<dynamic> jsonData = json.decode(response.body);
      // var jsonData = json.decode(
      //     '[{"ovc_cpims_id":"4027465","id":"7ec23585-8e56-44bc-8a92-d68c490421ca","date_of_event":"2023-11-05", "services":[{"domain_id":"DHNU","service_id":"CP12HEs"},{"domain_id":"DHNU","service_id":"CP14HEs"},{"domain_id":"DHES","service_id":"C 55STs"},{"domain_id":"DHES","service_id":"CP57aSTs"},{"domain_id":"DHES","service_id":"CP53aSTs"},{"domain_id":"DPRO","service_id":"CP63aSAs"},{"domain_id":"DPRO","service_id":"CP63bSAs"},{"domain_id":"DPRO","service_id":"CP61SAs"},{"domain_id":"DEDU","service_id":"CP93SCs"},{"domain_id":"DEDU","service_id":"CP94aSCs"}],"critical_events":[{"event_id":"CEOCE3","event_date":"2023-11-07"},{"event_id":"CEOCE2","event_date":"2023-11-07"},{"event_id":"CEOCE4","event_date":"2023-11-07"},{"event_id":"CEOCE5","event_date":"2023-11-07"}], "app_form_metadata":{"form_id":"7ec23585-8e56-44bc-8a92-d68c490421ca","location_lat":"-1.3093283","location_long":"36.81252","start_of_interview":"2023-11-07 15:53:54.935785","end_of_interview":"2023-11-07T15:54:29.973195","form_type":"form1a"}, "message" : "Reason for rejection"}]');
      var cptJsonData = json.decode(
          '[{"ovc_cpims_id":"3799369","date_of_event":"2023-11-13","message":"Reason for rejection","services":[{"domain_id":"DHNU","service_id":["CP11HE","CP12 HE"],"goal_id":"GH1HE","gap_id":"GN12HE","priority_id":"P11HE","responsible_id":["RCGH"],"results_id":"AC","reason_id":"reason","completion_date":""},{"domain_id":"DPRO","service_id":["CP61SA"],"goal_id":"GH6SA","gap_id":"GN61SA","priority_id":"P61SA","responsible_id":["RCGH"],"results_id":"AC","reason_id":"moxat","completion_date":"2023-11-13T00:00:00.000"},{"domain_id":"DHES","service_id":["CP511S"],"goal_id":"GH5ST","gap_id":"GN51ST","priority_id":"P51ST","responsible_id":["RCGH"],"results_id":"AC","reason_id":"teysy","completion_date":""},{"domain_id":"DEDU","service_id":["CP91SC"],"goal_id":"GH9SC","gap_id":"GN91SC","priority_id":"P91SC","responsible_id":["RCGH"],"results_id":"AC","reason_id":"yuujjjjjjjjjjjjjj","completion_date":""}]}]');

      if (endpoint == endpoints[0]) {
        for (var map in jsonData) {
          final unapprovedForm1A = UnapprovedForm1DataModel.fromJson(map);
          db.insertUnapprovedForm1Data(_formType1A, unapprovedForm1A,
              unapprovedForm1A.appFormMetaData, unapprovedForm1A.id);
        }
      } else if (endpoint == endpoints[1]) {
        for (var map in jsonData) {
          final unapprovedForm1B = UnapprovedForm1DataModel.fromJson(map);
          db.insertUnapprovedForm1Data(_formType1B, unapprovedForm1B,
              unapprovedForm1B.appFormMetaData, unapprovedForm1B.id);
        }
      } else if (endpoint == endpoints[2]) {
        for (var map in cptJsonData) {
          final unapprovedCptData = UnapprovedCasePlanModel.fromJson(map);
          final unapprovedCpt = UnapprovedCptProvider();
          var localdb = await db.database;
          unapprovedCpt.insertUnapprovedCasePlanData(
              localdb, unapprovedCptData);
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

  static Future<List<UnapprovedCasePlanModel>>
      fetchLocalUnapprovedCasePlanData() async {
    final db = LocalDb.instance;
    final unapprovedCpt = UnapprovedCptProvider();
    var localdb = await db.database;
    List<UnapprovedCasePlanModel> unapprovedCptList =
        await unapprovedCpt.getAllUnapprovedCasePlanData(localdb);
    return unapprovedCptList;
  }

  static Future<bool> deleteUnapprovedForm1(int id) async {
    final db = LocalDb.instance;
    return await db.deleteUnApprovedForm1Data(id);
  }

  static Future<bool> deleteUnapprovedCpt(int id) async {
    final db = LocalDb.instance;
    final unapprovedCpt = UnapprovedCptProvider();
    var localdb = await db.database;
    return await unapprovedCpt.deleteUnapprovedCasePlanData(localdb, id);
  }
}

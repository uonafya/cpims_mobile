import 'dart:convert';
import 'package:cpims_mobile/Models/unapproved_form_1_model.dart';

import '../providers/db_provider.dart';

const String _formType1A = "form1a";
const String _formType1B = "form1b";


class UnapprovedDataService {
  static Future<List> fetchRemoteUnapprovedData(access) async {
    var endpoints = [
      "mobile/unaccepted_records/F1A/",
      "mobile/unaccepted_records/F1B/",
      "mobile/unaccepted_records/caseplan/",
      "mobile/unaccepted_records/cpara/"
    ];

    var futures = endpoints.map((endpoint) async {
      // var response = await ApiService().getSecureData(endpoint, access);
      // final Map<String, dynamic> jsonData = json.decode(response.body);
      final Map<String, dynamic> jsonData = json.decode('{"ovc_cpims_id":"4027465","uuid":"7ec23585-8e56-44bc-8a92-d68c490421ca","date_of_event":"2023-11-05","services":[{"domain_id":"DEDU","service_id":"CP92SCs"}],"critical_events":[{"event_id":"CEOCE4","event_date":"2023-11-05"}],"app_form_metadata":{"form_id":"7ec23585-8e56-44bc-8a92-d68c490421ca","location_lat":"-1.3093283","location_long":"36.81252","start_of_interview":"2023-11-07 15:53:54.935785","end_of_interview":"2023-11-07T15:54:29.973195","form_type":"form1a"}, "message" : "Reason for rejection"}');
      if (endpoint == endpoints[0]) {
        final db = LocalDb.instance;
        final unapprovedForm1A = UnapprovedForm1DataModel.fromJson(jsonData);
        db.insertUnapprovedForm1Data(_formType1A, unapprovedForm1A, unapprovedForm1A.appFormMetaData, unapprovedForm1A.uuid);

      }
      return jsonData;
    }).toList();

    var results = await Future.wait(futures);
    return results;
  }

  static Future<List<UnapprovedForm1DataModel>> fetchLocalUnapprovedData() async {
    final db = LocalDb.instance;
    List<Map<String, dynamic>> maps = await db.queryAllUnapprovedForm1Rows(_formType1A);
    List<UnapprovedForm1DataModel> unapprovedForm1Data = [];
    for (var map in maps) {
      unapprovedForm1Data.add(UnapprovedForm1DataModel.fromJson(map));
    }
    return unapprovedForm1Data;
  }
}

import 'dart:convert';
import 'package:cpims_mobile/services/api_service.dart';

class UnapprovedDataService {
  static Future<List> fetchUnnaprovedData(access) async {
    var endpoints = [
      "mobile/unaccepted_records/F1A/",
      "mobile/unaccepted_records/F1B/",
      "mobile/unaccepted_records/caseplan/",
      "mobile/unaccepted_records/cpara/"
    ];

    var futures = endpoints.map((endpoint) async {
      var response = await ApiService().getSecureData(endpoint, access);
      var unapprovedData = json.decode(response.body);
      return unapprovedData;
    }).toList();

    var results = await Future.wait(futures);
    return results;
  }
}

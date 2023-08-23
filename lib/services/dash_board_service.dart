import 'dart:convert';

import 'package:cpims_mobile/services/api_service.dart';

class DashBoardService {
  dashBoard(access) async {
    var response = await ApiService().getSecureData("dashboard/", access);
    var dashboard = json.decode(response.body);
    print(">>>>>>>>>>>>>> dash response status ${response.statusCode}");
    print(">>>>>>>>>>>>>> dash response >>>>>>>>>>>>>>>>>  $dashboard");
    return dashboard;
  }
}

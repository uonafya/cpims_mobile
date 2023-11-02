import 'dart:convert';

import 'package:cpims_mobile/Models/statistic_model.dart';
import 'package:cpims_mobile/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardService {
  dashBoard(access) async {
    var response = await ApiService().getSecureData("api/dashboard/", access);
    var dashboard = json.decode(response.body);

    final prefs = await SharedPreferences.getInstance();

    if (response.statusCode == 200) {
      SummaryDataModel summaryDataModel = SummaryDataModel.fromJson(dashboard);
      prefs.setString('dashboard_data', jsonEncode(summaryDataModel));
      return summaryDataModel;
    }
  }

  Future<dynamic> fetchDashboardData() async {
    final prefs = await SharedPreferences.getInstance();
    var dashboardData = prefs.getString('dashboard_data');
    if (dashboardData != null) {
      return SummaryDataModel.fromJson(jsonDecode(dashboardData));
    }
  }
}

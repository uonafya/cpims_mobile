import 'dart:convert';

import 'package:cpims_mobile/Models/case_load.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CaseLoadService {
  Future<void> fetchCaseLoadData({
    required BuildContext context,
  }) async {
    try {
      final preferences = await SharedPreferences.getInstance();

      final accessToken = preferences.getString('access');
      http.Response response = await http.get(
        Uri.parse('${cpimsApiUrl}caseload'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        for (int i = 0; i < jsonDecode(response.body).length; i++) {
          CaseLoadModel caseLoadModel = CaseLoadModel.fromJson(
            jsonDecode(response.body)[i],
          );
          print(caseLoadModel.caregiver_names);
          CaseLoadDb.instance.insertDoc(caseLoadModel);
        } 
      } else {
        print("We have an issue");
      }
    } catch (e) {
      errorSnackBar(context, e.toString());
    }
  }
}

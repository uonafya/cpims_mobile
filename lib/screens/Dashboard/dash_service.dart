import 'dart:convert';

import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashService {
  // OVC-ACTIVE/EVER REGISTERED
  getDashData() async {
    var response = await ApiService().getData("random_int");
    var body = jsonDecode(response.body);
    var _ovcActiveOrRegistered = body['random_int'];
    return _ovcActiveOrRegistered;
  }
}

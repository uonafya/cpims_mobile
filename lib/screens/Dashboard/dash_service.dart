import 'dart:convert';

import 'package:cpims_mobile/services/api_service.dart';

class DashService {
  // OVC-ACTIVE/EVER REGISTERED
  getDashData() async {
    var response = await ApiService().getData("random_int");
    var body = jsonDecode(response.body);
    var ovcActiveOrRegistered = body['random_int'];
    return ovcActiveOrRegistered;
  }
}

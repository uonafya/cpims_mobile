import 'dart:convert';
import 'package:cpims_mobile/services/api_service.dart';

class UnapprovedDataService {
  static fetchUnnaprovedData(access) async {
    var response = await ApiService().getUnapprovedData("forms/", access);
    var unapprovedData = json.decode(response.body);
    return unapprovedData;
  }
}

import 'dart:convert';

import 'package:cpims_mobile/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String _url = cpims_api_url;

  //without authentication....
  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    // + await _getToken();
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  postSecData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    // + await _getToken();
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setAuthHeaders(_getToken()));
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  getSecureData(apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.get(Uri.parse(fullUrl),
        headers: _setAuthHeaders(_getToken()));
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _setAuthHeaders(token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('access_token');
    return token;
  }

  refreshToken() async {
    try {
      String apiUrl = "auth/refresh";
      SharedPreferences pref = await SharedPreferences.getInstance();
      var access = pref.getString('access');
      var refresh = pref.getString('refresh');
      String _url = this._url + apiUrl;

      http.Response response = await http.get(Uri.parse(_url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $refresh',
      });
      var res = json.decode(response.body);

      pref.setString("access", res['access'].toString());
      pref.setString("refresh", res['refresh'].toString());

      debugPrint(access);
      print("******refresh******");
      debugPrint(refresh);

      debugPrint(access);
      print("******response body******");
      debugPrint(response.body);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}

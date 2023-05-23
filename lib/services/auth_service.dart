import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class AuthService {
  static Future<http.Response> login(String password, String username) async {
    Map user = {"username": username, "password": password};
    var body = json.encode(user);
    var url = Uri.parse("${cpimsApiUrl}token/");
    http.Response response = await http.post(url, headers: headers, body: body);
    // print(response.body);
    return response;
  }
}

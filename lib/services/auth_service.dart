import 'dart:convert';

import 'package:cpims_mobile/providers/http_response_handler.dart';
import 'package:cpims_mobile/screens/homepage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class AuthService {
  Future<void> login({
    required BuildContext context,
    required String password,
    required String username,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.post(
      Uri.parse(
        '${cpimsApiUrl}token/',
      ),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (context.mounted) {
      httpReponseHandler(
        response: response,
        context: context,
        onSuccess: () async {
          final responseData = json.decode(response.body);

          await prefs.setString('access', responseData['access']);
          await prefs.setString('refresh', responseData['refresh']);

          Get.off(() => const Homepage(),
              transition: Transition.fadeIn,
              duration: const Duration(microseconds: 300));
        },
      );
    }
  }
}

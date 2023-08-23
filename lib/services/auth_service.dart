import 'dart:convert';

import 'package:cpims_mobile/Models/user_model.dart';
import 'package:cpims_mobile/providers/auth_provider.dart';
import 'package:cpims_mobile/providers/http_response_handler.dart';
import 'package:cpims_mobile/screens/auth/login_screen.dart';
import 'package:cpims_mobile/screens/homepage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class AuthService {
  final AuthProvider authProvider;
  AuthService(this.authProvider);

  Future<void> login({
    required BuildContext context,
    required String password,
    required String username,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final AuthProvider authProvider = AuthProvider();

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

          await prefs.setInt(
            'authTokenTimestamp',
            DateTime.now().millisecondsSinceEpoch,
          );

          authProvider.setAccessToken(responseData['access']);

          UserModel userModel = UserModel(
            username: username,
            accessToken: responseData['access'],
            refreshToken: responseData['refresh'],
          );

          if (context.mounted) {
            Provider.of<AuthProvider>(context, listen: false)
                .setUser(userModel);
          }

          Get.off(() => const Homepage(),
              transition: Transition.fadeIn,
              duration: const Duration(microseconds: 300));
        },
      );
    }
  }

  // check token validity
  Future<bool> verifyToken({
    required BuildContext context,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final AuthProvider authProvider = AuthProvider();

      String? refreshToken = prefs.getString('refresh');

      int? authTokenTimestamp = prefs.getInt('authTokenTimestamp');

      if (refreshToken != null && authTokenTimestamp != null) {
        int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
        int tokenExpiryDuration =
            1800 * 1000; // Token expires after 1 hour (in milliseconds)

        if (currentTimestamp - authTokenTimestamp > tokenExpiryDuration) {
          // Token has expired -- refresh token

          // get new token
          final http.Response response = await http.post(
            Uri.parse(
              '${cpimsApiUrl}token/refresh/',
            ),
            body: {
              'refresh': refreshToken,
            },
          );

          if (context.mounted) {
            httpReponseHandler(
              response: response,
              context: context,
              onSuccess: () async {
                final responseData = json.decode(response.body);
                await prefs.remove('access');
                await prefs.setString('access', responseData['access']);

                if (context.mounted) {
                  authProvider.setUser(UserModel(
                    username: authProvider.user!.username,
                    accessToken: responseData['access'],
                    refreshToken: refreshToken,
                  ));
                }
              },
            );
          }
          return false;
        } else {
          // Token is still valid, set the token
          authProvider.setAccessToken(refreshToken);
          return true;
        }
      }
      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // logout
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      await sharedPreferences.clear();

      authProvider.clearUser();

      Get.off(
        () => const LoginScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(microseconds: 300),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

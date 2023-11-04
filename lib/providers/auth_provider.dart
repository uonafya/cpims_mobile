import 'dart:convert';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/screens/initial_loader.dart';
import 'package:http/http.dart' as http;

import 'package:cpims_mobile/Models/user_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/http_response_handler.dart';
import 'package:cpims_mobile/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user = UserModel(
    username: '',
    accessToken: '',
    refreshToken: '',
  );

  UserModel? get user => _user;

  setAccessToken(String accessToken) {
    if (user != null) {
      _user = _user.copyWith(accessToken: accessToken);
    }
    notifyListeners();
  }

  void setUser(UserModel userModel) {
    _user = userModel;
    notifyListeners();
  }

  void clearUser() {
    _user = UserModel(
      username: '',
      accessToken: '',
      refreshToken: '',
    );

    notifyListeners();
  }

  Future<void> login({
    required BuildContext context,
    required String password,
    required String username,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final AuthProvider authProvider = AuthProvider();

    final http.Response response = await http.post(
      Uri.parse(
        '${cpimsApiUrl}api/token/',
      ),
      body: {
        'username': username,
        'password': password,
      },
    );

    // TODO: Implement correct status codes
    // if (response.statusCode == "given code") {
    //   if (context.mounted) {
    //     errorSnackBar(context, 'Not authorized to view this resource');
    //     await LocalDb.instance.deleteDb();
    //   }
    //   return;
    // }

    if (context.mounted) {
      httpReponseHandler(
        response: response,
        context: context,
        onSuccess: () async {
          final responseData = json.decode(response.body);

          await prefs.setString('access', responseData['access']);
          await prefs.setString('refresh', responseData['refresh']);
          // await prefs.setBool("hasUserSetup", true);

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
            setUser(userModel);
          }

          prefs.setString('username', username);
          prefs.setString('password', password);

          Get.off(() => const InitialLoadingScreen(isFromAuth: true),
              transition: Transition.fadeIn,
              duration: const Duration(microseconds: 300));
        },
        onFailure: () {
          // clearUser();
        },
      );
    }
  }

  // logout
  Future<void> logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      await sharedPreferences.remove('access');
      await sharedPreferences.remove('refresh');

      clearUser();

      Get.off(
        () => const LoginScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(microseconds: 300),
      );
    } catch (e) {
      if (context.mounted) {
        errorSnackBar(context, e.toString());
      }
    }
  }

  Future<bool> verifyToken({
    required BuildContext context,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? refreshToken = prefs.getString('refresh');
      int? authTokenTimestamp = prefs.getInt('authTokenTimestamp');

      if (refreshToken != null && authTokenTimestamp != null) {
        int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
        int tokenExpiryDuration =
            1800 * 1000; // Token expires after 30 minutes (in milliseconds)

        if (currentTimestamp - authTokenTimestamp > tokenExpiryDuration) {
          // Token has expired -- refresh token
          // get new token
          final http.Response response = await http.post(
            Uri.parse(
              '${cpimsApiUrl}api/token/refresh/',
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
                  setUser(UserModel(
                    username: user!.username,
                    accessToken: responseData['access'],
                    refreshToken: refreshToken,
                  ));
                }
              },
              onFailure: () async {
                await logOut(context);
              },
            );
          }
          return true;
        } else {
          setAccessToken(refreshToken);
          return true;
        }
      }
    } catch (e) {
      if (context.mounted) {
        errorSnackBar(context, e.toString());
      }

      return false;
    }
    return false;
  }
}

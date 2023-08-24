import 'package:cpims_mobile/Models/user_model.dart';
import 'package:cpims_mobile/constants.dart';
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

  // logout
  Future<void> logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      await sharedPreferences.clear();

      clearUser();
      print('stated');

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
}

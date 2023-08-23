import 'package:cpims_mobile/providers/auth_provider.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/auth/login_screen.dart';
import 'package:cpims_mobile/screens/homepage/home_page.dart';
import 'package:cpims_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UIProvider(),
        ),
      ],
      child: const CPIMS(),
    ),
  );
}

class CPIMS extends StatefulWidget {
  const CPIMS({Key? key}) : super(key: key);

  @override
  State<CPIMS> createState() => _CPIMSState();
}

class _CPIMSState extends State<CPIMS> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();

    final AuthProvider authProvider = AuthProvider();

    String? refreshToken = prefs.getString('refresh');

    int? authTokenTimestamp = prefs.getInt('authTokenTimestamp');

    if (refreshToken != null && authTokenTimestamp != null) {
      int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
      int tokenExpiryDuration =
          3600 * 1000; // Token expires after 1 hour (in milliseconds)

      if (currentTimestamp - authTokenTimestamp > tokenExpiryDuration) {
        // Token has expired logout or refresh token
        authProvider.clearUser(); // Clear user data
      } else {
        // Token is still valid, set the token
        authProvider.setAccessToken(refreshToken);
      }
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 781),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'CPIMS',
          debugShowCheckedModeBanner: false,
          theme: appTheme(),
          home: Provider.of<AuthProvider>(context).user!.accessToken.isNotEmpty
              ? const Homepage()
              : const LoginScreen(),
        );
      },
    );
  }
}

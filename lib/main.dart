import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/auth/login_screen.dart';
import 'package:cpims_mobile/screens/homepage/home_page.dart';
import 'package:cpims_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final prefs = await SharedPreferences.getInstance();

void main() async {
  runApp(const CPIMS());
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
  bool isLoggedin = false;

  _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('authenticated'));
    // await prefs.remove('authenticated');

    var authKey = prefs.getString('authenticated');

    if(authKey != null){
      // isLoggedin = !isLoggedin;
      Get.to(() =>const Homepage());
    }else{
      isLoggedin = false;
    }

    return prefs.getString('authenticated');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 781),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UIProvider()),
          ],
          child: GetMaterialApp(
            title: 'CPIMS',
            debugShowCheckedModeBanner: false,
            theme: appTheme(),
            home: child,
          ),
        );
      },
      child: isLoggedin ? const Homepage() : const LoginScreen(),
    );
  }
}

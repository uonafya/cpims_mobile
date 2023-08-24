import 'package:cpims_mobile/providers/auth_provider.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/auth/login_screen.dart';
import 'package:cpims_mobile/screens/initial_loader.dart';
import 'package:cpims_mobile/screens/splash_screen.dart';
import 'package:cpims_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

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
  }

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
          home: Builder(
            builder: (context) {
              return FutureBuilder(
                future: Provider.of<AuthProvider>(context, listen: false)
                    .verifyToken(context: context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SplashScreen();
                  }
                  return snapshot.data == true
                      ? const InitialLoadingScreen()
                      : const LoginScreen();
                },
              );
            },
          ),
        );
      },
    );
  }
}

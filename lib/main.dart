import 'package:cpims_mobile/providers/auth_provider.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/auth/login_screen.dart';
import 'package:cpims_mobile/screens/homepage/home_page.dart';
import 'package:cpims_mobile/screens/splash_screen.dart';
import 'package:cpims_mobile/services/auth_service.dart';
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

  final AuthService authService = AuthService(AuthProvider());

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
          home: Builder(
            builder: (context) {
              return FutureBuilder(
                future: authService.verifyToken(context: context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Provider.of<AuthProvider>(context, listen: false)
                            .user!
                            .accessToken
                            .isNotEmpty
                        ? const Homepage()
                        : const LoginScreen();
                  }
                  return const SplashScreen();
                },
              );
            },
          ),
        );
      },
    );
  }
}

import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/connection_provider.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/homepage/home_page.dart';
import 'package:cpims_mobile/services/dash_board_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/caseload_service.dart';

class InitialLoadingScreen extends StatefulWidget {
  const InitialLoadingScreen({super.key, this.isFromAuth = false});
  final bool? isFromAuth;

  @override
  State<InitialLoadingScreen> createState() => _InitialLoadingScreenState();
}

class _InitialLoadingScreenState extends State<InitialLoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 0),
      () async {
        //TO DO: Check internet connection if not, do local auth, then fetch local data
        final hasConnection =
            await Provider.of<ConnectivityProvider>(context, listen: false)
                .checkInternetConnection();
        if (hasConnection == false) {
          if (widget.isFromAuth == false) {
            await _checkBiometric();
            await _getAvailableBiometric();
            await _authenticate();
          }
          final localDashData = await DashBoardService().fetchDashboardData();
          if (context.mounted) {
            Provider.of<UIProvider>(context, listen: false)
                .setDashData(localDashData);
          }
        } else {
          final prefs = await SharedPreferences.getInstance();
          final accessToken = prefs.getString('access');
          final dashRep = await DashBoardService().dashBoard(accessToken);

          if (context.mounted) {
            Provider.of<UIProvider>(context, listen: false)
                .setDashData(dashRep);
            await CaseLoadService().fetchCaseLoadData(
              context: context,
              isForceSync: false,
            );
          }
        }

        Get.off(() => const Homepage());
      },
    );
  }

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;

    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (_) {
      if (context.mounted) {
        errorSnackBar(context, 'Unable to check biometrics');
      }
    }

    if (!mounted) return;

    setState(() {});
  }

  Future _getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];

    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (_) {
      if (context.mounted) {
        errorSnackBar(context, 'Unable to get available biometrics');
      }
    }

    setState(() {});
  }

  final auth = LocalAuthentication();
  String authorized = " not authorized";

  Future<bool> _authenticate() async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticate(
        localizedReason: "Scan your finger to authenticate",
      );
    } on PlatformException catch (e) {
      print(e);
    }

    setState(() {
      authorized =
          authenticated ? "Authorized success" : "Failed to authenticate";
      successSnackBar(context, 'Auth success');
    });
    return authenticated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/images/logo_gok.png'),
            ),
          ],
        ),
      ),
    );
  }
}

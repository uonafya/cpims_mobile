import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/homepage/home_page.dart';
import 'package:cpims_mobile/services/caseload_service.dart';
import 'package:cpims_mobile/services/dash_board_service.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialLoadingScreen extends StatefulWidget {
  const InitialLoadingScreen({super.key});

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
        final prefs = await SharedPreferences.getInstance();
        final accessToken = prefs.getString('access');
        var dashResp = await DashBoardService().dashBoard(accessToken);
        Provider.of<UIProvider>(context, listen: false).setDashData(dashResp);
        final CaseLoadService caseLoadService = CaseLoadService();

        await caseLoadService.fetchCaseLoadData(
            context: context, isForceSync: false);
        await Provider.of<UIProvider>(context, listen: false).setCaseLoadData();

        Get.off(() => const Homepage());
      },
    );
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

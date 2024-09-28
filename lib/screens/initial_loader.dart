// ignore_for_file: use_build_context_synchronously

import 'package:android_id/android_id.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/connection_provider.dart';
import 'package:cpims_mobile/providers/cpara/unapproved_cpara_database.dart';
import 'package:cpims_mobile/providers/cpara/unapproved_cpara_service.dart';
import 'package:cpims_mobile/providers/cpara/unapproved_records_screen_provider.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/auth/login_screen.dart';
import 'package:cpims_mobile/screens/biometric_information_screen.dart';
import 'package:cpims_mobile/screens/connectivity_screen.dart';
import 'package:cpims_mobile/screens/homepage/home_page.dart';
import 'package:cpims_mobile/services/dash_board_service.dart';
import 'package:cpims_mobile/services/unapproved_data_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:cpims_mobile/services/metadata_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/auth_provider.dart';
import '../services/caseload_service.dart';
import 'locked_screen.dart';

class InitialLoadingScreen extends StatefulWidget {
  const InitialLoadingScreen(
      {super.key, this.isFromAuth = false, this.hasBioAuth = false});

  final bool? isFromAuth;
  final bool? hasBioAuth;

  @override
  State<InitialLoadingScreen> createState() => _InitialLoadingScreenState();
}

class _InitialLoadingScreenState extends State<InitialLoadingScreen> {
  List<BiometricType> availableBiometric = [];

  bool isMounted = false;

  @override
  void initState() {
    super.initState();

    isMounted = true;

    Future.delayed(
      const Duration(seconds: 0),
      () async {
        /// Here we check if the user has internet connection
        /// If they do, we fetch the dashboard data from the server
        /// If they don't, we fetch the dashboard data from the local database
        /// We then set the dashboard data in the provider
        /// We then fetch the caseload data from the server
        /// We then set the caseload data in the provider
        /// We then navigate to the homepage
        /// If the user is coming from the login screen, we don't check for biometrics because they might have used biometric login
        /// If the user is coming from the splash screen, we check for biometrics(Subsequent logins)
        try {
          // Your asynchronous operations here...

          final hasConnection =
              await Provider.of<ConnectivityProvider>(context, listen: false)
                  .checkInternetConnection();
          final prefs = await SharedPreferences.getInstance();

          final hasUserSetup = prefs.getBool("hasUserSetup"); //todo: remove
          final localDashData = await DashBoardService().fetchDashboardData();
          if (hasConnection == false) {
            if (hasUserSetup == null) {
              Get.off(() =>
                  const ConnectivityScreen(redirectScreen: LoginScreen()));
              return;
            }
            if (widget.isFromAuth == false && widget.hasBioAuth == false) {
              await _checkBiometric();
              await _getAvailableBiometric();
              final isAuth = await _authenticate();
              if (!isAuth) {
                Get.off(() =>
                    const BiometricInformation(redirectScreen: LoginScreen()));
                return;
              }
            }
            if (isMounted) {
              try {
                Provider.of<UIProvider>(context, listen: false)
                    .setDashData(localDashData);
                await Provider.of<UIProvider>(context, listen: false)
                    .setCaseLoadData();
              } catch (e) {
                rethrow;
              }
            }
          } else {
            final prefs = await SharedPreferences.getInstance();
            final accessToken = prefs.getString('access');
            final dashRep = await DashBoardService().dashBoard(accessToken);
            if (isMounted) {
              if (dashRep == null) {
                Provider.of<UIProvider>(context, listen: false)
                    .setDashData(localDashData);
              }

              Provider.of<UIProvider>(context, listen: false)
                  .setDashData(dashRep);
              const androidIdPlugin = AndroidId();
              final String? androidId = await androidIdPlugin.getId();
              if (isMounted) {
                await CaseLoadService().fetchCaseLoadData(
                  context: context,
                  isForceSync: false,
                  deviceID: androidId!,
                );
              }
              final lockApp = await AuthProvider.getAppLock();

              if (lockApp) {
                Get.off(() => const LockedScreen());
                return;
              }

              // TODO Fetch unapproved data from server
              await UnapprovedDataService.fetchRemoteUnapprovedData(accessToken);

              // fetch unapproved data from local db
              final List<UnapprovedCparaModel> cparaRecords =
                  await UnapprovedCparaService.getUnapprovedFromDB();
              if (mounted) {
                context
                    .read<UnapprovedRecordsScreenProvider>()
                    .unapprovedCparas = cparaRecords;

                await Provider.of<UIProvider>(context, listen: false)
                    .setCaseLoadData();
              }
              try {
                // await MetadataService.fetchMetadata();
                await MetadataService.saveMetadata();
              } catch (e) {
                if (kDebugMode) {
                  print("Error fetching metadata in init load: $e");
                }
              }
            }
          }
          Get.off(() => const Homepage());
        } catch (e, stackTrace) {
          if (kDebugMode) {
            print("Error in init load: $e");
            print('Stack trace: $stackTrace');
          }
        }
      },
    );
  }

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<String> getDeviceID() async {
    // get device id
    String? deviceID = '';
    if (Theme.of(context).platform == TargetPlatform.android) {
      final AndroidDeviceInfo androidDeviceInfo =
          await deviceInfoPlugin.androidInfo;
      deviceID = androidDeviceInfo.id;
      if (kDebugMode) {
        print('Device ID $deviceID');
      }
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      final IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      deviceID = iosDeviceInfo.identifierForVendor;
      if (kDebugMode) {
        print(deviceID);
      }
    }
    return deviceID!;
  }

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;

    try {
      canCheckBiometric = await auth.canCheckBiometrics;
      if (kReleaseMode && !canCheckBiometric) {
        if (mounted) {
          errorSnackBar(context, 'Biometrics not available');
        }
        return;
      }
    } on PlatformException catch (_) {
      if (context.mounted) {
        errorSnackBar(context, 'Unable to check biometrics');
      }
    }

    if (!mounted) return;

    setState(() {});
  }

  Future _getAvailableBiometric() async {
    try {
      availableBiometric = await auth.getAvailableBiometrics();
      if (availableBiometric.isEmpty) {
        errorSnackBar(context, 'Biometrics not available');
        return;
      }
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
      if (mounted) {
        errorSnackBar(context, e.message!);
      }
    }

    setState(() {
      authorized =
          authenticated ? "Authorized success" : "Failed to authenticate";
    });
    return authenticated;
  }

  @override
  void dispose() {
    super.dispose();
    isMounted = false; // Set isMounted to false when the widget is disposed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            const Spacer(),
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/images/logo_gok.png'),
            ),
            const Spacer(),
            const Text(
              'Loading...',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}

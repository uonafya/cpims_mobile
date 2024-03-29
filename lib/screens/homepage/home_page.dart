import 'dart:convert';

import 'package:cpims_mobile/Models/statistic_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/connection_provider.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/caregiver/caregiver.dart';
import 'package:cpims_mobile/screens/homepage/provider/stats_provider.dart';
import 'package:cpims_mobile/screens/homepage/widgets/statistics_item.dart';
import 'package:cpims_mobile/screens/homepage/widgets/statistics_grid_item.dart';
import 'package:cpims_mobile/screens/ovc_care/ovc_care_screen.dart';
import 'package:cpims_mobile/services/form_service.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_grid_view.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../Models/caseplan_form_model.dart';
import '../../providers/db_provider.dart';
import '../cpara/provider/db_util.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, String>> formsList = [
    {'formType': 'form1a', 'endpoint': 'F1A'},
    {'formType': 'form1b', 'endpoint': 'F1B'},
  ];

  late int formOneACount = 0;
  late int formOneBCount = 0;
  late int cparaCount = 0;
  late int ovcSubpopulatoiCount = 0;
  late int cptCount = 0;

  // late int
  int? updatedCountA = 0;
  int? updatedCountB = 0;
  int? updatedCountCpara = 0;
  int? updatedCountOvcSubpopulation = 0;
  int? updatedCptCount = 0;

  @override
  void initState() {
    super.initState();
    showCountUnsyncedForms();
    context.read<StatsProvider>().updateFormStats();
    syncWorkflows();
  }

  bool isSyncing = false;

  bool isDebugMode = false;

  bool noFormsToSync = true;

  Future<void> postCasePlansToServer() async {
    List<Map<String, dynamic>> caseplanFromDbData =
        await CasePlanService.getAllCasePlans();
    List<CasePlanModel> caseplanFromDb =
        caseplanFromDbData.map((map) => CasePlanModel.fromJson(map)).toList();

    var prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('access');
    String bearerAuth = "Bearer $accessToken";
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor());
    Database db = await LocalDb.instance.database;

    int successfulFormCount = 0;

    for (var caseplan in caseplanFromDb) {
      var payload = caseplan.toJson();
      try {
        const cptEndpoint = "mobile/cpt/";
        var response = await dio.post("$cpimsApiUrl$cptEndpoint",
            data: payload,
            options: Options(headers: {"Authorization": bearerAuth}));

        if (response.statusCode == 201) {
          updateFormCasePlanDateSync(caseplan.id!, db);
          //clear caseplan data in provider
          successfulFormCount++;
          if (successfulFormCount == caseplanFromDb.length) {
            Get.snackbar(
              'Success',
              'Successfully synced all CasePlan forms',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          }
        } else if (response.statusCode == 403) {
          Get.dialog(
            AlertDialog(
              title: const Text("Session Expired"),
              content:
                  const Text("Your session has expired. Please log in again"),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        print("The error is $e");
        Get.snackbar(
          'Error',
          'An error occurred $e',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  Future<void> updateFormCasePlanDateSync(int formId, Database db) async {
    db = await LocalDb.instance.database;
    try {
      final queryResults = await db.query(
        casePlanTable,
        where: '${CasePlan.id} = ?',
        whereArgs: [formId],
      );

      if (queryResults.isNotEmpty) {
        final caseplanData = queryResults.first[CasePlan.id] as int;
        await db.update(
          casePlanTable,
          {
            'form_date_synced': DateTime.now().toString(),
          },
          where: '${CasePlan.id} = ?',
          whereArgs: [caseplanData],
        );
      }
    } catch (e) {
      debugPrint("Error updating caseplan data: $e");
    }
  }

  Future<void> syncWorkflows() async {
    final isConnected =
        await Provider.of<ConnectivityProvider>(context, listen: false)
            .checkInternetConnection();
    if (isConnected) {
      await submitCparaToUpstream();
      await postCasePlansToServer();
      fetchAndPostToServerOvcSubpopulationDataNew();
      postFormOneToServer();
      await showCountUnsyncedForms();
      if (mounted) {
        context.read<StatsProvider>().updateFormStats();
      }
    }
  }

  Future<void> showCountUnsyncedForms() async {
    updatedCountA = (await Form1Service.getCountAllFormOneA())!;
    updatedCountB = (await Form1Service.getCountAllFormOneB())!;
    updatedCountCpara = (await Form1Service.getCountAllFormCpara())!;
    updatedCountOvcSubpopulation = await Form1Service.ovcSubCount();
    updatedCptCount = await CasePlanService.getCaseplanUnsyncedCount();
    setState(() {
      formOneACount = updatedCountA!;
      formOneBCount = updatedCountB!;
      cparaCount = updatedCountCpara!;
      ovcSubpopulatoiCount = updatedCountOvcSubpopulation!;
      cptCount = updatedCptCount!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final SummaryDataModel? dashData =
        context.select((UIProvider provider) => provider.getDashData);

    StatsProvider formStats = context.watch<StatsProvider>();

    if (dashData == null) {
      return const Center(
        child: SnackBar(
          content: Text("Failed to sync dashboard data"),
          duration: Duration(seconds: 3),
        ),
      );
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: customAppBar(),
        drawer: const Drawer(
          child: CustomDrawer(),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await syncWorkflows();
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      '${dashData.orgUnit} - Dashboard',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Application data and usage summary',
                          style: TextStyle(color: kTextGrey),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                            child: const Text(
                              'Sync',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              syncWorkflows();
                            })
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (kDebugMode)
                      const InfoCard(
                        title: 'THIS IS A TEST APPLICATION',
                        icon: FontAwesomeIcons.warning,
                        color: Color(0xffff0010),
                        secondaryColor: Color(0xff630122),
                      ),
                    StatisticsItem(
                      title: 'UNSYNCED RECORDS',
                      icon: FontAwesomeIcons.arrowsRotate,
                      color: const Color(0xffa10036),
                      secondaryColor: const Color(0xff630122),
                      form1ACount: formStats.formOneACount,
                      form1BCount: formStats.formOneBCount,
                      cpaCount: formStats.cptCount,
                      cparaCount: formStats.cparaCount,
                      onClick: () {},
                    ),
                    // StatisticsItem(
                    //   title: 'UNAPPROVED RECORDS',
                    //   icon: FontAwesomeIcons.fileCircleXmark,
                    //   color: const Color(0xff947901),
                    //   secondaryColor: const Color(0xff524300),
                    //   form1ACount: 4,
                    //   form1BCount: 3,
                    //   cpaCount: 2,
                    //   cparaCount: 1,
                    //   onClick: () {
                    //     Get.to(() => const UnapprovedRecordsScreens());
                    //   },
                    // ),
                    CustomGridView(
                      crossAxisCount: 2,
                      childrenHeight: 180,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        // const StatisticsGridItem(
                        //   title: 'FORM 1A',
                        //   value: "10/20",
                        //   icon: FontAwesomeIcons.fileLines,
                        //   color: kPrimaryColor,
                        //   secondaryColor: Color(0xff0E6668),
                        // ),
                        // const StatisticsGridItem(
                        //   title: 'FORM 1B',
                        //   value: "10/20",
                        //   icon: FontAwesomeIcons.fileLines,
                        //   color: Color(0xff348FE2),
                        //   secondaryColor: Color(0xff1F5788),
                        // ),
                        // const StatisticsGridItem(
                        //   title: 'CPARA',
                        //   value: "10/20",
                        //   icon: FontAwesomeIcons.fileLines,
                        //   color: Color(0xff727DB6),
                        //   secondaryColor: Color(0xff454A6D),
                        // ),
                        // const StatisticsGridItem(
                        //   title: 'CPT',
                        //   value: "10/20",
                        //   icon: FontAwesomeIcons.fileLines,
                        //   color: Color(0xff49B6D5),
                        //   secondaryColor: Color(0xff2C6E80),
                        // ),
                        // const StatisticsGridItem(
                        //   title: 'CLHIV',
                        //   value: "10/20",
                        //   icon: FontAwesomeIcons.heart,
                        //   color: Color(0xff49B6D5),
                        //   secondaryColor: Color(0xff2C6E80),
                        // ),
                        StatisticsGridItem(
                          title: 'Org Unit Id',
                          value: dashData.orgUnitId.toString(),
                          icon: FontAwesomeIcons.orcid,
                          color: Colors.black54,
                          secondaryColor: Colors.black87,
                        ),
                        StatisticsGridItem(
                          title: 'ACTIVE OVC',
                          value: '${dashData.children}',
                          icon: FontAwesomeIcons.person,
                          color: kPrimaryColor,
                          secondaryColor: const Color(0xff0E6668),
                        ),
                        StatisticsGridItem(
                          title: 'CAREGIVERS/GUARDIANS',
                          value: dashData.caregivers.toString(),
                          icon: FontAwesomeIcons.peopleGroup,
                          color: const Color(0xff348FE2),
                          secondaryColor: const Color(0xff1F5788),
                        ),
                        StatisticsGridItem(
                          title: 'WORKFORCE MEMBERS',
                          value: dashData.workforceMembers.toString(),
                          icon: Icons.people,
                          color: const Color(0xff727DB6),
                          secondaryColor: const Color(0xff454A6D),
                        ),
                        StatisticsGridItem(
                          title: 'ORG UNITS/CBOs',
                          value: dashData.orgUnits.toString(),
                          icon: FontAwesomeIcons.landmark,
                          color: const Color(0xff49B6D5),
                          secondaryColor: const Color(0xff2C6E80),
                        ),
                        StatisticsGridItem(
                          title: 'HOUSEHOLDS',
                          value: dashData.household.toString(),
                          icon: FontAwesomeIcons.house,
                          color: const Color(0xffFE5C57),
                          secondaryColor: const Color(0xff9A3734),
                          onTap: () {
                            Get.to(
                              () => const CaregiverScreen(),
                              transition: Transition.cupertino,
                              duration: const Duration(
                                milliseconds: 200,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 90,
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 30,
                right: 30,
                left: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 140,
                      child: CustomButton(
                        onTap: () {
                          Get.to(
                            () => const OVCCareScreen(),
                            transition: Transition.cupertino,
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                          );
                        },
                        text: "OVC Care",
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void updateProgress(int formsSynced, int totalFormsToSync) {
    double progress = (formsSynced / totalFormsToSync) * 100;
    debugPrint("Progress is $progress");
    // Update the progress in the UI, for example, set a text widget with the progress.
    // You can use a Text widget or any other widget to display the progress.
    // progressTextWidget.text = 'Syncing Progress: ${progress.toStringAsFixed(2)}%';
  }

  void postFormOneToServer() async {
    var prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('access');
    setState(() {
      isSyncing = true;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Syncing forms...'),
          duration: Duration(seconds: 3), // Show indefinitely
        ),
      );
    }
    noFormsToSync = false;

    int totalFormsToSync = 0;
    int formsSynced = 0;

    for (var formType in formsList) {
      List<dynamic> forms = await Form1Service.getAllForms(
        formType['formType']!,
      );
      totalFormsToSync += forms.length;

      if (forms.isEmpty) {
        noFormsToSync = true;
      }
      for (var formData in forms) {
        var response = await Form1Service.postFormRemote(
          formData,
          formType['endpoint']!,
          accessToken!,
        );
        if (response.statusCode == 201) {
          debugPrint("Data to sync is $formData");
          await Form1Service.updateFormLocalDateSync(
            formType['formType']!,
            formData.id,
          );
          formsSynced++;
          if (formsSynced == totalFormsToSync) {
            Get.snackbar(
              'Success',
              'Successfully synced all ${formType['formType']} forms',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          }

          updateProgress(formsSynced, totalFormsToSync);
        } else if (response.statusCode == 403) {
          Get.dialog(
            AlertDialog(
              title: const Text("Session Expired"),
              content:
                  const Text("Your session has expired. Please log in again"),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        } else {
          debugPrint(
              "Failed to sync ${formType['formType']} and error is ${response.data}");
          Get.snackbar(
            'Error',
            'Failed to sync ${formType['formType']} and code is ${response.statusCode}',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    }

    setState(() {
      isSyncing = false;
    });

    if (noFormsToSync) {
      Get.snackbar(
        'Info',
        'No Form1A and Form1B forms to sync',
        backgroundColor: Colors.orange,
        colorText: Colors.black,
      );
    }
    if (mounted) {
      ScaffoldMessenger.of(context)
          .removeCurrentSnackBar(); // Remove the indefinite snackbar
    }
  }
}

import 'package:cpims_mobile/Models/form_1_model.dart';
import 'package:cpims_mobile/Models/statistic_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/connection_provider.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/caregiver/caregiver.dart';
import 'package:cpims_mobile/screens/homepage/widgets/statistics_item.dart';
import 'package:cpims_mobile/screens/homepage/widgets/statistics_grid_item.dart';
import 'package:cpims_mobile/screens/ovc_care/ovc_care_screen.dart';
import 'package:cpims_mobile/screens/unapproved_records/unapproved_records_screen.dart';
import 'package:cpims_mobile/services/form_service.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_grid_view.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../providers/db_provider.dart';
import '../cpara/provider/db_util.dart';
import '../unsynched_workflows/unsynched_workeflows_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, String>> formsList = [
    {'formType': 'form1a', 'endpoint': 'F1A/'},
    {'formType': 'form1b', 'endpoint': 'F1B/'},
  ];

  late int formOneACount = 0;
  late int formOneBCount = 0;
  late int cparaCount = 0;
  int updatedCountA = 0;
  int updatedCountB = 0;
  int updatedCountCpara = 0;

  @override
  void initState() {
    super.initState();
    countFormOneUnsynched();
    syncWorkflows();
  }

  bool isSyncing = false;

  bool noFormsToSync = true;

  Future<void> syncWorkflows() async {
    final isConnected =
        await Provider.of<ConnectivityProvider>(context, listen: false)
            .checkInternetConnection();
    if (isConnected) {
      submitCparaToUpstream();
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
      // Reset the noFormsToSync flag before checking each form type
      noFormsToSync = false;
      for (var formType in formsList) {
        List<dynamic> forms = await Form1Service.getAllForms(
          formType['formType']!,
        );
        debugPrint("The forms are $forms");

        if (forms.isEmpty) {
          noFormsToSync = true;
          debugPrint("No forms to sync");
        }

        for (var formData in forms) {
          var response = await Form1Service.postFormRemote(
            formData,
            formType['endpoint']!,
            accessToken!,
          );
          // handle the response here
          if (response.statusCode == 200) {
            // await Form1Service.deleteFormLocal(
            //   formType['formType']!,
            //   formData.id,
            // );
            await Form1Service.updateFormLocalDateSync(
              formType['formType']!,
              formData.id,
            );
            Get.snackbar(
              'Success',
              'Successfully synced forms',
              backgroundColor: Colors.green,
              colorText: Colors.white,
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
        // Show the "No forms to sync" snack bar only once
        Get.snackbar(
          'Info',
          'No forms to sync',
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

  Future<void> countFormOneUnsynched() async {
    updatedCountA = (await Form1Service.getCountAllFormOneA())!;
    updatedCountB = (await Form1Service.getCountAllFormOneB())!;
    updatedCountCpara = (await Form1Service.getCountAllFormCpara())!;
    setState(() {
      formOneACount = updatedCountA;
      formOneBCount = updatedCountB;
      cparaCount = updatedCountCpara;
    });
    print("Count is $formOneACount and count b is $formOneBCount  and count cpara is $cparaCount");
  }

  countUnsycedCpara() async {
    int count = 0;
    Database database = await LocalDb.instance.database;
    count = await getUnsyncedCparaFormsCount(database);
    if (count > 0) {
      print("The count is $count");
      return count;
    }
    print("The count is $count");
    return count;
  }

  void _showSyncSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Forms synchronized successfully.'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SummaryDataModel dashData =
        context.select((UIProvider provider) => provider.getDashData);

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
      body: Stack(
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
                 const Text(
                   'Application data and usage summary',
                   style: TextStyle(color: kTextGrey),
                 ),
                StatisticsItem(
                  title: 'UNSYNCED RECORDS',
                  icon: FontAwesomeIcons.arrowsRotate,
                  color: const Color(0xffa10036),
                  secondaryColor: const Color(0xff630122),
                  form1ACount: formOneACount,
                  form1BCount: formOneBCount,
                  cpaCount: cparaCount,
                  cparaCount: 0,
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
                    // StatisticsGridItem(
                    //   title: 'Org Unit Id',
                    //   value: dashData.orgUnitId.toString(),
                    //   icon: FontAwesomeIcons.orcid,
                    //   color: Colors.black54,
                    //   secondaryColor: Colors.black87,
                    // ),
                    StatisticsGridItem(
                      title: 'OVC-ACTIVE/EVER REGISTERED',
                      value: "${dashData.children.toString()} / ${dashData.childrenAll.toString()}",
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
    );
  }
}

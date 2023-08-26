import 'package:cpims_mobile/Models/statistic_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/homepage/widgets/statistics_item.dart';
import 'package:cpims_mobile/screens/homepage/widgets/statistics_grid_item.dart';
import 'package:cpims_mobile/screens/ovc_care/ovc_care_screen.dart';
import 'package:cpims_mobile/screens/unapproved_records/unapproved_records_screen.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import '../unsynched_workflows/unsynched_workeflows_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final SummaryDataModel dashData =
        context.select((UIProvider provider) => provider.getDashData);

    return Scaffold(
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
                  form1ACount: 4,
                  form1BCount: 3,
                  cpaCount: 2,
                  cparaCount: 1,
                  onClick: () {
                    Get.to(() => const UnsyncedWorkflowsPage());
                  },
                ),
                StatisticsItem(
                  title: 'UNAPPROVED RECORDS',
                  icon: FontAwesomeIcons.fileCircleXmark,
                  color: const Color(0xff947901),
                  secondaryColor: const Color(0xff524300),
                  form1ACount: 4,
                  form1BCount: 3,
                  cpaCount: 2,
                  cparaCount: 1,
                  onClick: () {
                     Get.to(() => const UnapprovedRecordsScreens());
                  },
                ),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const StatisticsGridItem(
                      title: 'FORM 1A',
                      value: "10/20",
                      icon: FontAwesomeIcons.fileLines,
                      color: kPrimaryColor,
                      secondaryColor: Color(0xff0E6668),
                    ),
                    const StatisticsGridItem(
                      title: 'FORM 1B',
                      value: "10/20",
                      icon: FontAwesomeIcons.fileLines,
                      color: Color(0xff348FE2),
                      secondaryColor: Color(0xff1F5788),
                    ),
                    const StatisticsGridItem(
                      title: 'CPARA',
                      value: "10/20",
                      icon: FontAwesomeIcons.fileLines,
                      color: Color(0xff727DB6),
                      secondaryColor: Color(0xff454A6D),
                    ),
                    const StatisticsGridItem(
                      title: 'CPT',
                      value: "10/20",
                      icon: FontAwesomeIcons.fileLines,
                      color: Color(0xff49B6D5),
                      secondaryColor: Color(0xff2C6E80),
                    ),
                    const StatisticsGridItem(
                      title: 'CLHIV',
                      value: "10/20",
                      icon: FontAwesomeIcons.heart,
                      color: Color(0xff49B6D5),
                      secondaryColor: Color(0xff2C6E80),
                    ),
                    StatisticsGridItem(
                      title: 'HOUSEHOLDS',
                      value: dashData.household.toString(),
                      icon: FontAwesomeIcons.house,
                      color: const Color(0xffFE5C57),
                      secondaryColor: const Color(0xff9A3734),
                    ),
                    StatisticsGridItem(
                      title: 'Org Unit Id',
                      value: dashData.orgUnitId.toString(),
                      icon: FontAwesomeIcons.orcid,
                      color: Colors.black54,
                      secondaryColor: Colors.black87,
                    ),
                    StatisticsGridItem(
                      title: 'OVC-ACTIVE/EVER REGISTERED',
                      value: dashData.caregivers.toString(),
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

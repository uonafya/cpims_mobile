import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/homepage/widgets/statistics_item.dart';
import 'package:cpims_mobile/screens/homepage/widgets/statistics_gridItem.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import '../forms/documents_manager.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: Stack(children: [
        Positioned.fill(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              const SizedBox(height: 20),
              const Text('4THE CHILD - Dashboard',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 5),
              const Text(
                'Application data and usage summary',
                style: TextStyle(color: kTextGrey),
              ),
              const StatisticsItem(
                title: 'UNSYNCED RECORDS',
                icon: FontAwesomeIcons.arrowsRotate,
                color: Color(0xffa10036),
                secondaryColor: Color(0xff630122),
                form1ACount: 4,
                form1BCount: 3,
                cpaCount: 2,
                cparaCount: 1,
              ),
              const StatisticsItem(
                title: 'UNAPPROVED RECORDS',
                icon: FontAwesomeIcons.fileCircleXmark,
                color: Color(0xff947901),
                secondaryColor: Color(0xff524300),
                form1ACount: 4,
                form1BCount: 3,
                cpaCount: 2,
                cparaCount: 1,
              ),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  StatisticsGridItem(
                    title: 'Org Unit Id',
                    value:
                        context.read<UIProvider>().getDashData['org_unit_id'] ??
                            0,
                    icon: FontAwesomeIcons.orcid,
                    color: Colors.black54,
                    secondaryColor: Colors.black87,
                  ),
                  StatisticsGridItem(
                    title: 'OVC-ACTIVE/EVER REGISTERED',
                    value:
                        context.read<UIProvider>().getDashData['caregivers'] ??
                            0,
                    icon: FontAwesomeIcons.person,
                    color: kPrimaryColor,
                    secondaryColor: const Color(0xff0E6668),
                  ),
                  StatisticsGridItem(
                    title: 'CAREGIVERS/GUARDIANS',
                    value:
                        context.read<UIProvider>().getDashData['caregivers'] ??
                            0,
                    icon: FontAwesomeIcons.peopleGroup,
                    color: const Color(0xff348FE2),
                    secondaryColor: const Color(0xff1F5788),
                  ),
                  StatisticsGridItem(
                    title: 'WORKFORCE MEMBERS',
                    value: context
                            .read<UIProvider>()
                            .getDashData['workforce_members'] ??
                        0,
                    icon: Icons.people,
                    color: const Color(0xff727DB6),
                    secondaryColor: const Color(0xff454A6D),
                  ),
                  StatisticsGridItem(
                    title: 'ORG UNITS/CBOs',
                    value:
                        context.read<UIProvider>().getDashData['org_units'] ??
                            0,
                    icon: FontAwesomeIcons.landmark,
                    color: const Color(0xff49B6D5),
                    secondaryColor: const Color(0xff2C6E80),
                  ),
                  StatisticsGridItem(
                    title: 'HOUSEHOLDS',
                    value:
                        context.read<UIProvider>().getDashData['hh_holds'] ?? 0,
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
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              SizedBox(
                width: 140,
                child: CustomButton(
                  onTap: () {
                    Get.to(() => const DocumentsManager(),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 200));
                  },
                  text: "OVC Care",
                  color: Colors.green,
                ),
              ),
            ]))
      ]),
    );
  }
}

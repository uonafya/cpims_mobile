import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/unsynched_workflows/widgets/child_details_grid_item.dart';
import 'package:cpims_mobile/screens/unsynched_workflows/widgets/child_details_workflow_button.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChildDetailsPage extends StatefulWidget {
  const ChildDetailsPage({Key? key}) : super(key: key);

  @override
  State<ChildDetailsPage> createState() => _ChildDetailsPageState();
}

class _ChildDetailsPageState extends State<ChildDetailsPage> {
  final fixedLengthList =
      List<int>.generate(3, (int index) => index * index, growable: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(),
        drawer: const Drawer(
          child: CustomDrawer(),
        ),
        body: Container(
          color: const Color(0xFFd9e0e7),
          child: Padding(
            padding: kSystemPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Wrap(
                  runSpacing: 5.0,
                  spacing: 5.0,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Column(
                      children: [
                        Icon(FontAwesomeIcons.child),
                        //this is needed because Wrap does not have WrapCrossAlignment.baseLine
                        SizedBox(height: 5),
                      ],
                    ),
                    Text(
                      "OVC Care",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "Caregiver Details",
                          style: TextStyle(color: Color(0xFf7c7f83)),
                        ),
                        //this is needed because Wrap does not have WrapCrossAlignment.baseLine
                        SizedBox(height: 3),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "|",
                          style: TextStyle(color: Color(0xFf7c7f83)),
                        ),
                        //this is needed because Wrap does not have WrapCrossAlignment.baseLine
                        SizedBox(height: 3),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "FIRSTNAME",
                          style: TextStyle(color: Color(0xFf7c7f83)),
                        ),
                        //this is needed because Wrap does not have WrapCrossAlignment.baseLine
                        SizedBox(height: 3),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "MIDDLENAME",
                          style: TextStyle(color: Color(0xFf7c7f83)),
                        ),
                        //this is needed because Wrap does not have WrapCrossAlignment.baseLine
                        SizedBox(height: 3),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "LASTNAME",
                          style: TextStyle(color: Color(0xFf7c7f83)),
                        ),
                        //this is needed because Wrap does not have WrapCrossAlignment.baseLine
                        SizedBox(height: 3),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Available Forms",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ChildDetailsWorkflowButton(
                  workflowName: "Form A",
                  onClick: () {},
                ),
                ChildDetailsWorkflowButton(
                  workflowName: "Form B",
                  onClick: () {},
                ),
                ChildDetailsWorkflowButton(
                  workflowName: "CPARA",
                  onClick: () {},
                ),
                ChildDetailsWorkflowButton(
                  workflowName: "Case Plan Template",
                  onClick: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomCard(title: "Child Firstname Lastname", children: [
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: (1/0.5),
                    children: const [
                      ChildDetailsGridItem(
                        header: "Info Header",
                        details: "Info Details",
                      ),
                      ChildDetailsGridItem(
                        header: "Info Header",
                        details: "Info Details Long Long Long Long Long Long",
                      ),
                      ChildDetailsGridItem(
                        header: "Info Header",
                        details: "Info Details Long Long Long",
                      ),
                    ],
                  )
                ]),
              ],
            ),
          ),
        ));
  }
}
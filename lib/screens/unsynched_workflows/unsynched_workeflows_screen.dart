import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class UnsyncedWorkflowsPage extends StatefulWidget {
  const UnsyncedWorkflowsPage({Key? key}) : super(key: key);

  @override
  State<UnsyncedWorkflowsPage> createState() => _UnsyncedWorkflowsPageState();
}

class _UnsyncedWorkflowsPageState extends State<UnsyncedWorkflowsPage> {
  final fixedLengthList =
      List<int>.generate(3, (int index) => index, growable: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: Stack(children: [
        Positioned.fill(
          child: Padding(
            padding: kSystemPadding,
            child: ListView(
              children: [
                const SizedBox(height: 10,),
                const Row(
                  children: [
                    Icon(FontAwesomeIcons.arrowsRotate, size: 16,),
                    SizedBox(width: 10,),
                    Text(
                      "Unsynced Workflows",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                CustomCard(title: "Unsynced", children: [
                  ...List<int>.generate(9, (int index) => index + 1,
                      growable: false)
                      .map((e) =>
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'CPARA',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'CPIMS ID: ',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    '1234',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Text(
                                'Child: ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              Text(
                                'Firstname Middlename Lastname',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                'Caregiver: ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              Text(
                                'Firstname Lastname',
                                style: TextStyle(fontSize: 12),
                              ),
                              Spacer(),
                              Text(
                                '10/10/2023',
                                style: TextStyle(fontSize: 12),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ))
                      .toList(),
                ]
                ),
                const Footer(),
                const SizedBox(
                  height: 90,
                ),
              ],
            ),
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
                  onTap: () {},
                  text: "Sync Workflows",
                  color: Colors.green,
                ),
              ),
            ]))
      ]),
    );
  }
}

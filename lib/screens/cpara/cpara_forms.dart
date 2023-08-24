import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/cpara/model/cpara_model.dart';
import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/model/health_model.dart';
import 'package:cpims_mobile/screens/cpara/model/safe_model.dart';
import 'package:cpims_mobile/screens/cpara/model/schooled_model.dart';
import 'package:cpims_mobile/screens/cpara/model/stable_model.dart';
import 'package:cpims_mobile/screens/cpara/provider/cpara_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_healthy_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_safe_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_schooled_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_stable_widget.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_stepper.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CparaFormsScreen extends StatefulWidget {
  const CparaFormsScreen({super.key});

  @override
  State<CparaFormsScreen> createState() => _CparaFormsScreenState();
}

class _CparaFormsScreenState extends State<CparaFormsScreen> {
  int selectedStep = 0;

  List<Widget> steps = [
    const CparaDetailsWidget(),
    const CparaHealthyWidget(),
    const CparaStableWidget(),
    const CparaSafeWidget(),
    const CparaSchooledWidget(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ]),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    color: Colors.black,
                    child: const Text(
                      'Case Plan Achievement Readiness Assessment || {Caregiver Name}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        CustomStepperWidget(
                          onTap: (index) {
                            setState(() {
                              selectedStep = index;
                            });
                          },
                          data: cparaStepperData,
                          selectedIndex: selectedStep,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        steps[selectedStep],
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: selectedStep <= 0 ? 'Cancel' : 'Previous',
                                onTap: () {
                                  if (selectedStep == 0) {
                                    Navigator.pop(context);
                                  }
                                  setState(() {
                                    if (selectedStep > 0) {
                                      selectedStep--;
                                    }
                                  });
                                },
                                color: kTextGrey,
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Expanded(
                              child: CustomButton(
                                text: selectedStep == steps.length - 1
                                    ? 'Submit'
                                    : 'Next',
                                onTap: () {
                                  if (selectedStep == steps.length - 1) {
                                    // display collected data
                                    DetailModel? detailModel = context
                                        .read<CparaProvider>()
                                        .detailModel;
                                    HealthModel? healthModel = context
                                        .read<CparaProvider>()
                                        .healthModel;
                                    StableModel? stableModel = context
                                        .read<CparaProvider>()
                                        .stableModel;
                                    SafeModel? safeModel =
                                        context.read<CparaProvider>().safeModel;
                                    SchooledModel? schooledModel = context
                                        .read<CparaProvider>()
                                        .schooledModel;
                                    CparaModel? cparaModel = context
                                        .read<CparaProvider>()
                                        .cparaModel;

                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              title:
                                                  const Text('Collected Data'),
                                              content: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text("Stable Model:"),
                                                  Row(
                                                    children: [
                                                      Text("Question: 1"),
                                                      Text(
                                                          "Answer: ${stableModel?.question1}"),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Question: 2"),
                                                      Text(
                                                          " || Answer: ${stableModel?.question2}"),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Question: 3"),
                                                      Text(
                                                          " || Answer: ${stableModel?.question3}"),
                                                    ],
                                                  ),

                                                  // Health Model
                                                  HealthModelCollected()
                                                ],
                                              ),
                                            ));
                                  }

                                  setState(() {
                                    if (selectedStep < steps.length - 1) {
                                      selectedStep++;
                                    }
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 20),
          const PastCPARAWidget(),
          const Footer(),
        ],
      ),
    );
  }
}

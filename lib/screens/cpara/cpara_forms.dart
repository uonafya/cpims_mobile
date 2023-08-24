import 'package:cpims_mobile/constants.dart';
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

class CparaFormsScreen extends StatefulWidget {
  const CparaFormsScreen({super.key});

  @override
  State<CparaFormsScreen> createState() =>
      _CparaFormsScreenState();
}

class _CparaFormsScreenState
    extends State<CparaFormsScreen> {
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
          const SizedBox(height: 20),
          const Text('CPARA',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          const Text(
            '',
            style: TextStyle(color: kTextGrey),
          ),
          const SizedBox(height: 30),
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

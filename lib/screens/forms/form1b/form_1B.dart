import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/forms/form1b/utils/form1bConstants.dart';
import 'package:cpims_mobile/screens/forms/form1b/widgets/critical_event_form1b.dart';
import 'package:cpims_mobile/screens/forms/form1b/widgets/healthy_form1b.dart';
import 'package:cpims_mobile/screens/forms/form1b/widgets/safe_form1b.dart';
import 'package:cpims_mobile/screens/forms/form1b/widgets/stable_form1b.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/about_organisation_registry.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/organisation_contact_registry.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/organisation_location_registry.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/organsation_type_registry.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_arrow_button.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_stepper.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';

class Form1BScreen extends StatefulWidget {
  const Form1BScreen({super.key});

  @override
  State<Form1BScreen> createState() =>
      _Form1BScreen();
}

class _Form1BScreen
    extends State<Form1BScreen> {
  int selectedStep = 0;

  List<Widget> steps = [
    const HealthyForm1b(),
    const SafeForm1b(),
    const StableForm1b(),
    const CriticalEventForm1b(),
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
          const Text('Form 1B',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          const Text(
            'Caregiver Status and Service Monitoring',
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
                      'Form 1B Details',
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
                          data: form1bsStepper,
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
          const Footer(),
        ],
      ),
    );
  }
}

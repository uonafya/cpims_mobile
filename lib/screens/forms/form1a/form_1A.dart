import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/form1a_provider.dart';
import 'package:cpims_mobile/screens/forms/form1a/widgets/critical_events_details.dart';
import 'package:cpims_mobile/screens/forms/form1a/widgets/services_details.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_stepper.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import 'form1A_history.dart';

class Form1AScreen extends StatefulWidget {
  final CaseLoadModel caseLoadModel;

  const Form1AScreen({super.key, required this.caseLoadModel});

  @override
  State<Form1AScreen> createState() => _Form1AScreenState();
}

class _Form1AScreenState extends State<Form1AScreen> {
  int selectedStep = 0;
  List<Widget> steps = [];

  @override
  void initState() {
    super.initState();
    steps = [
      ServicesDetails(caseLoadModel: widget.caseLoadModel),
      const CriticalEventsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Form1AProvider form1aProvider = Provider.of<Form1AProvider>(context);

    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(height: 20),
          const Text('Forms',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          const Text(
            'Service and Monitoring(Form 1A)',
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
                    child: Text(
                      ' FORM 1A DETAILS \n CPIMIS NAMES: ${widget.caseLoadModel.ovcSurname}  ${widget.caseLoadModel.ovcFirstName} \n CPIMIS ID: ${widget.caseLoadModel.cpimsId} \n CARE GIVER: ${widget.caseLoadModel.caregiverNames} \n ',
                      style: const TextStyle(color: Colors.white),
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
                            data: form1AStepper,
                            selectedIndex: selectedStep),
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
                                text: selectedStep <= 0 ? 'Cancel' : 'Back',
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
                                    ? 'Submit Form1A'
                                    : 'Next',
                                onTap: () {
                                  setState(() {
                                    if (selectedStep < steps.length - 1) {
                                      selectedStep++;
                                    } else {
                                      var cpimsId =
                                          widget.caseLoadModel.cpimsId;

                                      form1aProvider
                                          .submitCriticalServices(cpimsId);
                                      Get.snackbar(
                                        'Success',
                                        'Form1A data saved successfully.',
                                        duration: const Duration(seconds: 2),
                                        snackPosition: SnackPosition.TOP,
                                        // Display at the top of the screen
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white,
                                        margin: const EdgeInsets.all(16),
                                        borderRadius: 8,
                                      );
                                      Navigator.pop(context);
                                    }
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => HistoryForm1A(
                                caseLoadModel: widget.caseLoadModel));
                          },
                          child: const Row(
                            children: [
                              Text(
                                'Past Assessments',
                                style: TextStyle(color: Colors.blue),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
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

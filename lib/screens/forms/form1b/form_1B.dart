import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/forms/form1b/utils/form1bConstants.dart';
import 'package:cpims_mobile/screens/forms/form1b/widgets/critical_event_form1b.dart';
import 'package:cpims_mobile/screens/forms/form1b/widgets/healthy_form1b.dart';
import 'package:cpims_mobile/screens/forms/form1b/widgets/safe_form1b.dart';
import 'package:cpims_mobile/screens/forms/form1b/widgets/stable_form1b.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_stepper.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../providers/form1b_provider.dart';
import '../../../widgets/custom_toast.dart';
import '../../homepage/provider/stats_provider.dart';
import '../form1a/form1A_history.dart';

class Form1BScreen extends StatefulWidget {
  const Form1BScreen({super.key, required this.caseLoad});

  final CaseLoadModel caseLoad;

  @override
  State<Form1BScreen> createState() => _Form1BScreen();
}

class _Form1BScreen extends State<Form1BScreen> {
  int selectedStep = 0;

  List<Widget> steps = [
    const HealthyForm1b(),
    const SafeForm1b(),
    const StableForm1b(),
    const CriticalEventForm1b(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Form1bProvider form1bProvider =
          Provider.of<Form1bProvider>(context, listen: false);
      form1bProvider.setFinalFormDataOvcId(widget.caseLoad.cpimsId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Form1bProvider form1bProvider =
        Provider.of<Form1bProvider>(context, listen: false);

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
                    child: Text(
                      ' FORM 1B DETAILS \n CARE GIVER: ${widget.caseLoad.caregiverNames} \n CPIMS ID: ${widget.caseLoad.cpimsId}',
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
                                  } else {
                                    setState(() {
                                      if (selectedStep > 0) {
                                        selectedStep--;
                                      }
                                    });
                                  }
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
                                    ? 'Submit Form1B'
                                    : 'Next',
                                onTap: () async {
                                  if (selectedStep == steps.length - 1) {
                                    bool isFormSaved =
                                        await form1bProvider.saveForm1bData(
                                      form1bProvider.formData,
                                    );
                                    setState(() {
                                      if (isFormSaved == true) {
                                        if(context.mounted){
                                          context
                                              .read<StatsProvider>()
                                              .updateCparaFormStats();
                                        }
                                        CustomToastWidget.showToast(
                                            "Form saved successfully");
                                        Navigator.pop(context);
                                        selectedStep = 0;
                                      }
                                    });
                                  } else {
                                    setState(() {
                                      if (selectedStep < steps.length - 1) {
                                        selectedStep++;
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // Row(children: [
                        //   Expanded(
                        //     child: CustomButton(
                        //       text: "Submit",
                        //       onTap: () async {
                        //         bool isFormSaved = await form1bProvider
                        //             .saveForm1bData(form1bProvider.formData);
                        //         if (isFormSaved == true) {
                        //           CustomToastWidget.showToast(
                        //               "Form saved successfully");
                        //           setState(() {
                        //             selectedStep = 0;
                        //           });
                        //         }
                        //       },
                        //     ),
                        //   )
                        // ]),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // Row(children: [
                        //   Expanded(
                        //     child: CustomButton(
                        //         text: 'Cancel',
                        //         color: kTextGrey,
                        //         onTap: () {
                        //           // Navigator.of(context).pop();
                        //           form1bProvider.fetchSavedDataFromDb();
                        //         }),
                        //   )
                        // ]),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            // TODO Handle past assessments
                            // Get.to(() => HistoryForm1A(
                            //     caseLoadModel: widget.caseLoadModel));
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

class HistoryAssessmentListWidget extends StatelessWidget {
  const HistoryAssessmentListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return const AssessmentItemWidget();
        });
  }
}

class AssessmentItemWidget extends StatelessWidget {
  const AssessmentItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Text(
            'Child not Adhering to ARVs',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Expanded(
          child: Text(
            '28-Aug-2023',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 10),
        Icon(
          CupertinoIcons.delete,
          color: Colors.red,
        )
      ],
    );
  }
}

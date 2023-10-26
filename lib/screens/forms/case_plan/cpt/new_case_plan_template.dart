import 'package:cpims_mobile/screens/forms/case_plan/cpt/new_cpt_provider.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/screens/healthy_cpt.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/screens/safe_cpt.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/screens/schooled_cpt.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/screens/stable_cpt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Models/case_load_model.dart';
import '../../../../constants.dart';
import '../../../../widgets/app_bar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_stepper.dart';
import '../../../../widgets/drawer.dart';
import '../../../../widgets/footer.dart';
import '../../form1b/utils/form1bConstants.dart';
import 'models/healthy_cpt_model.dart';

class CasePlanTemplateForm extends StatefulWidget {
  final CaseLoadModel caseLoad;

  const CasePlanTemplateForm({super.key, required this.caseLoad});

  @override
  State<CasePlanTemplateForm> createState() => _Form1BScreen();
}

class _Form1BScreen extends State<CasePlanTemplateForm> {
  int selectedStep = 0;
  List<Widget> steps = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    steps = [
      HealthyCasePlan(caseLoadModel: widget.caseLoad),
      SafeCasePlan(caseLoadModel: widget.caseLoad),
      const SchooledCasePlanTemplate(),
      StableCasePlan(caseLoadModel: widget.caseLoad),
    ];
    // Future.delayed(Duration.zero, () {
    //   Form1bProvider form1bProvider =
    //   Provider.of<Form1bProvider>(context, listen: false);
    //   form1bProvider.setFinalFormDataOvcId(widget.caseLoad.cpimsId!);
    // });
  }

  @override
  Widget build(BuildContext context) {
    // Form1bProvider form1bProvider =
    // Provider.of<Form1bProvider>(context, listen: false);
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(height: 20),
          const Text('CASEPLAN TEMPLATE',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          // const Text(
          //   'Caregiver Status and Service Monitoring',
          //   style: TextStyle(color: kTextGrey),
          // ),
          const SizedBox(height: 10),
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
                      ' CASE PLAN TEMPLATE \n CARE GIVER: ${widget.caseLoad.caregiverNames} \n CPIMS NAME :${widget.caseLoad.ovcFirstName} ${widget.caseLoad.ovcSurname} \n CPIMS ID: ${widget.caseLoad.cpimsId}',
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
                                    ? 'Submit Caseplan'
                                    : 'Next',
                                onTap: () async {
                                  if (selectedStep == steps.length - 1) {
                                    // bool isFormSaved =
                                    // await form1bProvider.saveForm1bData(
                                    //   form1bProvider.formData,
                                    // );
                                    try {
                                      String? ovsId = context
                                          .read<CptProvider>()
                                          .caseLoadModel
                                          ?.cpimsId;
                                    } catch (e) {
                                      debugPrint(e.toString());
                                    }
                                    setState(() {
                                      // if (isFormSaved == true) {
                                      //   CustomToastWidget.showToast(
                                      //       "Form saved successfully");
                                      //   Navigator.pop(context);
                                      //   selectedStep = 0;
                                      // }
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

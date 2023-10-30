import 'dart:convert';

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
import '../../../../widgets/custom_forms_date_picker.dart';
import '../../../../widgets/custom_stepper.dart';
import '../../../../widgets/drawer.dart';
import '../../../../widgets/footer.dart';
import '../../form1b/utils/form1bConstants.dart';
import 'models/healthy_cpt_model.dart';
import 'models/safe_cpt_model.dart';
import 'models/schooled_cpt_model.dart';
import 'models/stable_cpt_model.dart';

class CasePlanTemplateForm extends StatefulWidget {
  final CaseLoadModel caseLoad;

  const CasePlanTemplateForm({super.key, required this.caseLoad});

  @override
  State<CasePlanTemplateForm> createState() => _Form1BScreen();
}

class _Form1BScreen extends State<CasePlanTemplateForm> {
  DateTime currentDateOfCasePlan = DateTime.now();
  int selectedStep = 0;
  List<Widget> steps = [];

  @override
  void initState() {
    super.initState();
    steps = [
      HealthyCasePlan(caseLoadModel: widget.caseLoad),
      SafeCasePlan(caseLoadModel: widget.caseLoad),
      SchooledCasePlanTemplate(caseLoadModel: widget.caseLoad),
      StableCasePlan(caseLoadModel: widget.caseLoad),
    ];

    currentDateOfCasePlan = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    CptProvider cptProvider = Provider.of<CptProvider>(context, listen: false);
    bool isLastStep = selectedStep == steps.length - 1;
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
                    width: MediaQuery.of(context).size.width,
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
                          data: caseplanStepperTitles,
                          selectedIndex: selectedStep,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        steps[selectedStep],
                        const SizedBox(
                          height: 30,
                        ),
                        Visibility(
                          visible: isLastStep,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Date of Event',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                CustomFormsDatePicker(
                                    hintText: 'Select Date of CasePlan',
                                    selectedDateTime: currentDateOfCasePlan,
                                    onDateSelected: (DateTime date) {
                                      setState(() {
                                        currentDateOfCasePlan = date;
                                      });
                                    }),
                                const SizedBox(
                                  height: 15,
                                ),
                              ]),
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
                                    try {
                                      String? ovsId = context
                                          .read<CptProvider>()
                                          .caseLoadModel
                                          ?.cpimsId;

                                      bool allDatesFilled =
                                          checkDatesAreFilled();
                                      CptHealthFormData? cptHealthFormData =
                                          context
                                                  .read<CptProvider>()
                                                  .cptHealthFormData ??
                                              CptHealthFormData();
                                      CptSafeFormData? cptSafeFormData = context
                                              .read<CptProvider>()
                                              .cptSafeFormData ??
                                          CptSafeFormData();
                                      CptStableFormData? cptStableFormData =
                                          context
                                                  .read<CptProvider>()
                                                  .cptStableFormData ??
                                              CptStableFormData();
                                      CptschooledFormData? cptschooledFormData =
                                          context
                                                  .read<CptProvider>()
                                                  .cptschooledFormData ??
                                              CptschooledFormData();

                                      print("Data colleced from each form");
                                      print("Health $cptHealthFormData");
                                      print("Safe $cptSafeFormData");
                                      print("Stable $cptStableFormData");
                                      print("Schooled $cptschooledFormData");

                                      List<Map<String, dynamic>> servicesList =
                                          [];
                                      if (cptHealthFormData != null) {
                                        Map<String, dynamic> healthService = {
                                          'domainId':
                                              cptHealthFormData.domainId,
                                          'serviceIds':
                                              cptHealthFormData.serviceIds,
                                          'goalId': cptHealthFormData.goalId,
                                          'gapId': cptHealthFormData.gapId,
                                          'priorityId':
                                              cptHealthFormData.priorityId,
                                          'responsibleIds':
                                              cptHealthFormData.responsibleIds,
                                          'resultsId':
                                              cptHealthFormData.resultsId,
                                          'reasonId':
                                              cptHealthFormData.reasonId,
                                          'completionDate':
                                              cptHealthFormData.completionDate,
                                        };
                                        servicesList.add(healthService);
                                      }

                                      if (cptSafeFormData != null) {
                                        Map<String, dynamic> safeService = {
                                          'domainId': cptSafeFormData.domainId,
                                          'serviceIds':
                                              cptSafeFormData.serviceIds,
                                          'goalId': cptSafeFormData.goalId,
                                          'gapId': cptSafeFormData.gapId,
                                          'priorityId':
                                              cptSafeFormData.priorityId,
                                          'responsibleIds':
                                              cptSafeFormData.responsibleIds,
                                          'resultsId':
                                              cptSafeFormData.resultsId,
                                          'reasonId': cptSafeFormData.reasonId,
                                          'completionDate':
                                              cptSafeFormData.completionDate,
                                        };
                                        servicesList.add(safeService);
                                      }

                                      if (cptStableFormData != null) {
                                        Map<String, dynamic> stableService = {
                                          'domainId':
                                              cptStableFormData.domainId,
                                          'serviceIds':
                                              cptStableFormData.serviceIds,
                                          'goalId': cptStableFormData.goalId,
                                          'gapId': cptStableFormData.gapId,
                                          'priorityId':
                                              cptStableFormData.priorityId,
                                          'responsibleIds':
                                              cptStableFormData.responsibleIds,
                                          'resultsId':
                                              cptStableFormData.resultsId,
                                          'reasonId':
                                              cptStableFormData.reasonId,
                                          'completionDate':
                                              cptStableFormData.completionDate,
                                        };
                                        servicesList.add(stableService);
                                      }

                                      if (cptschooledFormData != null) {
                                        Map<String, dynamic> schooledService = {
                                          'domainId':
                                              cptschooledFormData.domainId,
                                          'serviceIds':
                                              cptschooledFormData.serviceIds,
                                          'goalId': cptschooledFormData.goalId,
                                          'gapId': cptschooledFormData.gapId,
                                          'priorityId':
                                              cptschooledFormData.priorityId,
                                          'responsibleIds': cptschooledFormData
                                              .responsibleIds,
                                          'resultsId':
                                              cptschooledFormData.resultsId,
                                          'reasonId':
                                              cptschooledFormData.reasonId,
                                          'completionDate': cptschooledFormData
                                              .completionDate,
                                        };
                                        servicesList.add(schooledService);
                                      }

                                      Map<String, dynamic> payload = {
                                        'ovc_cpims_id': ovsId,
                                        'date_of_event': DateTime.now()
                                            .toIso8601String()
                                            .split('T')[0],
                                        'services': servicesList,
                                      };

                                      print(
                                          "Final payload is${jsonEncode(payload)}");
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

  bool checkDatesAreFilled() {
    // Check the date fields in your models
    CptHealthFormData cptHealthFormData =
        context.read<CptProvider>().cptHealthFormData ?? CptHealthFormData();
    CptSafeFormData cptSafeFormData =
        context.read<CptProvider>().cptSafeFormData ?? CptSafeFormData();
    CptStableFormData cptStableFormData =
        context.read<CptProvider>().cptStableFormData ?? CptStableFormData();
    CasePlanschooledModel casePlanStableModel =
        context.read<CptProvider>().casePlanStableModel ??
            CasePlanschooledModel();

    if (cptHealthFormData.dateOfEvent == null ||
        cptSafeFormData.dateOfEvent == null ||
        cptStableFormData.dateOfEvent == null ||
        casePlanStableModel.dateOfEvent == null) {
      return false; // Return false if any date field is empty
    }

    return true; // Return true if all date fields are filled
  }
}

CheckResult checkFieldsAreFilled(CptHealthFormData data) {
  List<String> unfilledFields = [];

  if (data.dateOfEvent == null) {
    unfilledFields.add('Date of Event');
  }
  if (data.domainId == null) {
    unfilledFields.add('Domain');
  }
  if (data.serviceIds == null || data.serviceIds!.isEmpty) {
    unfilledFields.add('Services');
  }
  if (data.goalId == null) {
    unfilledFields.add('Goal');
  }
  if (data.gapId == null) {
    unfilledFields.add('Needs/Gaps');
  }
  if (data.priorityId == null) {
    unfilledFields.add('Priority Actions');
  }
  if (data.responsibleIds == null || data.responsibleIds!.isEmpty) {
    unfilledFields.add('Person(s) Responsible');
  }
  if (data.resultsId == null) {
    unfilledFields.add('Results');
  }
  if (data.reasonId == null) {
    unfilledFields.add('Reason(s)');
  }
  if (data.completionDate == null) {
    unfilledFields.add('Completion Date');
  }

  if (unfilledFields.isEmpty) {
    return CheckResult(isAllFieldsFilled: true, unfilledFields: []);
  } else {
    return CheckResult(
        isAllFieldsFilled: false, unfilledFields: unfilledFields);
  }
}

class CheckResult {
  bool isAllFieldsFilled;
  List<String> unfilledFields;

  CheckResult({
    required this.isAllFieldsFilled,
    required this.unfilledFields,
  });
}

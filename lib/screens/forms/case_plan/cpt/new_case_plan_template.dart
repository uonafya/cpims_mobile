import 'dart:convert';

import 'package:cpims_mobile/screens/forms/case_plan/cpt/new_cpt_provider.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/screens/healthy_cpt.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/screens/safe_cpt.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/screens/schooled_cpt.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/screens/stable_cpt.dart';
import 'package:cpims_mobile/services/form_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Models/case_load_model.dart';
import '../../../../Models/caseplan_form_model.dart';
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

  // Future<bool> saveCasePlanLocal(String jsonPayload) async {
  //   try {
  //     // Parse the JSON string into a Map
  //     Map<String, dynamic> payload = json.decode(jsonPayload);
  //
  //     // Create a new CasePlanModel object from the Map
  //     CasePlanModel casePlanModel = CasePlanModel.fromJson(payload);
  //
  //     // Save the CasePlanModel object to the local database
  //     await CasePlanService.saveCasePlanLocal(casePlanModel);
  //
  //     return true; // Return true if the data was successfully saved.
  //   } catch (e) {
  //     print("Error saving case plan locally: $e");
  //     return false; // Return false if there was an error.
  //   }
  // }

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
                                      String? ovsId = widget.caseLoad.cpimsId!;
                                      String formattedDate =
                                          currentDateOfCasePlan
                                              .toIso8601String();

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
                                      if (cptHealthFormData != null &&
                                          cptHealthFormData.serviceIds !=
                                              null &&
                                          cptHealthFormData.goalId != null &&
                                          cptHealthFormData.gapId != null &&
                                          cptHealthFormData.priorityId !=
                                              null &&
                                          cptHealthFormData.responsibleIds !=
                                              null &&
                                          cptHealthFormData.resultsId != null &&
                                          cptHealthFormData.reasonId != null) {
                                        Map<String, dynamic> healthService = {
                                          'domain_id': "DHNU",
                                          'service_id':
                                              cptHealthFormData.serviceIds,
                                          'goal_id': cptHealthFormData.goalId,
                                          'gap_id': cptHealthFormData.gapId,
                                          'priority_id':
                                              cptHealthFormData.priorityId,
                                          'responsible_id':
                                              cptHealthFormData.responsibleIds,
                                          'results_id':
                                              cptHealthFormData.resultsId,
                                          'reason_id':
                                              cptHealthFormData.reasonId,
                                          'completion_date':
                                              cptHealthFormData.completionDate,
                                        };
                                        servicesList.add(healthService);
                                      }

                                      if (cptSafeFormData != null &&
                                          cptSafeFormData.serviceIds != null &&
                                          cptSafeFormData.goalId != null &&
                                          cptSafeFormData.gapId != null &&
                                          cptSafeFormData.priorityId != null &&
                                          cptSafeFormData.responsibleIds !=
                                              null &&
                                          cptSafeFormData.resultsId != null &&
                                          cptSafeFormData.reasonId != null) {
                                        Map<String, dynamic> safeService = {
                                          'domain_id': 'DPRO',
                                          'service_id':
                                              cptSafeFormData.serviceIds,
                                          'goal_id': cptSafeFormData.goalId,
                                          'gap_id': cptSafeFormData.gapId,
                                          'priority_id':
                                              cptSafeFormData.priorityId,
                                          'responsible_id':
                                              cptSafeFormData.responsibleIds,
                                          'results_id':
                                              cptSafeFormData.resultsId,
                                          'reason_id': cptSafeFormData.reasonId,
                                          'completion_date':
                                              cptSafeFormData.completionDate,
                                        };
                                        servicesList.add(safeService);
                                      }

                                      if (cptStableFormData != null &&
                                          cptStableFormData.serviceIds !=
                                              null &&
                                          cptStableFormData.goalId != null &&
                                          cptStableFormData.gapId != null &&
                                          cptStableFormData.priorityId !=
                                              null &&
                                          cptStableFormData.responsibleIds !=
                                              null &&
                                          cptStableFormData.resultsId != null &&
                                          cptStableFormData.reasonId != null) {
                                        Map<String, dynamic> stableService = {
                                          'domain_id': 'DPRO',
                                          'service_id':
                                              cptStableFormData.serviceIds,
                                          'goal_id': cptStableFormData.goalId,
                                          'gap_id': cptStableFormData.gapId,
                                          'priority_id':
                                              cptStableFormData.priorityId,
                                          'responsible_id':
                                              cptStableFormData.responsibleIds,
                                          'results_id':
                                              cptStableFormData.resultsId,
                                          'reason_id':
                                              cptStableFormData.reasonId,
                                          'completion_date':
                                              cptStableFormData.completionDate,
                                        };
                                        servicesList.add(stableService);
                                      }

                                      if (cptschooledFormData != null &&
                                          cptschooledFormData.serviceIds !=
                                              null &&
                                          cptschooledFormData.goalId != null &&
                                          cptschooledFormData.gapId != null &&
                                          cptschooledFormData.priorityId !=
                                              null &&
                                          cptschooledFormData.responsibleIds !=
                                              null &&
                                          cptschooledFormData.resultsId !=
                                              null &&
                                          cptschooledFormData.reasonId !=
                                              null) {
                                        Map<String, dynamic> schooledService = {
                                          'domain_id': 'DEDU',
                                          'service_id':
                                              cptschooledFormData.serviceIds,
                                          'goal_id': cptschooledFormData.goalId,
                                          'gap_id': cptschooledFormData.gapId,
                                          'priority_id':
                                              cptschooledFormData.priorityId,
                                          'responsible_id': cptschooledFormData
                                              .responsibleIds,
                                          'results_id':
                                              cptschooledFormData.resultsId,
                                          'reason_id':
                                              cptschooledFormData.reasonId,
                                          'completion_date': cptschooledFormData
                                              .completionDate,
                                        };
                                        servicesList.add(schooledService);
                                      }

                                      Map<String, dynamic> payload = {
                                        'ovc_cpims_id': ovsId,
                                        'date_of_event': formattedDate,
                                        'services': servicesList,
                                      };
                                      print(
                                          "Final payload is${jsonEncode(payload)}");
                                      print(
                                          "Final payload is not json $payload");
                                      bool isFormSaved = await CasePlanService
                                          .saveCasePlanLocal(
                                              CasePlanModel.fromJson(payload));

                                      if (isFormSaved) {
                                        Get.snackbar(
                                          'Success',
                                          'Successfully saved CasePlan form',
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white,
                                        );
                                        //get back to the previous screen
                                        Navigator.pop(context);
                                      } else {
                                        Get.snackbar(
                                          'Error',
                                          'Failed to save CasePlan form',
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
                                        Navigator.pop(context);
                                      }
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

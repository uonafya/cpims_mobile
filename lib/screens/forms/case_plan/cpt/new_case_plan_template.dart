import 'dart:convert';

import 'package:cpims_mobile/providers/app_meta_data_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/add_cpt_button.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/new_cpt_provider.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/screens/healthy_cpt.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/screens/safe_cpt.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/screens/schooled_cpt.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/screens/stable_cpt.dart';
import 'package:cpims_mobile/screens/forms/case_plan/domain_item.dart';
import 'package:cpims_mobile/services/form_service.dart';
import 'package:cpims_mobile/services/unapproved_data_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../Models/case_load_model.dart';
import '../../../../Models/caseplan_form_model.dart';
import '../../../../constants.dart';
import '../../../../widgets/app_bar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_forms_date_picker.dart';
import '../../../../widgets/custom_stepper.dart';
import '../../../../widgets/drawer.dart';
import '../../../../widgets/footer.dart';
import '../../../homepage/provider/stats_provider.dart';
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
  String currentDateOfCasePlan = "";
  int selectedStep = 0;
  List<Widget> steps = [];
  int clearFieldIndex = -1;
  bool isLoading = false;
  bool formSubmitted = false;

  @override
  void initState() {
    super.initState();
    steps = [
      HealthyCasePlan(
        caseLoadModel: widget.caseLoad,
      ),
      SafeCasePlan(
        caseLoadModel: widget.caseLoad,
      ),
      SchooledCasePlanTemplate(caseLoadModel: widget.caseLoad),
      StableCasePlan(caseLoadModel: widget.caseLoad),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool isLastStep = selectedStep == steps.length - 1;

    return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          CptProvider cptProvider =
              Provider.of<CptProvider>(context, listen: false);
          cptProvider.clearProviderData();
          if (didPop) {
            return;
          }
        },
        child: Scaffold(
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
                                    DateTextField(
                                        label: currentDateOfCasePlan.isNotEmpty
                                            ? currentDateOfCasePlan
                                            : 'Select Date of CasePlan',
                                        enabled: true,
                                        identifier: DateTextFieldIdentifier
                                            .dateOfAssessment,
                                        onDateSelected: (val) {
                                          setState(() {
                                            currentDateOfCasePlan =
                                                DateFormat("yyyy-MM-dd")
                                                    .format(val!);
                                          });
                                        }),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ]),
                            ),
                            AddCPTButton(
                              formattedDate: currentDateOfCasePlan,
                              onTap: () {
                                if (selectedStep != steps.length - 1) {
                                  setState(() {
                                    selectedStep++;
                                  });
                                  Future.delayed(
                                      const Duration(milliseconds: 50), () {
                                    setState(() {
                                      selectedStep--;
                                    });
                                  });
                                } else if (selectedStep == steps.length - 1) {
                                  setState(() {
                                    selectedStep = 0;
                                  });

                                  Future.delayed(
                                      const Duration(milliseconds: 50), () {
                                    setState(() {
                                      selectedStep = steps.length - 1;
                                    });
                                  });
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    text: selectedStep <= 0
                                        ? 'Cancel'
                                        : 'Previous',
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
                                    isLoading: isLoading,
                                    text: selectedStep == steps.length - 1
                                        ? 'Submit Caseplan'
                                        : 'Next',
                                    onTap: () async {
                                      await submitData(context);
                                    },
                                    color: kTextGrey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Provider.of<CptProvider>(context,
                                              listen: false)
                                          .clearProviderData();
                                      context
                                          .read<CptProvider>()
                                          .updateClearServicesList();
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Clear Form",
                                      style: TextStyle(color: Colors.red),
                                    )),
                              ],
                            ),
                            ...List.generate(
                                getDomainItems(context, formSubmitted).length,
                                (index) => getDomainItems(
                                    context, formSubmitted)[index]),
                            const SizedBox(height: 20),
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: const Row(
                            //     children: [
                            //       Text(
                            //         'Past Assessments',
                            //         style: TextStyle(color: Colors.blue),
                            //       ),
                            //       SizedBox(
                            //         width: 10,
                            //       ),
                            //       Icon(
                            //         Icons.arrow_forward_ios_rounded,
                            //         size: 15,
                            //       )
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  )),
              const Footer(),
            ],
          ),
        ));
  }

  Future<void> submitData(BuildContext context) async {
    CptProvider cptProvider = Provider.of<CptProvider>(context, listen: false);
    if (selectedStep == steps.length - 1) {
      try {
        setState(() {
          isLoading = true;
        });
        String? ovsId = widget.caseLoad.cpimsId!;
        String? caregiverCpimsId = widget.caseLoad.caregiverCpimsId!;
        String formattedDate = currentDateOfCasePlan;
        if (formattedDate.isEmpty) {
          Get.snackbar(
            'Error',
            'Please select date of caseplan',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          setState(() {
            isLoading = false;
            formSubmitted = true;
          });
          return;
        }

        if (cptProvider.servicesList.isNotEmpty) {
          Map<String, dynamic> payload = {
            'ovc_cpims_id': ovsId,
            'date_of_event': formattedDate,
            'caregiver_cpims_id': caregiverCpimsId,
            'services': cptProvider.servicesList,
          };
          if (kDebugMode) {
            print("Final payload is${jsonEncode(payload)}");
          }

          String formUuid =  const Uuid().v4();
          // cptProvider.updateFormUuid(formUuid);
          AppMetaDataProvider appMetaDataProvider =
              Provider.of<AppMetaDataProvider>(context, listen: false);
          String startTimeOfInterview =
              appMetaDataProvider.startTimeInterview ??
                  DateTime.now().toString();
          bool isFormSaved = await CasePlanService.saveCasePlanLocal(
            CasePlanModel.fromJson(payload),
            formUuid,
            startTimeOfInterview,
          );

          if (isFormSaved) {
            if (context.mounted) {
              Provider.of<CptProvider>(context, listen: false)
                  .clearProviderData();
              context.read<CptProvider>().updateClearServicesList();
              context.read<StatsProvider>().updateCptStats();
              context.read<StatsProvider>().updateUnapprovedFormStats();
              context.read<StatsProvider>().updateUnapprovedCasePlanDistinctStats();
              //delete the edited form from unapproved cpt table
              bool editedFormDeleted =
                  await UnapprovedDataService.deleteUnapprovedCptAfterEdit(
                      formUuid);
              if (editedFormDeleted) {
                context.read<StatsProvider>().updateCptStats();
                Provider.of<StatsProvider>(context, listen: false)
                    .updateUnapprovedFormStats();
                Navigator.pop(context);
                Get.snackbar(
                  'Success',
                  'Successfully edited CasePlan form',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              }

              Get.snackbar(
                'Success',
                'Successfully saved CasePlan form',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            }
            if (context.mounted) {
              Navigator.pop(context);
            }
            setState(() {
              // Reset the list when the form is submitted
              formSubmitted = true;
            });

            // setState(() {});
          } else {
            Get.snackbar(
              'Error',
              'Failed to save CasePlan form',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            if (context.mounted) {
              Navigator.pop(context);
            }
            //clear provider data
            cptProvider.clearProviderData();
          }
        } else {
          setState(() {
            isLoading = false;
          });
          Get.snackbar(
            'Error',
            'Please fill all mandatory fields.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
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
  }
}

List<DomainItem> getDomainItems(BuildContext context, bool isSubmitted) {
  final cptProvider = Provider.of<CptProvider>(context);
  if (isSubmitted) {
    cptProvider.clearProviderData();
    return [];
  }
  List<CPTDomainModel> domainList = [];
  final cptHealthFormDataList = cptProvider.cptHealthFormDataList;
  final cptSafeFormDataList = cptProvider.cptSafeFormDataList;
  final cptStableFormDataList = cptProvider.cptStableFormDataList;
  final cptschooledFormDataList = cptProvider.cptschooledFormDataList;

  for (CptHealthFormData cptHealthForm in cptHealthFormDataList) {
    domainList.add(CPTDomainModel(
        domain: "Healthy",
        serviceIds: cptHealthForm.serviceIds,
        goalId: cptHealthForm.goalId,
        gapId: cptHealthForm.gapId,
        priorityId: cptHealthForm.priorityId,
        responsibleIds: cptHealthForm.responsibleIds,
        resultsId: cptHealthForm.resultsId,
        reasonId: cptHealthForm.reasonId));
  }
  for (CptSafeFormData cptSafeForm in cptSafeFormDataList) {
    domainList.add(CPTDomainModel(
        domain: "Safe",
        serviceIds: cptSafeForm.serviceIds,
        goalId: cptSafeForm.goalId,
        gapId: cptSafeForm.gapId,
        priorityId: cptSafeForm.priorityId,
        responsibleIds: cptSafeForm.responsibleIds,
        resultsId: cptSafeForm.resultsId,
        reasonId: cptSafeForm.reasonId));
  }
  for (CptStableFormData cptStableForm in cptStableFormDataList) {
    domainList.add(CPTDomainModel(
        domain: "Stable",
        serviceIds: cptStableForm.serviceIds,
        goalId: cptStableForm.goalId,
        gapId: cptStableForm.gapId,
        priorityId: cptStableForm.priorityId,
        responsibleIds: cptStableForm.responsibleIds,
        resultsId: cptStableForm.resultsId,
        reasonId: cptStableForm.reasonId));
  }

  for (CptschooledFormData cptschooledForm in cptschooledFormDataList) {
    domainList.add(CPTDomainModel(
        domain: "Schooled",
        serviceIds: cptschooledForm.serviceIds,
        goalId: cptschooledForm.goalId,
        gapId: cptschooledForm.gapId,
        priorityId: cptschooledForm.priorityId,
        responsibleIds: cptschooledForm.responsibleIds,
        resultsId: cptschooledForm.resultsId,
        reasonId: cptschooledForm.reasonId));
  }

  return List.generate(
      domainList.length,
      (index) => DomainItem(
            domain: domainList[index],
          ));
}

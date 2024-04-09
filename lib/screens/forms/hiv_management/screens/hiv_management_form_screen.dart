import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/constants_prod.dart';
import 'package:cpims_mobile/providers/app_meta_data_provider.dart';
import 'package:cpims_mobile/providers/hiv_management_form_provider.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/utils/hiv_management_form_constants.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/utils/hiv_management_form_status_provider.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/widgets/art_therapy_info_widget.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/widgets/hiv_visitation_widget.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_stepper.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../../widgets/location_dialog.dart';
import '../../../homepage/provider/stats_provider.dart';

class HIVManagementForm extends StatefulWidget {
  final CaseLoadModel caseLoad;

  const HIVManagementForm({
    super.key,
    required this.caseLoad,
  });

  @override
  State<HIVManagementForm> createState() => _HIVManagementFormState();
}

class _HIVManagementFormState extends State<HIVManagementForm> {
  int selectedStep = 0;
  List<Widget> steps = [];
  bool isStep1Completed = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    steps = [
      const ARTTherapyInfoWidget(),
      const HIVVisitationWidget(),
    ];
  }

  // submit hivmanagementform
  Future<void> submitHIVManagementForm(String startInterviewTime) async {
    try {
      String formUUid = const Uuid().v4();
      await Provider.of<HIVManagementFormProvider>(context, listen: false)
          .submitHIVManagementForm(
          widget.caseLoad.cpimsId,
          widget.caseLoad.caregiverCpimsId,
          formUUid,
          startInterviewTime,
          "HIV Management Form",
      );

      if (context.mounted) {
        context.read<StatsProvider>().updateHmfStats();

        Get.snackbar(
          'Success',
          'HIV Management Form submitted successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formCompletionStatus = context.watch<FormCompletionStatusProvider>();

    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        children: [
          const Text(
            'HIV Management Form',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                  child: Text(
                    ' CPIMS NAME :${widget.caseLoad.ovcFirstName} ${widget.caseLoad.ovcSurname} \n CPIMS ID: ${widget.caseLoad.cpimsId} \n HIV Status: ${widget.caseLoad.ovchivstatus}',
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
                        data: hivManagementFormTitles,
                        selectedIndex: selectedStep,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      steps[selectedStep],
                      const SizedBox(
                        height: 15,
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
                            width: 20,
                          ),
                          Expanded(
                            child: CustomButton(
                              text: selectedStep == steps.length - 1
                                  ? 'Submit Form'
                                  : 'Next',
                              onTap: () async {
                                try {
                                  if (selectedStep == steps.length - 1) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    // logic for verifying form and submitting
                                    if (
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.visitDate.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.durationOnARTs.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.height.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.mUAC.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.arvDrugsAdherence.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.arvDrugsDuration.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.adherenceCounseling.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.treatmentSupporter.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.treatmentSupporterSex.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.treatmentSupporterAge.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.treatmentSupporterHIVStatus.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.viralLoadResults.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.labInvestigationsDate.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.detectableViralLoadInterventions.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.disclosure.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.mUACScore.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.zScore.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.nutritionalSupport.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.supportGroupStatus.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.nhifEnrollment.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.nhifEnrollmentStatus.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.referralServices.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.nextAppointmentDate.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.peerEducatorName.isNotEmpty &&
                                        context.read<HIVManagementFormProvider>().hivManagementFormModel.peerEducatorContact.isNotEmpty
                                    ) {
                                      AppMetaDataProvider appMetaDataProvider =
                                          Provider.of<AppMetaDataProvider>(
                                        context,
                                        listen: false,
                                      );
                                      String startInterviewTime = appMetaDataProvider.startTimeInterview ?? DateTime.now().toIso8601String();
                                      await submitHIVManagementForm(startInterviewTime);

                                      // Set isLoading to false when form submission is complete
                                      setState(() {
                                        isLoading = false;
                                      });

                                     if(context.mounted){
                                       HIVManagementFormProvider
                                       hivManagementFormProvider = Provider
                                           .of<HIVManagementFormProvider>(
                                         context,
                                         listen: false,
                                       );
                                       hivManagementFormProvider.clearForms();
                                       context.read<StatsProvider>().updateFormStats();
                                       context.read<StatsProvider>().updateHmfStats();
                                       context.read<StatsProvider>().updateHmfDistinctStats();
                                       Navigator.pop(context);
                                     }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Please fill in the required fields in visitation Section"),
                                          backgroundColor: Colors.red,
                                        ),
                                      );

                                      // Set isLoading to false when form submission fails
                                      setState(() {
                                        isLoading = false;
                                      });
                                      return;
                                    }
                                  } else {
                                    setState(
                                      () {
                                        if (selectedStep < steps.length - 1) {
                                          print("Selected step: ${context.read<HIVManagementFormProvider>().hivManagementFormModel.dateHIVConfirmedPositive }");
                                          if(context.read<HIVManagementFormProvider>().hivManagementFormModel.dateHIVConfirmedPositive.isNotEmpty &&
                                              context.read<HIVManagementFormProvider>().hivManagementFormModel.dateTreatmentInitiated.isNotEmpty &&
                                              context.read<HIVManagementFormProvider>().hivManagementFormModel.baselineHEILoad.isNotEmpty &&
                                              context.read<HIVManagementFormProvider>().hivManagementFormModel.dateStartedFirstLine.isNotEmpty &&
                                              context.read<HIVManagementFormProvider>().hivManagementFormModel.arvsSubWithFirstLine.isNotEmpty &&
                                              context.read<HIVManagementFormProvider>().hivManagementFormModel.switchToSecondLine.isNotEmpty &&
                                              context.read<HIVManagementFormProvider>().hivManagementFormModel.switchToThirdLine.isNotEmpty){
                                            selectedStep++;
                                            debugPrint("Moving to hiv screen");
                                          }else{
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Please fill in the ART Therapy info fields"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }

                                        }
                                      },
                                    );
                                  }
                                } catch (e) {
                                  // Set isLoading to false when an error occurs during form submission
                                  setState(() {
                                    isLoading = false;
                                  });

                                  if (e.toString() == locationDisabled ||
                                      e.toString() == locationDenied) {
                                    if (context.mounted) {
                                      locationMissingDialog(context);
                                    }
                                  }
                                }
                              },
                              color: kPrimaryColor,
                              isLoading:
                                  isLoading, // Pass the isLoading state to the CustomButton
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              onPressed: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: const Text(
                                            "Are you sure you want to clear the form?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                context
                                                    .read<
                                                        HIVManagementFormProvider>()
                                                    .clearForms();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14.sp,
                                                ),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "No",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                ),
                                              ))
                                        ],
                                      );
                                    });
                              },
                              child: Text(
                                "Clear Form",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14.sp,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

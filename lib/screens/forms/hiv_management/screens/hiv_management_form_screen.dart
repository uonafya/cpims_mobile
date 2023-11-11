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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../../widgets/location_dialog.dart';

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
  void submitHIVManagementForm(String startInterviewTime) async {
    try {
      String formUUid = Uuid().v4();
      await Provider.of<HIVManagementFormProvider>(context, listen: false)
          .submitHIVManagementForm(widget.caseLoad.cpimsId, formUUid,
              startInterviewTime, "HIV Management Form", context: context);
      if (context.mounted) {
        Get.back();
      }
      if (context.mounted) {
        Get.back();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formCompletionStatus =
        context.watch<FormCompletionStatusProvider>().artTherapyFormCompleted;

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
                              onTap: () {
                                try {
                                  if (selectedStep == steps.length - 1) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    // logic for verifying form and submitting
                                    AppMetaDataProvider appMetaDataProvider =
                                        Provider.of<AppMetaDataProvider>(
                                            context,
                                            listen: false);
                                    String startInterviewTime =
                                        appMetaDataProvider
                                                .startTimeInterview ??
                                            DateTime.now().toIso8601String();
                                    submitHIVManagementForm(startInterviewTime);

                                    setState(() {
                                      isLoading = false;
                                    });
                                    HIVManagementFormProvider
                                        hivManagementFormProvider =
                                        Provider.of<HIVManagementFormProvider>(
                                            context,
                                            listen: false);
                                    hivManagementFormProvider.clearForms();
                                    Navigator.pop(context);
                                  } else {
                                    setState(() {
                                      if (selectedStep < steps.length - 1 &&
                                          formCompletionStatus == true) {
                                        selectedStep++;
                                      }
                                    });
                                  }
                                } catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if(e.toString() == locationDisabled || e.toString() == locationDenied){
                                    if(context.mounted) {
                                      locationMissingDialog(context);
                                    }
                                  }
                                }
                              },
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      )
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

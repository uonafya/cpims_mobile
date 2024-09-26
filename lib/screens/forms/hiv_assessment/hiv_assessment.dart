import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/providers/app_meta_data_provider.dart';
import 'package:cpims_mobile/screens/cpara/provider/hiv_assessment_provider.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_current_status_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_risk_assessment_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/progress_monitoring_form.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_stepper.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../widgets/location_dialog.dart';
import '../../homepage/provider/stats_provider.dart';

bool disableSubsquentHIVAssessmentFieldsAndSubmit(BuildContext context) {
  final currentStatus =
      Provider.of<HIVAssessmentProvider>(context).riskAssessmentFormModel;
  return (currentStatus.statusOfChild == "No" ||
      currentStatus.hivStatus == "HIV_Positive" ||
      currentStatus.hivTestDone == "Yes");
}

class HIVAssessmentScreen extends StatefulWidget {
  const HIVAssessmentScreen({super.key, required this.caseLoadModel});

  final CaseLoadModel caseLoadModel;

  @override
  State<HIVAssessmentScreen> createState() => _HIVAssessmentScreenState();
}

class _HIVAssessmentScreenState extends State<HIVAssessmentScreen> {
  bool isLoading = false;
  List<Map<String, dynamic>> hivAssessmentTitles = [
    {
      'title': 'HIV CURRENT STATUS',
      'subtitle': '',
      'onTap': () => {},
    },
    {
      'title': 'HIV RISK ASSESSMENT',
      'subtitle': '',
      'onTap': () => {},
    },
    {
      'title': 'PROGRESS MONITORING',
      'subtitle': '',
      'onTap': () => {},
    },
  ];
  List forms = [
    const HIVCurrentStatusForm(),
    const HIVRiskAssesmentForm(),
    const ProgressMonitoringForm(),
  ];

  void handleNext(BuildContext context) async {
    final formIndex =
        Provider.of<HIVAssessmentProvider>(context, listen: false).formIndex;
    final hivCurrentStatusModel =
        Provider.of<HIVAssessmentProvider>(context, listen: false)
            .riskAssessmentFormModel;

    if (formIndex == hivAssessmentTitles.length - 1) {
      try {
        setState(() {
          isLoading = true;
        });
        if (hivCurrentStatusModel.dateOfAssessment.isEmpty ||
            hivCurrentStatusModel.statusOfChild.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please fill in the required fields"),
            backgroundColor: Colors.red,
          ));
        }
        AppMetaDataProvider appMetaDataProvider =
            Provider.of<AppMetaDataProvider>(context, listen: false);
        String startTime = appMetaDataProvider.startTimeInterview ??
            DateTime.now().toIso8601String();
        bool isFormSubmitted =
            await Provider.of<HIVAssessmentProvider>(context, listen: false)
                .submitHIVAssessmentForm(startTime);

        if (context.mounted && isFormSubmitted) {
          setState(() {
            isLoading = false;
          });
          context.read<StatsProvider>().updateFormStats();
          context.read<StatsProvider>().updateHrsStats();
          context.read<StatsProvider>().updateHrsDistinctStats();
          context.read<HIVAssessmentProvider>().clearOvcAge();

          Get.snackbar("HRS Form submitted", "HRS Form submitted successfully",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white);

          Navigator.pop(context);
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Failed to submit form"),
            backgroundColor: Colors.red,
          ));
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        if (e.toString() == locationDisabled ||
            e.toString() == locationDenied) {
          if (context.mounted) {
            locationMissingDialog(context);
            setState(() {
              isLoading = false;
            });
          }
        }
      }
      return;
    }

    Provider.of<HIVAssessmentProvider>(context, listen: false)
        .updateFormIndex(formIndex + 1);
  }

  void handleBack(BuildContext context) {
    final formIndex =
        Provider.of<HIVAssessmentProvider>(context, listen: false).formIndex;

    if (formIndex == 0) {
      return;
    }
    Provider.of<HIVAssessmentProvider>(context, listen: false)
        .updateFormIndex(formIndex - 1);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final previousCaseLoadModel =
          Provider.of<HIVAssessmentProvider>(context, listen: false)
              .caseLoadModel;
      if (previousCaseLoadModel.cpimsId != widget.caseLoadModel.cpimsId) {
        Provider.of<HIVAssessmentProvider>(context, listen: false)
            .resetWholeForm();
      }
      int ovcAge = widget.caseLoadModel.age!;

      Provider.of<HIVAssessmentProvider>(context, listen: false)
          .updateOvcAge(ovcAge);

      Provider.of<HIVAssessmentProvider>(context, listen: false)
          .updateCaseLoadModel(widget.caseLoadModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = Provider.of<HIVAssessmentProvider>(context).formIndex;

    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        children: [
          const SizedBox(
            height: 10,
          ),
          CustomCard(
            title: "HIV Risk Assessment",
            children: [
              CustomStepperWidget(
                  data: hivAssessmentTitles,
                  onTap: (index) {
                    Provider.of<HIVAssessmentProvider>(context, listen: false)
                        .updateFormIndex(index);
                  },
                  selectedIndex: selectedIndex),
              const SizedBox(
                height: 10,
              ),
              forms[selectedIndex],
              const SizedBox(
                height: 10,
              ),
              Row(children: [
                Expanded(
                    child: CustomButton(
                  text: "Back",
                  color: Colors.grey,
                  onTap: () => handleBack(context),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: CustomButton(
                  isLoading: isLoading,
                  text: selectedIndex == 2 ? "Submit" : "Next",
                  onTap: () => handleNext(context),
                )),
              ]),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Provider.of<HIVAssessmentProvider>(context,
                                listen: false)
                            .resetWholeForm();
                      },
                      child: const Text(
                        "Clear Form",
                        style: TextStyle(color: Colors.red),
                      )),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const Footer(),
        ],
      ),
    );
  }
}

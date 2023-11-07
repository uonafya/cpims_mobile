import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/screens/cpara/provider/hiv_assessment_provider.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_current_status_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_risk_assessment_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/progress_monitoring_form.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_stepper.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool disableSubsquentHIVAssessmentFieldsAndSubmit(BuildContext context) {
  final currentStatus =
      Provider.of<HIVAssessmentProvider>(context).hivCurrentStatusModel;
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

    if (formIndex == 0 &&
        Provider.of<HIVAssessmentProvider>(context, listen: false)
                .hivCurrentStatusModel ==
            null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please fill in the required fields"),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (formIndex == hivAssessmentTitles.length - 1) {
      try {
        await Provider.of<HIVAssessmentProvider>(context, listen: false)
            .submitHIVAssessmentForm();
      } catch (e) {
        if (kDebugMode) {
          print(e);
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
                  text: selectedIndex == 2 ? "Submit" : "Next",
                  onTap: () => handleNext(context),
                )),
              ]),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_current_status_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_risk_assessment_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/progress_monitoring_form.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_stepper.dart';
import 'package:flutter/material.dart';

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

  int selectedIndex = 0;

  void handleNext() {
    if (selectedIndex == hivAssessmentTitles.length - 1) {
      return;
    }
    setState(() {
      selectedIndex++;
    });
  }

  void handleBack() {
    if (selectedIndex == 0) {
      return;
    }
    setState(() {
      selectedIndex--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
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
                    setState(() {
                      selectedIndex = index;
                    });
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
                  onTap: handleBack,
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: CustomButton(
                  text: "Next",
                  onTap: handleNext,
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

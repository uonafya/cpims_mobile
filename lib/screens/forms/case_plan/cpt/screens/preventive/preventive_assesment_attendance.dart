import 'package:cpims_mobile/providers/preventive_assesment_provider.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/screens/preventive/attendance_form.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/screens/preventive/service_referral_form.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_stepper.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreventiveAssessment extends StatefulWidget {
  const PreventiveAssessment({super.key});

  @override
  State<PreventiveAssessment> createState() => _PreventiveAssessmentState();
}

class _PreventiveAssessmentState extends State<PreventiveAssessment> {
  List<Map<String, dynamic>> preventiveAssementTitles = [
    {
      'title': 'Attendance',
      'subtitle': 'Services details',
      'onTap': () => {},
    },
    {
      'title': 'Services Refferal(s)',
      'subtitle': 'Referral details',
      'onTap': () => {},
    },
  ];

  List forms = const [
    AttendanceForm(),
    ServiceReferralForm(),
  ];
  bool isLoading = false;

  void handleNext(BuildContext context) {
    final provider =
        Provider.of<PreventiveAssessmentProvider>(context, listen: false);

    if (provider.formIndex != preventiveAssementTitles.length - 1) {
      provider.updateFormIndex(provider.formIndex + 1);
    }

    if (provider.formIndex == preventiveAssementTitles.length - 1) {
      Navigator.of(context).pop();
    }
  }

  void handleBack(BuildContext context) {
    final provider =
        Provider.of<PreventiveAssessmentProvider>(context, listen: false);

    if (provider.formIndex != 0) {
      provider.updateFormIndex(provider.formIndex - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex =
        Provider.of<PreventiveAssessmentProvider>(context).formIndex;
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
          CustomCard(title: "OVC Prevention Details", children: [
            CustomStepperWidget(
                data: preventiveAssementTitles,
                onTap: (index) {
                  Provider.of<PreventiveAssessmentProvider>(context,
                          listen: false)
                      .updateFormIndex(index);
                },
                selectedIndex: selectedIndex),
            forms[selectedIndex],
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
                text: selectedIndex == preventiveAssementTitles.length
                    ? "Submit"
                    : "Next",
                onTap: () => handleNext(context),
              )),
            ]),
          ]),
          const SizedBox(
            height: 40,
          ),
          const Footer(),
        ],
      ),
    );
  }
}

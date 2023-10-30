import 'package:cpims_mobile/screens/forms/form1a/new/utils/form_one_a_provider.dart';
import 'package:cpims_mobile/screens/forms/form1a/new/widgets/fom_one_a_critical.dart';
import 'package:cpims_mobile/screens/forms/form1a/new/widgets/fom_one_a_safe.dart';
import 'package:cpims_mobile/screens/forms/form1a/new/widgets/fom_one_a_stable.dart';
import 'package:cpims_mobile/screens/forms/form1a/new/widgets/form_one_a_healthy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Models/case_load_model.dart';
import '../../../../constants.dart';
import '../../../../providers/form1a_provider.dart';
import '../../../../providers/form1b_provider.dart';
import '../../../../widgets/app_bar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_forms_date_picker.dart';
import '../../../../widgets/custom_stepper.dart';
import '../../../../widgets/custom_toast.dart';
import '../../../../widgets/drawer.dart';
import '../../../../widgets/footer.dart';
import '../../../homepage/provider/stats_provider.dart';
import '../../form1b/utils/form1bConstants.dart';

class FomOneA extends StatefulWidget {
  final CaseLoadModel caseLoadModel;

  const FomOneA({Key? key, required this.caseLoadModel}) : super(key: key);

  @override
  State<FomOneA> createState() => _FomOneAState();
}

class _FomOneAState extends State<FomOneA> {
  int selectedStep = 0;

  List<Widget> steps = [
    const FormOneAHealthy(),
    const FormOneASafe(),
    const FormOneAStable(),
    const FormOneACritical(),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Form1AProviderNew form1AProvider =
          Provider.of<Form1AProviderNew>(context, listen: false);
      form1AProvider.setFinalFormDataOvcId(widget.caseLoadModel.cpimsId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Form1AProviderNew form1AProvider =
        Provider.of<Form1AProviderNew>(context, listen: false);
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
          const Text('Form 1A',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          const Text(
            '',
            style: TextStyle(color: kTextGrey),
          ),
          const SizedBox(height: 15),
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
                    ' FORM 1B DETAILS \n CARE GIVER: ${widget.caseLoadModel.caregiverNames} \n CPIMS ID: ${widget.caseLoadModel.cpimsId}',
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
                        data: form1asStepper,
                        selectedIndex: selectedStep,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      steps[selectedStep],
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: isLastStep,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Date of Event',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              CustomFormsDatePicker(
                                  hintText: 'Select the date',
                                  selectedDateTime:
                                      form1AProvider.formData.selectedDate,
                                  onDateSelected: (selectedDate) {
                                    form1AProvider
                                        .setSelectedDate(selectedDate);
                                  }),
                              const SizedBox(
                                height: 15,
                              ),
                            ]),
                      ),
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
                              text: isLastStep ? 'Submit Form1B' : 'Next',
                              onTap: () async {
                                if (isLastStep) {
                                  bool isFormSaved =
                                      await form1AProvider.saveForm1AData(
                                    form1AProvider.formData,
                                  );
                                  setState(() {
                                    if (isFormSaved == true) {
                                      if (context.mounted) {
                                        context
                                            .read<StatsProvider>()
                                            .updateCparaFormStats();
                                      }
                                      CustomToastWidget.showToast(
                                          "Form saved successfully");
                                      Navigator.pop(context);
                                      selectedStep = 0;
                                    }
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
                      // ... your other widgets
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

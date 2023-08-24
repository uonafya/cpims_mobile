import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/form1a_provider.dart';
import 'package:cpims_mobile/screens/forms/form1a/widgets/critical_events_details.dart';
import 'package:cpims_mobile/screens/forms/form1a/widgets/services_details.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_stepper.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Form1AScreen extends StatefulWidget {
  const Form1AScreen({Key? key}) : super(key: key);

  @override
  State<Form1AScreen> createState() => _Form1AScreenState();
}

class _Form1AScreenState extends State<Form1AScreen> {
  // adding the provider
  late Form1AProvider form1AProvider;
  int selectedStep = 0;

  List<Widget> steps = [const CriticalEventsScreen(), const ServicesDetails()];
//  I've moved the initialization of form1AProvider to the didChangeDependencies method, which is called after the widget has been initialized and the context is available.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    form1AProvider = Provider.of<Form1AProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(height: 20),
          const Text(
            'Forms',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Service and Monitoring(Form 1A)',
            style: TextStyle(color: kTextGrey),
          ),
          const SizedBox(height: 30),
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
                  width: double.infinity,
                  color: Colors.black,
                  child: const Text(
                    'Form 1A Details',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      CustomStepperWidget(
                        onTap: (index) {
                          form1AProvider.setSelectedStep(index);
                        },
                        data: form1AStepper,
                        selectedIndex: form1AProvider.selectedStep,
                      ),
                      const SizedBox(height: 25),
                      steps[form1AProvider.selectedStep],
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: form1AProvider.selectedStep <= 0
                                  ? 'Cancel'
                                  : 'Back',
                              onTap: () {
                                if (form1AProvider.selectedStep == 0) {
                                  Navigator.pop(context);
                                } else {
                                  form1AProvider.setSelectedStep(
                                      form1AProvider.selectedStep - 1);
                                }
                              },
                              color: kTextGrey,
                            ),
                          ),
                          const SizedBox(width: 50),
                          Expanded(
                            child: CustomButton(
                              text: form1AProvider.selectedStep ==
                                      steps.length - 1
                                  ? 'Submit'
                                  : 'Next',
                              onTap: () {
                                if (selectedStep < steps.length - 1) {
                                  form1AProvider
                                      .setSelectedStep(selectedStep + 1);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
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

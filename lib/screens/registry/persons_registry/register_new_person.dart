import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/registry/persons_registry/widgets/persons_contact_information.dart';
import 'package:cpims_mobile/screens/registry/persons_registry/widgets/persons_identification.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_stepper.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterNewPerson extends StatefulWidget {
  const RegisterNewPerson({Key? key}) : super(key: key);

  @override
  State<RegisterNewPerson> createState() => _RegisterNewPersonState();
}

class _RegisterNewPersonState extends State<RegisterNewPerson> {
  int selectedIndex = 0;

  List<Widget> steps = const [
    PersonsIdentification(),
    PersonsContactInformation(),
    PersonsIdentification(),
    PersonsIdentification(),
    PersonsIdentification(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: ListView(
        padding: kSystemPadding,
        shrinkWrap: true,
        children: [
          const SizedBox(height: 20),
          const Text('Person Registry',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          const Text(
            'New child, Caregiver, Volunteer or Government/NGO Employee',
            style: TextStyle(color: kTextGrey),
          ),
          const SizedBox(height: 30),
          CustomCard(title: 'Create Person', children: [
            const Text(
              'Personal Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Person Type',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const CustomTextField(
              hintText: 'Child',
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'First Name',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const CustomTextField(
              hintText: 'First Name',
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Surname',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const CustomTextField(
              hintText: 'Surname',
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Other Name(s)',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const CustomTextField(
              hintText: 'Other Name(s)',
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Sex',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const CustomTextField(
              hintText: 'Please select',
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Date of Birth',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const CustomTextField(
              hintText: 'Date of Birth',
            ),
            const SizedBox(
              height: 15,
            ),
            CustomStepperWidget(
                data: personRegistryStepper,
                onTap: (val) {
                  setState(() {
                    selectedIndex = val;
                  });
                },
                selectedIndex: selectedIndex),
            const SizedBox(
              height: 25,
            ),
            steps[selectedIndex],
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: selectedIndex <= 0 ? 'Cancel' : 'Previous',
                    onTap: () {
                      if (selectedIndex == 0) {
                        Navigator.pop(context);
                      }
                      setState(() {
                        if (selectedIndex > 0) {
                          selectedIndex--;
                        }
                      });
                    },
                    color: kTextGrey,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: CustomButton(
                    text: selectedIndex == steps.length - 1 ? 'Submit' : 'Next',
                    onTap: () {
                      setState(() {
                        if (selectedIndex < steps.length - 1) {
                          selectedIndex++;
                        }
                      });
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Workforce members recorded on paper',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const CustomTextField(
              hintText: 'Workforce ID/Name',
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Date paper form filled',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: DateFormat('dd-MMM-yyyy').format(DateTime.now()),
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
          const Footer(),
        ],
      ),
    );
  }
}

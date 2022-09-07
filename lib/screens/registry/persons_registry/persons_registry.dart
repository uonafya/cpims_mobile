import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/registry/persons_registry/register_new_person.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_dropdown.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class PersonsRegistry extends StatefulWidget {
  const PersonsRegistry({super.key});

  @override
  State<PersonsRegistry> createState() => _PersonsRegistryState();
}

class _PersonsRegistryState extends State<PersonsRegistry> {
  List<String> typeOfPersons = [
    'Please Select',
    'Child',
    'Caregiver',
    'Government employee',
    'NGO/private sector employee',
    'Volunteer',
  ];

  List<String> criteria = [
    'Select Criteria',
    'Names',
    'Org Unit',
    'Residence',
    'CPIMS ID',
  ];

  String selectedTypeOfPerson = 'Please Select';
  String selectedCriteria = 'Select Criteria';

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
              const Text('Persons Registry',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 5),
              const Text(
                'Search person',
                style: TextStyle(color: kTextGrey),
              ),
              const SizedBox(height: 30),
              CustomCard(title: 'Search Persons', children: [
                CustomDropdown(
                  initialValue: selectedTypeOfPerson,
                  items: typeOfPersons,
                  onChanged: (val) {
                    setState(() {
                      selectedTypeOfPerson = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                const CustomTextField(hintText: 'Search...'),
                const SizedBox(
                  height: 15,
                ),
                CustomDropdown(
                  initialValue: selectedCriteria,
                  items: criteria,
                  onChanged: (val) {
                    setState(() {
                      selectedCriteria = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(child: CustomButton(text: 'Search', onTap: () {})),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: CustomButton(
                            text: 'Register New',
                            onTap: () {
                              Get.to(() => const RegisterNewPerson());
                            })),
                  ],
                ),
              ]),
              Footer(),
            ]));
  }
}

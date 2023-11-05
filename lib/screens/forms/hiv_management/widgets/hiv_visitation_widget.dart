import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:cpims_mobile/widgets/custom_dynamic_radio_button.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';

class HIVVisitationWidget extends StatelessWidget {
  const HIVVisitationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StepsWrapper(
      title: '2. Visitation',
      children: [
        const Text(
          'Q1) Visit Date',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomDatePicker(),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q2) Duration on ARTs (in months)	',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomTextField(),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q3) Height (cm)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomTextField(),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q4) MUAC',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomDatePicker(),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q5) ARV drugs - Adherence',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomDynamicRadioButton(
          isNaAvailable: false,
          optionSelected: (String? option) {},
          customOptions: const ['Good', 'Fair', 'Poor'],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q6) ARV drugs - Duration for drugs (in months)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomTextField(),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q7) Adherence Counseling',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomDynamicRadioButton(
          isNaAvailable: false,
          optionSelected: (String? option) {},
          customOptions: const [
            'Treatment Preparation',
            'Booster Adherence',
            'Enhanced Adherence'
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q8) Treatment supporter',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomDynamicRadioButton(
          isNaAvailable: false,
          optionSelected: (String? option) {},
          customOptions: const [
            'Biological parent',
            'Sibling',
            'Grandparent',
            'Other Relatives',
            'Others'
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q9) Treatment supporter-Others',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomTextField(
          hintText: 'Others',
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q10) Treatment supporter-Sex',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomDynamicRadioButton(
          isNaAvailable: false,
          optionSelected: (String? option) {},
          customOptions: const [
            'Male',
            'Female',
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q11) Treatment supporter-Age',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomTextField(
          hintText: 'Age',
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q12) Treatment supporter-HIV_Status',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomDynamicRadioButton(
          isNaAvailable: false,
          optionSelected: (String? option) {},
          customOptions: const [
            'HIV_Positive',
            'HIV_NEGATIVE',
            'HIV_UNKOWN/UNDISCLOSED',
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q13) Lab Investigations-Viral load results',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomTextField(
          hintText: 'Viral Load Results (if LDL enter 1)',
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

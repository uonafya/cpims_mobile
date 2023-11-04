import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:cpims_mobile/widgets/custom_dynamic_checkbox_widget.dart';
import 'package:cpims_mobile/widgets/custom_dynamic_radio_button.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';

class HIVVisitationWidget extends StatefulWidget {
  const HIVVisitationWidget({super.key});

  @override
  State<HIVVisitationWidget> createState() => _HIVVisitationWidgetState();
}

class _HIVVisitationWidgetState extends State<HIVVisitationWidget> {
  Set<String> selectedOptions = <String>{};

  void handleOptionsSelected(Set<String> options) {
    setState(() {
      selectedOptions = options;
    });
  }

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
        const Text(
          'Q14) Lab Investigations - Date*',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomTextField(
          hintText: 'Date',
          enabled: false,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q15) Detectable (>401 cp/ml)Viral load interventions',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomDynamicRadioButton(
          isNaAvailable: false,
          optionSelected: (String? option) {},
          customOptions: const [
            'Direct Observed Therapy',
            'Case Conferencing done',
            'Case Plan Reviewed',
            'Discussed Multi-disciplinary Team',
            'Special Support Group',
            'Transport to clinic',
            'HH visit',
            'Disclosure',
            'Escort for Clinic appointments',
            'provision of pill boxes',
            'Provision of alarm watches/clocks',
            'Other'
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q16) Disclosure',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomDynamicRadioButton(
          isNaAvailable: false,
          optionSelected: (String? option) {},
          customOptions: const [
            'Not Done',
            'Partial',
            'Full Disclosure',
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q17) Nutritional assessment-MUAC Score',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomDynamicRadioButton(
          isNaAvailable: false,
          optionSelected: (String? option) {},
          customOptions: const [
            'Red',
            'Yellow',
            'Green',
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q18) Nutritional assessment-BMI(Z Score)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomTextField(
          hintText: 'nutritional assessment',
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q19) Nutritional support',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomDynamicCheckBox(
          options: const [
            'Therapeutic Feeding if <2yrs',
            'Infant Feeding Counselling if <2yrs',
            'Food Support',
            'Exclusive Breastfeeding',
            'ExclusiveReplacementFeeding',
            'Mixed Feeding'
          ],
          selectedOptions: selectedOptions,
          optionsSelected: handleOptionsSelected,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q20) Enrolled in support group(status)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomDynamicRadioButton(
          customOptions: const [
            'Active',
            'Dormant',
            'Not Enrolled',
          ],
          isNaAvailable: false,
          optionSelected: (String? option) {},
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q21) Enrolled in NHIF?',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomRadioButton(
          optionSelected: (RadioButtonOptions? options) {},
          isNaAvailable: false,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q22) Enrolled in NHIF - Status?',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomDynamicRadioButton(
          customOptions: const [
            'Active',
            'Dormant',
          ],
          isNaAvailable: false,
          optionSelected: (String? option) {},
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q23) Referral services (specify)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomTextField(
          hintText: 'Services',
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q24) Date of Next Appointment *',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        DateTextField(
          label: 'Date',
          enabled: true,
          identifier: DateTextFieldIdentifier.dateOfAssessment,
          onDateSelected: (DateTime? dateTime) {},
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Q25) Peer Educator Name',
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
          'Q26) Peer Educator Contacts',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomTextField(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

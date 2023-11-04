import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';

class ARTTherapyInfoWidget extends StatelessWidget {
  const ARTTherapyInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StepsWrapper(
      title: '1. ARV Therapy Info',
      children: [
        const Text(
          '1) Date Confirmed HIV Positive',
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
          '2a) Date Initiated on Treatment',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        DateTextField(
          label: 'Date confirmed positive',
          enabled: true,
          onDateSelected: (date) {},
          identifier: DateTextFieldIdentifier.dateOfAssessment,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          '2b) Baseline viral load for HEI',
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
          '3) Date started on 1st Line',
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
          '4) Substitution of ARVs within 1st Line Regimen',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomRadioButton(
          isNaAvailable: false,
          optionSelected: (RadioButtonOptions? options) {},
        ),
        const CustomDatePicker(
          hintText: 'If Yes, Date',
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          '5) Switch to 2nd Line (or Substitute within 2nd Line)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomRadioButton(
          isNaAvailable: false,
          optionSelected: (RadioButtonOptions? options) {},
        ),
        const CustomDatePicker(
          hintText: 'If Yes, Date',
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          '6) Switch to 3rd Line (or Substitute within 3nd Line)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomRadioButton(
          isNaAvailable: false,
          optionSelected: (RadioButtonOptions? options) {},
        ),
        const CustomDatePicker(
          hintText: 'If Yes, Date',
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

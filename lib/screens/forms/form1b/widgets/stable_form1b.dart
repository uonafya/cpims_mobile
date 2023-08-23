import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class StableForm1b extends StatelessWidget {
  const StableForm1b({super.key});

  @override
  Widget build(BuildContext context) {
    return const StepsWrapper(
      title: 'Caregiver household economic strengthening status',
      children: [
        Text(
          'Service(s)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Select service',
        ),
        Text(
          'Date of Service(s) / Event',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomDatePicker(
          hintText: 'Select date',
        )
      ],
    );
  }
}

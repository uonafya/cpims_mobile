import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
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
          'County',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Please select',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Sub-county',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Please select',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Wards',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Please select',
        ),
      ],
    );
  }
}

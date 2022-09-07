import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class OrganisationLocationRegistry extends StatelessWidget {
  const OrganisationLocationRegistry({super.key});

  @override
  Widget build(BuildContext context) {
    return const StepsWrapper(
      title: 'Location',
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

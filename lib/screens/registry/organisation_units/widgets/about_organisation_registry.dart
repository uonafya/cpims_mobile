import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AboutOrganisationRegistry extends StatelessWidget {
  const AboutOrganisationRegistry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StepsWrapper(
      title: 'About the Organisation',
      children: [
        Text(
          'Name of organisation unit',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Unit name',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Date when the organisation was set up or become operational',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Select date',
        ),
      ],
    );
  }
}

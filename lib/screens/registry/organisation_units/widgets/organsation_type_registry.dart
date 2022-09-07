import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class OrganisationTypeRegistry extends StatelessWidget {
  const OrganisationTypeRegistry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StepsWrapper(
      title: 'Organisation Type',
      children: [
        Text(
          'Type and sub-type of organisation unit',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Select unit type',
        ),
        SizedBox(height: 15),
        CustomTextField(
          hintText: 'Select sub type',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Legal registration type',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Select registration type',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Legal registration number',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Registration No.',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Parent Unit',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: '1 Selected',
        ),
      ],
    );
  }
}

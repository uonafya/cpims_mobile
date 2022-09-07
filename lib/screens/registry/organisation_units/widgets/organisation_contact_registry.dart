import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class OrganisationContactRegistry extends StatelessWidget {
  const OrganisationContactRegistry({super.key});

  @override
  Widget build(BuildContext context) {
    return const StepsWrapper(
      title: 'Contacts',
      children: [
        Text(
          'Contact person',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: '',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Email address',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: '',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Latitude',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: '',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Longitude',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: '',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Phone number - landline',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: '',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Phone number - mobile',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: '',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Physical address',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: '',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Postal address',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: '',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Website',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: '',
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

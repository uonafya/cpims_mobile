import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class PersonsContactInformation extends StatelessWidget {
  const PersonsContactInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StepsWrapper(
      title: 'Contact Information',
      children: [
        Text(
          'Designated mobile number',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: '07xxxxxxxxx',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Other mobile number',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: '07xxxxxxxxx',
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
          hintText: 'Email address',
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Physical Location',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: '',
        ),
      ],
    );
  }
}

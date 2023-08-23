import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CriticalEventForm1b extends StatelessWidget {
  const CriticalEventForm1b({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StepsWrapper(
      title: 'Caregiver critical events',
      children: [
        Text(
          'Critical Event(s)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Select event',
        ),

        SizedBox(height: 15),

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

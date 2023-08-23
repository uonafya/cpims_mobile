import 'package:cpims_mobile/screens/forms/form1b/utils/form1bConstants.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiselect/multiselect.dart';

class HealthyForm1b extends StatefulWidget {
  const HealthyForm1b({Key? key}) : super(key: key);

  @override
  State<HealthyForm1b> createState() => _HealthyForm1b();
}

class _HealthyForm1b extends State<HealthyForm1b> {



  @override
  Widget build(BuildContext context) {
    return const StepsWrapper(
        title: 'Caregiver health and nutrition status',
        children:[
        Text(
          'Service(s)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Select service',
        ),
        SizedBox(
          height: 15,
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

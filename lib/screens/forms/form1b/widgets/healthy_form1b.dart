import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../widgets/custom_date_picker.dart';

class HealthyForm1b extends StatefulWidget {
  const HealthyForm1b({Key? key}) : super(key: key);

  @override
  State<HealthyForm1b> createState() => _HealthyForm1bState();
}

class _HealthyForm1bState extends State<HealthyForm1b> {


  List<String> typeOfEvents = [
    'OCE1 - Child Pregnant',
    'OCE2 - Child not Adhering to ARVs',
    'OCE3 - Child Malnourished',
    'OCE4 - Child HIV status Changed',
    'OCE5 - Child Acquired Opportunistic Infection'
  ];
  List<String> selectedEvents = [];

  @override
  Widget build(BuildContext context) {
    return StepsWrapper(
      title: 'Caregiver health and nutrition status',
      children: [
        const Text(
          'Name of organisation unit',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Services(s)',
          onOptionSelected: (selectedEvents) {
            setState(() {
              this.selectedEvents = selectedEvents.cast<String>().toList();
            });
          },
          options: const <ValueItem>[
            ValueItem(label: 'Child Pregnant', value: '1'),
            ValueItem(label: 'Child not Adhering to ARVs', value: '2'),
            ValueItem(label: 'Child Malnourished', value: '3'),
            ValueItem(label: 'Child HIV status Changed', value: '4'),
            ValueItem(
                label: 'Child Acquired Opportunistic Infection', value: '5'),
          ],
          maxItems: 13,
          disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
          selectionType: SelectionType.multi,
          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
          dropdownHeight: 300,
          optionTextStyle: const TextStyle(fontSize: 16),
          selectedOptionIcon: const Icon(Icons.check_circle),
          borderRadius: BorderRadius.circular(5.w)
              .topLeft
              .x, // Set the desired border radius value
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          'Date of Service(s) / Event',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const CustomDatePicker(
          hintText: 'Select the date',
        ),
      ],
    );
  }
}

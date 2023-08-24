import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class SafeForm1b extends StatefulWidget {
  const SafeForm1b({super.key});


  @override
  State<SafeForm1b> createState() => _SafeForm1bState();
}

class _SafeForm1bState extends State<SafeForm1b> {

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
      title: 'Caregiver protection service',
      children: [
        const Text(
          'Service(s)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const CustomTextField(
          hintText: 'Select service',
        ),
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
        const SizedBox(height: 10),
        const CustomDatePicker(
          hintText: 'Select date',
        )
      ],
    );
  }
}

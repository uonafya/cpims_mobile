import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class CriticalEventsScreen extends StatefulWidget {
  const CriticalEventsScreen({Key? key}) : super(key: key);

  @override
  State<CriticalEventsScreen> createState() => _CriticalEventsScreenState();
}

class _CriticalEventsScreenState extends State<CriticalEventsScreen> {
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
      title: 'Events',
      children: [
        const Text(
          'Critical Event(s)*',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Please Critical Event(s)',
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
          'Date Critical Event Recorded*',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const CustomDatePicker(
          hintText: 'Select the date',
        ),
        const SizedBox(
          height: 15,
        ),
        const CustomButton(text: 'Submit Critical Event(s)'),
        const SizedBox(
          height: 15,
        ),
        const CustomButton(text: 'Cancel', color: kTextGrey),
      ],
    );
  }
}

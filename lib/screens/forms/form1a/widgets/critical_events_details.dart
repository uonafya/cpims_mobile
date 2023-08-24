import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/form1a_provider.dart';
import 'package:cpims_mobile/screens/forms/form1a/utils/form_1a_options.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

class CriticalEventsScreen extends StatefulWidget {
  const CriticalEventsScreen({Key? key}) : super(key: key);

  @override
  State<CriticalEventsScreen> createState() => _CriticalEventsScreenState();
}

class _CriticalEventsScreenState extends State<CriticalEventsScreen> {
  List<Map> listOfEvents = optionsEvents;

  List<ValueItem> listOfCriticalEvents = optionsEvents.map((service) {
    return ValueItem(
        label: "${service['event_id']}", value: service['description']);
  }).toList();
  List<ValueItem> selectedEvents = [];
  List<ValueItem> selectedEventsOptions = [];

  @override
  Widget build(BuildContext context) {
    Form1AProvider form1aProvider = Provider.of<Form1AProvider>(context);
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
            selectedEventsOptions = selectedEvents;
            form1aProvider.setSelectedEvents(selectedEvents);
          },
          options: listOfCriticalEvents,
          maxItems: 13,
          selectedOptions: selectedEventsOptions.cast<ValueItem>(),
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
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CustomButton(text: 'Submit Event(s)'),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: CustomButton(text: 'Cancel', color: kTextGrey),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const CustomButton(text: 'History Event(s)'),
      ],
    );
  }
}

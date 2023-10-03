import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/form1a_provider.dart';
import 'package:cpims_mobile/screens/forms/form1a/utils/form_1a_options.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_forms_date_picker.dart';
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
  List<ValueItem> listOfCriticalEvents = optionsEvents.map((events) {
    return ValueItem(
        label: "${events['event_description']}",
        value: "${events['event_id']}");
  }).toList();
  List<ValueItem> selectedEvents = [];
  List<ValueItem> selectedEventsOptions = [];
  DateTime currentEventSelectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Form1AProvider form1aProvider = Provider.of<Form1AProvider>(context);
    selectedEventsOptions = form1aProvider.criticalFormData.selectedEvents;
    currentEventSelectedDate = form1aProvider.criticalFormData.selectedDate;

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
            // form1aProvider.submitCriticalData();
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
        CustomFormsDatePicker(
            hintText: 'Select the date',
            selectedDateTime: currentEventSelectedDate,
            onDateSelected: (selectedDate) {
              currentEventSelectedDate = selectedDate;
              form1aProvider.setEventSelectedDate(currentEventSelectedDate);
            }),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CustomButton(
                text: 'Submit Event(s)',
                onTap: () {
                  form1aProvider.submitCriticalData();
                  print('Critical Event(s) submitted and the data is ${form1aProvider.criticalFormData.selectedEvents} and date is ${form1aProvider.criticalFormData.selectedDate}');
                },
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            const Expanded(
              child: CustomButton(text: 'Cancel', color: kTextGrey),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        // const CustomButton(text: 'History Event(s)'),
      ],
    );
  }
}
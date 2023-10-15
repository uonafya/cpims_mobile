import 'package:cpims_mobile/screens/forms/form1b/utils/form1bConstants.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:cpims_mobile/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../../providers/form1b_provider.dart';

class CriticalEventForm1b extends StatefulWidget {
  const CriticalEventForm1b({Key? key}) : super(key: key);


  @override
  State<CriticalEventForm1b> createState() => _CriticalEventForm1bState();
}

class _CriticalEventForm1bState extends State<CriticalEventForm1b> {

  List<Map> careGiverServices = careGiverCriticalEvents;
  List<ValueItem> careGiverCriticalItems = careGiverCriticalEvents.map((service) {
    return ValueItem(label: "- ${service['subtitle']}", value: service['title']);
  }).toList();

  List<ValueItem> selectedCriticalEvents = [];

  @override
  Widget build(BuildContext context) {
    Form1bProvider form1bProvider = Provider.of<Form1bProvider>(context);
    selectedCriticalEvents = form1bProvider.criticalEventDataForm1b.selectedEvents;


    return StepsWrapper(
      title: 'Caregiver critical events',
      children: [
        const Text(
          'Critical Event(s)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Services(s)',
          onOptionSelected: (selectedServices) {
            form1bProvider.setCriticalEventsSelectedEvents(selectedServices);
            // CustomToastWidget.showToast(form1bProvider.criticalEventDataForm1b.selectedEvents[0].label);
          },
          selectedOptions: selectedCriticalEvents,
          options: careGiverCriticalItems,
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

        const SizedBox(height: 15),

        const Text(
          'Date of Service(s) / Event',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const CustomDatePicker(
          hintText: 'Select date',
        )
      ],
    );
  }
}

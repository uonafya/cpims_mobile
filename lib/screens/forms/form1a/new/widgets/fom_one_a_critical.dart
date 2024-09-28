import 'package:cpims_mobile/services/manager/metadata_manager.dart';
import 'package:cpims_mobile/utils/map_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../../registry/organisation_units/widgets/steps_wrapper.dart';
import '../../utils/form_1a_options.dart';
import '../utils/form_one_a_provider.dart';

class FormOneACritical extends StatefulWidget {
  const FormOneACritical({Key? key}) : super(key: key);

  @override
  State<FormOneACritical> createState() => _FormOneACritical();
}

class _FormOneACritical extends State<FormOneACritical> {
  List<Map> formOneAEvents = formOneACriticalEvents;
  List<ValueItem> careGiverCriticalItems =
      formOneACriticalEvents.map((service) {
    return ValueItem(
        label: "- ${service['event_description']}", value: service['event_id']);
  }).toList();

  List<ValueItem> selectedCriticalEvents = [];

  @override
  Widget build(BuildContext context) {
    Form1AProviderNew form1aProvider = Provider.of<Form1AProviderNew>(context);
    selectedCriticalEvents =
        form1aProvider.criticalEventDataForm1b.selectedEvents;

    return StepsWrapper(
      title: 'Critical Events',
      children: [
        const Text(
          'Critical Event(s)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          hint: 'Services(s)',
          onOptionSelected: (selectedServices) {
            form1aProvider.setCriticalEventsSelectedEvents(selectedServices);
            // CustomToastWidget.showToast(form1bProvider.criticalEventDataForm1b.selectedEvents[0].label);
          },
          selectedOptions: selectedCriticalEvents,
          options: MetadataManager.getInstance().olmisCriticalEvent.toValueItemList(),
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
      ],
    );
  }
}

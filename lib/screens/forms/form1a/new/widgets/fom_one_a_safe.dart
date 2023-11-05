import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../../registry/organisation_units/widgets/steps_wrapper.dart';
import '../../../form1b/utils/form1bConstants.dart';
import '../../utils/form_1a_options.dart';
import '../utils/form_one_a_provider.dart';

class FormOneASafe extends StatefulWidget {
  const FormOneASafe({super.key});

  @override
  State<FormOneASafe> createState() => _FormOneASafeState();
}

class _FormOneASafeState extends State<FormOneASafe> {
  List<ValueItem> safeServicesOptions = safeServices.map((service) {
    return ValueItem(
        label: service['item_description'], value: service['item_id']);
  }).toList();

  List<ValueItem> selectedSafeServicesOptions = [];
  List<ValueItem> selectedSafeServicesOptionsOptions = [];

  @override
  Widget build(BuildContext context) {
    Form1AProviderNew form1aProvider = Provider.of<Form1AProviderNew>(context);
    selectedSafeServicesOptionsOptions =
        form1aProvider.safeFormData.selectedServices;

    String domainId = domainsList[3]['item_id'];

    return StepsWrapper(
      title: 'Safe',
      children: [
        const Text(
          'Service(s)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Services(s)',
          onOptionSelected: (selectedServices) {
            selectedSafeServicesOptions = selectedServices;
            form1aProvider.setSelectedSafeFormDataServices(
                selectedSafeServicesOptions, domainId);
            debugPrint(
                'selectedSafeServicesOptions: $selectedSafeServicesOptions');
          },
          options: safeServicesOptions,
          selectedOptions:
              selectedSafeServicesOptionsOptions.cast<ValueItem>(),
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../../registry/organisation_units/widgets/steps_wrapper.dart';
import '../../../form1b/utils/form1bConstants.dart';
import '../../utils/form_1a_options.dart';
import '../utils/form_one_a_provider.dart';

class FormOneAHealthy extends StatefulWidget {
  const FormOneAHealthy({Key? key}) : super(key: key);

  @override
  State<FormOneAHealthy> createState() => _FormOneAHealthy();
}

class _FormOneAHealthy extends State<FormOneAHealthy> {
  List<ValueItem> healthServices = healthServicesOptions.map((service) {
    return ValueItem(
        label: service['item_description'], value: service['item_id']);
  }).toList();

  List<ValueItem> selectedCareGiverServices = [];
  List<ValueItem> selectedCareGiverServicesOptions = [];
  String currentlySelectedDate = "";

  @override
  Widget build(BuildContext context) {
    Form1AProviderNew form1aProvider = Provider.of<Form1AProviderNew>(context);
    selectedCareGiverServicesOptions = form1aProvider.formData.selectedServices;
    currentlySelectedDate = form1aProvider.formData.selectedDate!;
    String healthDomainId = domainsList[1]['item_id'];

    return StepsWrapper(
      title: 'Healthy',
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
            selectedCareGiverServices = selectedServices;
            form1aProvider.setSelectedHealthServices(
                selectedCareGiverServices, healthDomainId);
            debugPrint('selectedCareGiverServices: $selectedCareGiverServices');

          },
          options: healthServices,
          maxItems: 13,
          selectedOptions: selectedCareGiverServicesOptions.cast<ValueItem>(),
          disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
          selectionType: SelectionType.multi,
          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
          dropdownHeight: 300,
          optionTextStyle: const TextStyle(fontSize: 16),
          selectedOptionIcon: const Icon(Icons.check_circle),
          borderRadius: BorderRadius.circular(5.w).topLeft.x,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

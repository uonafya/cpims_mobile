import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../../registry/organisation_units/widgets/steps_wrapper.dart';
import '../../../form1b/utils/form1bConstants.dart';
import '../../utils/form_1a_options.dart';
import '../utils/form_one_a_provider.dart';

class FormOneASchooled extends StatefulWidget {
  const FormOneASchooled({super.key});

  @override
  State<FormOneASchooled> createState() => _FormOneASchooledState();
}

class _FormOneASchooledState extends State<FormOneASchooled> {
  List<ValueItem> schooledServices =
  schooledServicesOptions.map((service) {
    return ValueItem(label: service['item_description'], value: service['item_id']);
  }).toList();

  List<ValueItem> selectedSchooledServices = [];
  List<ValueItem> selectedSchooledServicesOptions = [];

  @override
  Widget build(BuildContext context) {

    Form1AProviderNew form1aProvider = Provider.of<Form1AProviderNew>(context);
    selectedSchooledServices = form1aProvider.stableFormData.selectedServices;
    String domainId = domainsList[0]['item_id'];

    return StepsWrapper(
      title: '',
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
            selectedSchooledServices = selectedServices;
            form1aProvider.setSelectedSafeFormDataServices(
                selectedSchooledServices, domainId);
            debugPrint('selectedSchooledServices: $selectedSchooledServices');
          },
          options: schooledServices,
          selectedOptions:
          selectedSchooledServicesOptions.cast<ValueItem>(),
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

import 'package:cpims_mobile/services/metadata_service.dart';
import 'package:cpims_mobile/utils/map_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../../../services/manager/metadata_manager.dart';
import '../../../../registry/organisation_units/widgets/steps_wrapper.dart';
import '../../../form1b/utils/form1bConstants.dart';
import '../../utils/form_1a_options.dart';
import '../utils/form_one_a_provider.dart';

class FormOneAStable extends StatefulWidget {
  const FormOneAStable({super.key});

  @override
  State<FormOneAStable> createState() => _FormOneAStableState();
}

class _FormOneAStableState extends State<FormOneAStable> {
  List<ValueItem> stableServices = stableServicesOptions.map((service) {
    return ValueItem(
        label: service['item_description'], value: service['item_id']);
  }).toList();

  List<ValueItem> selectedCareGiverStableServices = [];
  List<ValueItem> selectedCareGiverStableServicesOptions = [];

  @override
  Widget build(BuildContext context) {
    Form1AProviderNew form1aProvider = Provider.of<Form1AProviderNew>(context);
    selectedCareGiverStableServicesOptions =
        form1aProvider.stableFormData.selectedServices;
    String domainId = domainsList[2]['item_id'];

    return StepsWrapper(
      title: 'Stable',
      children: [
        const Text(
          'Service(s)',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          hint: 'Services(s)',
          onOptionSelected: (selectedServices) {
            selectedCareGiverStableServices = selectedServices;
            form1aProvider.setSelectedStableFormDataServices(
                selectedCareGiverStableServices, domainId);
            debugPrint(
                'selectedCareGiverStableServices: $selectedCareGiverStableServices');
          },
          options: MetadataManager.getInstance().olmisHeServices.toValueItemList(),
          selectedOptions:
              selectedCareGiverStableServicesOptions.cast<ValueItem>(),
          maxItems: 50,
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

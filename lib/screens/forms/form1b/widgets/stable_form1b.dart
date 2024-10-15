import 'package:cpims_mobile/screens/forms/form1b/utils/form1bConstants.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/utils/map_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../../providers/form1b_provider.dart';
import '../../../../services/manager/metadata_manager.dart';

class StableForm1b extends StatefulWidget {
  const StableForm1b({super.key});

  @override
  State<StableForm1b> createState() => _StableForm1bState();
}

class _StableForm1bState extends State<StableForm1b> {
  List<ValueItem> caregiverEconomicItems =
      careGiverEconomicServices.map((service) {
    return ValueItem(
        label: service['item_description'], value: service['item_id']);
  }).toList();

  List<ValueItem> selectedCareGiverStableServices = [];
  List<ValueItem> selectedCareGiverStableServicesOptions = [];

  @override
  Widget build(BuildContext context) {
    Form1bProvider form1bProvider = Provider.of<Form1bProvider>(context);
    selectedCareGiverStableServicesOptions =
        form1bProvider.stableFormData.selectedServices;
    String domainId = domainsList[2]['item_id'];

    return StepsWrapper(
      title: 'Caregiver household economic strengthening status',
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
            form1bProvider.setSelectedStableFormDataServices(
                selectedCareGiverStableServices, domainId);
          },
          options: MetadataManager.getInstance().sixS.toValueItemList(),
          selectedOptions:
              selectedCareGiverStableServicesOptions.cast<ValueItem>(),
          maxItems: 50,
          // disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
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

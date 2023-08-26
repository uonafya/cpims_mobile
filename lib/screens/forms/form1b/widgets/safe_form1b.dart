import 'package:cpims_mobile/screens/forms/form1b/utils/form1bConstants.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import '../../../../providers/form1b_provider.dart';


class SafeForm1b extends StatefulWidget {
  const SafeForm1b({super.key});

  @override
  State<SafeForm1b> createState() => _SafeForm1bState();
}

class _SafeForm1bState extends State<SafeForm1b> {

  List<ValueItem> caregiverProtectionItems = careGiverProtectionServices.map((service) {
    return ValueItem(label: "- ${service['subtitle']}", value: service['title']);
  }).toList();

  List<ValueItem> selectedCareGiverProtectionServices = [];
  List<ValueItem> selectedCareGiverProtectionServicesOptions = [];


  @override
  Widget build(BuildContext context) {
    Form1bProvider form1bProvider = Provider.of<Form1bProvider>(context);
    selectedCareGiverProtectionServicesOptions = form1bProvider.safeFormData.selectedServices;

    String domainId = ServiceDomains[1]['id'];


    return StepsWrapper(
      title: 'Caregiver protection service',
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
            selectedCareGiverProtectionServices = selectedServices;
            form1bProvider.setSelectedSafeFormDataServices(selectedCareGiverProtectionServices, domainId);
          },
          options: caregiverProtectionItems,
          selectedOptions: selectedCareGiverProtectionServicesOptions.cast<ValueItem>(),
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

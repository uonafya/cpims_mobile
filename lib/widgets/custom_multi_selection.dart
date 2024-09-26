import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../screens/forms/form1b/utils/form1bConstants.dart';

class CustomMultiSelectDropDown extends StatefulWidget {
  final bool showClearIcon;
  final String hint;
  final Function(List<String>) onOptionSelected;
  final List<ValueItem> options;
  final int maxItems;
  final List<ValueItem> disabledOptions;
  final SelectionType selectionType;
  final ChipConfig chipConfig;
  final double dropdownHeight;
  final TextStyle optionTextStyle;
  final Icon selectedOptionIcon;
  final BorderRadius borderRadius;

  const CustomMultiSelectDropDown({
    Key? key,
    required this.showClearIcon,
    required this.hint,
    required this.onOptionSelected,
    required this.options,
    required this.maxItems,
    required this.disabledOptions,
    required this.selectionType,
    required this.chipConfig,
    required this.dropdownHeight,
    required this.optionTextStyle,
    required this.selectedOptionIcon,
    required this.borderRadius,
  }) : super(key: key);

  @override
  State<CustomMultiSelectDropDown> createState() =>
      _CustomMultiSelectDropDownState();
}

class _CustomMultiSelectDropDownState extends State<CustomMultiSelectDropDown> {
  List<String> selectedServices = [];

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
      hint: widget.hint,
      onOptionSelected: (selectedServices) {
        setState(() {
          this.selectedServices = selectedServices.cast<String>().toList();
          widget.onOptionSelected(selectedServices.cast<String>().toList());
        });
      },
      options: widget.options,
      maxItems: widget.maxItems,
      disabledOptions: widget.disabledOptions,
      selectionType: widget.selectionType,
      chipConfig: widget.chipConfig,
      dropdownHeight: widget.dropdownHeight,
      optionTextStyle: widget.optionTextStyle,
      selectedOptionIcon: widget.selectedOptionIcon,
      borderRadius: widget.borderRadius.topLeft.x,
    );
  }
}

//SAMPLE USE CASE
List<ValueItem> caregiverHealthServiceItems =
    careGiverHealthServices.map((service) {
  return ValueItem(label: "- ${service['subtitle']}", value: service['title']);
}).toList();

// CustomMultiSelectDropDown(
//   
//   hint: 'Services(s)',
//   onOptionSelected: (selectedServices) {
//   // Handle selected services
//   },
//   options: caregiverHealthServiceItems,
//   maxItems: 13,
//   disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
//   selectionType: SelectionType.multi,
//   chipConfig: const ChipConfig(wrapType: WrapType.wrap),
//   dropdownHeight: 300,
//   optionTextStyle: const TextStyle(fontSize: 16),
//   selectedOptionIcon: const Icon(Icons.check_circle),
//   borderRadius: BorderRadius.circular(5), // Set the desired border radius value
// )



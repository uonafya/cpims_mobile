import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class CustomDropDownMultiSelect extends StatefulWidget {
  final List<ValueItem> options;
  final Function(List<String>) onOptionSelected;
  final SelectionType selectionType;
  final String hint;

  const CustomDropDownMultiSelect({
    Key? key,
    required this.options,
    required this.onOptionSelected,
    required this.selectionType,
    required this.hint,
  }) : super(key: key);

  @override
  State<CustomDropDownMultiSelect> createState() =>
      _CustomDropDownMultiSelectState();
}

class _CustomDropDownMultiSelectState extends State<CustomDropDownMultiSelect> {
  List<String> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
      hint: widget.hint,
      onOptionSelected: (selectedValues) {
        setState(() {
          this.selectedValues = selectedValues.cast<String>().toList();
        });
        widget.onOptionSelected(selectedValues.cast<String>().toList());
      },
      options: widget.options,
      maxItems: 35,
      selectionType: widget.selectionType,
      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
      dropdownHeight: 300,
      optionTextStyle: const TextStyle(fontSize: 16),
      selectedOptionIcon: const Icon(Icons.check_circle),
      borderRadius: BorderRadius.circular(5.w).topLeft.x,
    );
  }
}

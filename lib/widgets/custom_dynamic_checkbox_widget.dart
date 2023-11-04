import 'package:flutter/material.dart';

class CustomDynamicCheckBox extends StatefulWidget {
  final List<String> options;
  final Set<String> selectedOptions;
  final Function(Set<String>) optionsSelected;

  const CustomDynamicCheckBox({
    Key? key,
    required this.options,
    required this.selectedOptions,
    required this.optionsSelected,
  }) : super(key: key);

  @override
  State<CustomDynamicCheckBox> createState() => _CustomDynamicCheckBoxState();
}

class _CustomDynamicCheckBoxState extends State<CustomDynamicCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: widget.options.map((option) {
        return CheckboxListTile(
          title: Text(option),
          value: widget.selectedOptions.contains(option),
          onChanged: (value) {
            _handleCheckboxChange(option, value ?? false);
          },
          controlAffinity: ListTileControlAffinity.leading, // Place checkbox before the title
        );
      }).toList(),
    );
  }

  void _handleCheckboxChange(String option, bool value) {
    Set<String> updatedOptions = widget.selectedOptions.toSet();
    if (value) {
      updatedOptions.add(option);
    } else {
      updatedOptions.remove(option);
    }
    widget.optionsSelected(updatedOptions);
  }
}

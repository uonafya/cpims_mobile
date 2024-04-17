import 'package:flutter/material.dart';

class CustomDynamicRadioButton extends StatefulWidget {
  final bool isNaAvailable;
  final String? option;
  final Function(String?) optionSelected;
  final List<String> customOptions;

  const CustomDynamicRadioButton({
    super.key,
    required this.isNaAvailable,
    required this.optionSelected,
    this.option,
    required this.customOptions,
  });

  @override
  State<CustomDynamicRadioButton> createState() =>
      _CustomDynamicRadioButtonState();
}

class _CustomDynamicRadioButtonState extends State<CustomDynamicRadioButton> {
  String? _option;

  @override
  void initState() {
    _option = widget.option;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: widget.customOptions.map((customOption) {
          return RadioListTile<String>(
            title: Text(customOption),
            value: customOption,
            groupValue: _option,
            onChanged: (value) {
              _handleRadioChange(value);
            },
          );
        }).toList());
  }

  void _handleRadioChange(String? value) {
    setState(() {
      _option = value;
      widget.optionSelected(_option);
    });
  }
}

class CustomDynamicRadioButtonNew extends StatefulWidget {
  final bool isNaAvailable;
  final String? option;
  final Function(String?) optionSelected;
  final List<String> customOptions;
  final List<String>? valueOptions;

  const CustomDynamicRadioButtonNew({
    super.key,
    required this.isNaAvailable,
    required this.optionSelected,
    this.option,
    required this.customOptions,
    this.valueOptions,
  });

  @override
  State<CustomDynamicRadioButtonNew> createState() =>
      _CustomDynamicRadioButtonNewState();
}

class _CustomDynamicRadioButtonNewState
    extends State<CustomDynamicRadioButtonNew> {
  String? _option;

  @override
  void initState() {
    _option = widget.option;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.customOptions.length, (index) {
        final option = widget.customOptions[index];
        final value =
            widget.valueOptions != null ? widget.valueOptions![index] : option;

        return RadioListTile<String>(
          title: Text(option),
          value: value,
          groupValue: _option,
          onChanged: (newValue) {
            _handleRadioChange(newValue);
          },
        );
      }),
    );
  }

  void _handleRadioChange(String? value) {
    setState(() {
      _option = value;
      widget.optionSelected(value);
    });
  }
}

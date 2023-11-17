import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  final bool isNaAvailable;
  final RadioButtonOptions? option;
  final Function(RadioButtonOptions?) optionSelected;
  final bool readOnly; // Add a new property for read-only
  const CustomRadioButton({
    super.key,
    required this.isNaAvailable,
    required this.optionSelected,
    this.option,
    this.readOnly = false, // Default value is false
  });

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  RadioButtonOptions? _option;

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
      children: [
        RadioListTile<RadioButtonOptions>(
          title: const Text('Yes'),
          value: RadioButtonOptions.yes,
          groupValue: _option,
          onChanged: widget.readOnly
              ? null // If read-only, onChanged is set to null to disable the radio button
              : (value) {
            setState(() {
              _option = value;
              widget.optionSelected(_option);
            });
          },
        ),
        RadioListTile<RadioButtonOptions>(
          title: const Text('No'),
          value: RadioButtonOptions.no,
          groupValue: _option,
          onChanged: widget.readOnly
              ? null
              : (value) {
            setState(() {
              _option = value;
              widget.optionSelected(_option);
            });
          },
        ),
        widget.isNaAvailable
            ? RadioListTile<RadioButtonOptions>(
          title: const Text('N/A'),
          value: RadioButtonOptions.na,
          groupValue: _option,
          onChanged: widget.readOnly
              ? null
              : (value) {
            setState(() {
              _option = value;
              widget.optionSelected(_option);
            });
          },
        )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class CustomRadioButtonOverall extends StatelessWidget {
  final RadioButtonOptions? option;
  const CustomRadioButtonOverall({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RadioListTile<RadioButtonOptions>(
          title: const Text('Yes'),
          value: RadioButtonOptions.yes,
          groupValue: option,
          onChanged: null,
        ),
        RadioListTile<RadioButtonOptions>(
          title: const Text('No'),
          value: RadioButtonOptions.no,
          groupValue: option,
          onChanged: null,
        ),
      ],
    );
  }
}



enum RadioButtonOptions { yes, no, na }


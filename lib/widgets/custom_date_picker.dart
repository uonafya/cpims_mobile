import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker(
      {super.key,
      this.firstDate,
      this.lastDate,
      this.initialDate,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.labelText});
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  TextEditingController pickedDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: widget.initialDate ?? DateTime.now(),
          firstDate: widget.firstDate ?? DateTime.now(),
          lastDate: widget.lastDate ?? DateTime(2100, 12, 31, 11, 59),
        ).then((value) => setState(() {
              pickedDate = TextEditingController(
                  text: DateFormat('dd/MM/yyyy').format(value!));
            }));
      },
      child: CustomTextField(
        enabled: false,
        suffixIcon: widget.suffixIcon ?? Icons.calendar_today,
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        controller: pickedDate,
        onChanged: (val) {},
      ),
    );
  }
}

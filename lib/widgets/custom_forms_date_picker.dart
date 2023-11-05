import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomFormsDatePicker extends StatefulWidget {
  const CustomFormsDatePicker({
    Key? key,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.selectedDateTime,
    this.allowPastDates = true,  // Add the flag for allowing past dates
    this.allowFutureDates = true,  // Add the flag for allowing future dates
    required this.onDateSelected, // Add the callback here
  }) : super(key: key);

  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final DateTime? selectedDateTime;
  final bool allowPastDates;  // Add the flag for allowing past dates
  final bool allowFutureDates;  // Add the flag for allowing future dates
  final Function(DateTime selectedDate)
      onDateSelected; // Define the callback function signature

  @override
  State<CustomFormsDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomFormsDatePicker> {
  DateTime selectedDate = DateTime.now(); // Track the selected date

  @override
  void initState() {
    selectedDate = widget.selectedDateTime ?? selectedDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = selectedDate;
    return GestureDetector(
      onTap: () {

        DateTime firstDate = widget.firstDate ?? DateTime(2012, 1, 1, 11, 59);
        DateTime lastDate = widget.lastDate ?? DateTime(2100, 12, 31, 11, 59);

        if (!widget.allowPastDates && currentDate.isBefore(DateTime.now())) {
          // If past dates are not allowed, set the firstDate to the current date
          firstDate = DateTime.now();
        }

        if (!widget.allowFutureDates && currentDate.isAfter(DateTime.now())) {
          // If future dates are not allowed, set the lastDate to the current date
          lastDate = DateTime.now();
        }

        showDatePicker(
          currentDate: selectedDate,
          context: context,
          initialDate: widget.initialDate ?? DateTime.now(),
          firstDate: widget.allowPastDates
              ? widget.firstDate ?? DateTime(2012, 1, 1, 11, 59)
              : DateTime.now(),
          lastDate: widget.allowFutureDates
              ? widget.lastDate ?? DateTime(2100, 12, 31, 11, 59)
              : DateTime.now(),
        ).then((value) {
          if (value != null) {
            setState(() {
              selectedDate = value;
            });
            widget.onDateSelected(
                selectedDate); // Call the callback with selectedDate
          }
        });
      },
      child: CustomTextField(
        enabled: false,
        suffixIcon: widget.suffixIcon ?? Icons.calendar_today,
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        controller: TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(selectedDate),
        ),
        onChanged: (val) {},
      ),
    );
  }
}
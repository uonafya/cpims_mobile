import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String initialValue;
  final List<String> items;
  final Function(String) onChanged;

  const CustomDropdown(
      {super.key,
      required this.initialValue,
      required this.items,
      required this.onChanged});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: widget.initialValue,
          style: const TextStyle(fontSize: 14, color: Colors.black),
          icon: const Icon(Icons.keyboard_arrow_down),
          items: widget.items.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              widget.onChanged(newValue!);
            });
          },
        ),
      ),
    );
  }
}

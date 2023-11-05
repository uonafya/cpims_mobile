// ignore_for_file: must_be_immutable

import 'package:cpims_mobile/constants.dart';
import 'package:flutter/material.dart';

class CustomStepperWidget extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final Function(int index) onTap;
  int selectedIndex;

  CustomStepperWidget(
      {super.key,
      required this.data,
      required this.onTap,
      required this.selectedIndex});

  @override
  State<CustomStepperWidget> createState() => _CustomStepperWidgetState();
}

class _CustomStepperWidgetState extends State<CustomStepperWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: List.generate(
          widget.data.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                widget.selectedIndex = index;
                widget.onTap(index);
              });
            },
            child: stepper(
              widget.data[index]['title'],
              index,
              widget.data[index]['subtitle'],
              index == widget.selectedIndex,
            ),
          ),
        ),
      ),
    );
  }

  Widget stepper(
    String title,
    int index,
    String subtitle,
    bool isSelected,
  ) {
    return Container(
      color: isSelected ? kPrimaryColor : Colors.transparent,
      child: ListTile(
        leading: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: isSelected ? Colors.green[900] : Colors.grey,
                shape: BoxShape.circle),
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
        minLeadingWidth: 30,
        title: Text(
          title,
          style: TextStyle(color: isSelected ? Colors.white : null),
        ),
        subtitle: subtitle.isEmpty
            ? null
            : Text(
                subtitle,
                style: TextStyle(
                    color: isSelected ? Colors.white60 : kTextGrey,
                    fontSize: 12),
              ),
      ),
    );
  }
}

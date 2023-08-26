import 'package:cpims_mobile/constants.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip(
      {super.key,
      required this.title,
      this.onTap,
      this.color,
      this.isSelected = false});
  final String title;
  final Function? onTap;
  final Color? color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color ?? kPrimaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isSelected
                ? color ?? kPrimaryColor
                : Colors.grey.withOpacity(0.5),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

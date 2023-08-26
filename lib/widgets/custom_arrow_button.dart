import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

enum ArrowDirection {
  forward,
  backward,
}

class CustomArrowButton extends StatelessWidget {
  const CustomArrowButton({
    Key? key,
    required this.text,
    this.onTap,
    this.borderColor = kPrimaryColor,
    this.arrowDirection = ArrowDirection.forward,
    required Color color,
  }) : super(key: key);

  final String text;
  final Function? onTap;
  final Color borderColor;
  final ArrowDirection arrowDirection;

  @override
  Widget build(BuildContext context) {
    Widget arrowIcon = const Icon(Icons.arrow_forward); // Default forward arrow
    if (arrowDirection == ArrowDirection.backward) {
      arrowIcon = const Icon(Icons.arrow_back); // Change to backward arrow
    }

    return Material(
      borderRadius: BorderRadius.circular(5.w),
      clipBehavior: Clip.hardEdge, // Clip the content to the button's borders
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        child: Container(
          height: 49.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: 2.0, // Border width
            ),
            borderRadius: BorderRadius.circular(5.w),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (arrowDirection == ArrowDirection.backward) arrowIcon,
                const SizedBox(width: 8.0), // Add spacing between arrow and text
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: borderColor, // Set text color to match border
                  ),
                ),
                const SizedBox(width: 8.0), // Add spacing between text and arrow
                if (arrowDirection == ArrowDirection.forward) arrowIcon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

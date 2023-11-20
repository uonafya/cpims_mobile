import 'package:flutter/material.dart';

class FormSection extends StatelessWidget {
  const FormSection({
    super.key,
    this.isDisabled = false,
    this.isVisibleCondition, // Make it optional
    required this.children,
  });

  final bool isDisabled;
  final Function? isVisibleCondition; // Make it nullable
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (isVisibleCondition != null && !isVisibleCondition!()) {
      return Container(); // Return an empty container if not visible
    }

    return AbsorbPointer(
      absorbing: isDisabled,
      child: Container(
        padding: isDisabled
            ? const EdgeInsets.symmetric(horizontal: 10, vertical: 10)
            : null,
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey[100] : Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}


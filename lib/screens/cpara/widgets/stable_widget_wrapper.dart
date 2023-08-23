import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StableWidgetWrapper extends StatelessWidget {
  final List<Widget> children;

  const StableWidgetWrapper({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

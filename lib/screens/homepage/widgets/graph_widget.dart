import 'package:flutter/material.dart';

class GraphWidget extends StatelessWidget {
  const GraphWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 5,
        ),
      ]),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          color: Colors.black,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Container(
          height: 200,
        )
      ]),
    );
  }
}

import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const CustomCard({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            color: Colors.black,
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 7.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  List.generate(children.length, (index) => children[index]),
            ),
          ),
        ]));
  }
}

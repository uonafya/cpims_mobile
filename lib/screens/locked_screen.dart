import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LockedScreen extends StatefulWidget {
  const LockedScreen({super.key});

  @override
  State<LockedScreen> createState() => _LockedScreenState();
}

class _LockedScreenState extends State<LockedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(),
            Lottie.asset(
                'assets/lock.json',
                repeat: false,
                width: 200,
                height: 200,
            ),
            const Text(
              'Unauthorized',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              'You are unauthorized to use this app.',
              style: TextStyle(color: Colors.grey),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

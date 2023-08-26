import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

class BiometricInformation extends StatefulWidget {
  const BiometricInformation({super.key, required this.redirectScreen});
  final Widget redirectScreen;

  @override
  State<BiometricInformation> createState() => _BiometricInformationState();
}

class _BiometricInformationState extends State<BiometricInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Lottie.asset('assets/fingerprint.json',
              repeat: false, height: 400, fit: BoxFit.fitHeight),
          const Text(
            'Biometric authentication not set up',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Please set up biometric authentication to continue',
            style: TextStyle(color: Colors.grey),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: CustomButton(
              text: 'Try again',
              onTap: () async {
                Get.off(() => widget.redirectScreen);
              },
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

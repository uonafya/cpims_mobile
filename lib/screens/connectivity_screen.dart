import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/connection_provider.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ConnectivityScreen extends StatefulWidget {
  const ConnectivityScreen({super.key, required this.redirectScreen});
  final Widget redirectScreen;

  @override
  State<ConnectivityScreen> createState() => _ConnectivityScreenState();
}

class _ConnectivityScreenState extends State<ConnectivityScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Lottie.asset('assets/connection.json', repeat: false),
          const Text(
            'No internet connection',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Please connect to the internet to continue ',
            style: TextStyle(color: Colors.grey),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: CustomButton(
              isLoading: isLoading,
              text: 'Try again',
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                final hasConnection = await Provider.of<ConnectivityProvider>(
                        context,
                        listen: false)
                    .checkInternetConnection();
                setState(() {
                  isLoading = false;
                });
                if (hasConnection) {
                  Get.off(() => widget.redirectScreen);
                } else {
                  if (mounted) {
                    errorSnackBar(context, 'Please connect to the internet');
                  }
                }
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

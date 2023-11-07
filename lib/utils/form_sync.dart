import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/form_service.dart';

class FormSyncUtil{
  Future<void> submitFormOneA(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access');
    // You should replace the following line with the actual logic to get data for formOneA
    final List<dynamic> forms = await Form1Service.getAllForms('form1a');

    for (var formData in forms) {
      final response = await Form1Service.postFormRemote(
        formData,
        'F1A/',
        accessToken!,
      );
      if (response.statusCode == 200) {
        debugPrint("Successfully submitted formOneA");
      } else {
        debugPrint("Failed to submit formOneA and error is ${response.data}");
        // Handle the error if needed
      }
    }
  }

  Future<void> submitFormOneB(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access');
    final List<dynamic> forms = await Form1Service.getAllForms('form1b');

    for (var formData in forms) {
      final response = await Form1Service.postFormRemote(
        formData,
        'F1B/',
        accessToken!,
      );
      if (response.statusCode == 200) {
        debugPrint("Data of form one b posted to server is $formData");
        if (context.mounted) {
          showSyncSnackbar(context, "Success syncing");
        }
      } else {
        if (context.mounted) {
          showSyncSnackbar(context, "Form Sync Failed");
        }
      }
    }
  }

  void showSyncSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
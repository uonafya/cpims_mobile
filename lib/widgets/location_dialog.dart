import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';


Future<void> locationMissingDialog(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Turn on Location Services.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Please turn on location settings to be able to use the app',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  AppSettings.openAppSettings(
                    type: AppSettingsType.location,
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


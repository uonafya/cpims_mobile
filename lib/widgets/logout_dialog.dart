import 'package:cpims_mobile/constants.dart';
import 'package:flutter/material.dart';

class LogOutDialog extends StatefulWidget {
  final Future Function() onLogout;
  final Future Function() onDeleteDb;

  const LogOutDialog(
      {super.key, required this.onLogout, required this.onDeleteDb});

  @override
  State<LogOutDialog> createState() => _LogOutDialogState();
}

class _LogOutDialogState extends State<LogOutDialog> {
  bool _saveCredentials = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Log out?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Text(
              'Do you want to save your credentials for easier access next time?',
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: _saveCredentials,
                onChanged: (value) =>
                    setState(() => _saveCredentials = value ?? false),
              ),
              const Text('Save'),
            ],
          ),
          const Divider(
            height: 1,
          ),
          TextButton(
            child: const Text('Confirm'),
            onPressed: () async {
              Navigator.of(context).pop();
              if (_saveCredentials) {
                await widget.onLogout();
              } else {
                await widget.onDeleteDb();
                await widget.onLogout();
              }
            },
          ),
          const Divider(
            height: 1,
          ),
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

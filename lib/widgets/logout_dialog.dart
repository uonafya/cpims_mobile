import 'package:flutter/material.dart';

class LogOutDialog extends StatefulWidget {
  final Future Function() onLogout;
  final Future Function() onDeleteDb;

  const LogOutDialog({super.key, required this.onLogout, required this.onDeleteDb});

  @override
  State<LogOutDialog> createState() => _LogOutDialogState();
}

class _LogOutDialogState extends State<LogOutDialog> {
  bool _saveCredentials = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Log out'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
              'Do you want to save your credentials for easier access next time?'),
          Checkbox(
            value: _saveCredentials,
            onChanged: (value) =>
                setState(() => _saveCredentials = value ?? false),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
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
      ],
    );
  }
}
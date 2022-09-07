import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class AllNotificationsScreen extends StatelessWidget {
  const AllNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Notifications'),
      ),
    );
  }
}

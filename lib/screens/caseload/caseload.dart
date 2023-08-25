
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';

class CaseLoad extends StatefulWidget {
  const CaseLoad({Key? key}) : super(key: key);

  @override
  State<CaseLoad> createState() => _CaseLoadState();
}

class _CaseLoadState extends State<CaseLoad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
    );
  }
}

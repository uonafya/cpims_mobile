import 'dart:convert';

import 'package:cpims_mobile/Models/case_load.dart';
import 'package:cpims_mobile/services/api_service.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaseLoad extends StatefulWidget {
  const CaseLoad({Key? key}) : super(key: key);

  @override
  State<CaseLoad> createState() => _CaseLoadState();
}

class _CaseLoadState extends State<CaseLoad> {
  var case_load = <CaseLoadModel>[];

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      _caseLoad();
      print("caseload api list");
      debugPrint(case_load.toString());
    });

    super.initState();
  }

  _caseLoad() async {
    final prefs = await SharedPreferences.getInstance();
    final access = prefs.getString('access');
    await ApiService().getSecureData('caseload', access).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);

        case_load = list.map((model) => CaseLoadModel.fromJson(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: ListView.builder(
          itemCount: case_load.length,
          itemBuilder: (BuildContext context, int index) {
            return Text("${case_load[index].cpimsId} ${case_load[index].name}");
          }),
    );
  }
}

import 'dart:convert';

import 'package:cpims_mobile/Models/case_load.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/services/api_service.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaseLoad extends StatefulWidget {
  const CaseLoad({Key? key}) : super(key: key);

  @override
  State<CaseLoad> createState() => _CaseLoadState();
}

class _CaseLoadState extends State<CaseLoad> {
  var case_load = <CaseLoadModel>[];

  @override
  void initState() {
    print("caseload >>>>>>>>>>> state");
    print("get access token ..............");
    debugPrint(context.read<UIProvider>().getAccess.toString());

    Future.delayed(Duration(seconds: 5), () {
      _caseLoad();
      print("caseload api list");
      debugPrint(case_load.toString());
    });

    super.initState();
  }

  _caseLoad() async {
    await ApiService()
        .getSecureData(
            'caseload', context.read<UIProvider>().getAccess["access"])
        .then((response) {
      print("***************RESPONSE************");
      // debugPrint(response.body.data.toString());

      setState(() {
        Iterable list = json.decode(response.body);

        case_load = list.map((model) => CaseLoadModel.fromJson(model)).toList();
        print("************ case load  ****************88");
        debugPrint("************ ${case_load.toString()}");
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
            return Text(case_load[index].cpimsId.toString() +
                " " +
                case_load[index].name.toString());
          }),
    );
  }
}

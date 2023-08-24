import 'package:cpims_mobile/providers/db_provider.dart';

import 'package:cpims_mobile/services/caseload_service.dart';
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
  void initState() {
    getData();
    super.initState();
  }

  final CaseLoadService caseLoadService = CaseLoadService();

  void getData() async {
    await caseLoadService.fetchCaseLoadData(
        context: context, isForceSync: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: FutureBuilder(
        future: LocalDb.instance.retrieveCaseLoads(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No caseload data');
          }
          final caseLoadData = snapshot.data;
          return ListView.builder(
            itemCount: caseLoadData!.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                  "${caseLoadData[index].cpimsId} ${caseLoadData[index].ovc_first_name}");
            },
          );
        },
      ),
    );
  }
}

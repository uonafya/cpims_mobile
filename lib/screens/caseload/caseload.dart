import 'dart:convert';

import 'package:cpims_mobile/Models/case_load.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';

import 'package:cpims_mobile/services/api_service.dart';
import 'package:cpims_mobile/services/caseload_service.dart';
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
  @override
  void initState() {
    getData();
    super.initState();
  }

  final CaseLoadService caseLoadService = CaseLoadService();

  void getData() async {
    await CaseLoadDb.instance.retrieveCaseLoads();
    // await caseLoadService.fetchCaseLoadData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: FutureBuilder(
        future: CaseLoadDb.instance.retrieveCaseLoads(),
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
              return  Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Cpims Id:  ${caseLoadData[index].cpimsId}  "),
                         Text(
                        "First Name:  ${caseLoadData[index].ovc_first_name}"),
                         Text(
                        "Last Name: ${caseLoadData[index].ovc_surname}"),
                         Text(
                        "Caregiver names: ${caseLoadData[index].caregiver_names}"),
                         Text(
                        "Date Of Birth:  ${caseLoadData[index].date_of_birth}"),
                         Text(
                        "Registration Date: ${caseLoadData[index].registration_date}"),
                         Text(
                        "Sex:  ${caseLoadData[index].sex}"),
                        
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:cpims_mobile/Models/case_load.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';

class OVCDetailsScreen extends StatelessWidget {
  const OVCDetailsScreen({super.key, required this.caseLoadModel});
  final CaseLoadModel caseLoadModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(),
        drawer: const Drawer(
          child: CustomDrawer(),
        ),
        body: ListView(padding: kSystemPadding, children: [
          const SizedBox(height: 20),
          const Text('OVC Details',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          Text(
            'CPIMIS ID: ${caseLoadModel.cpimsId}',
            style: const TextStyle(color: kTextGrey),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomCard(
              title:
                  '${caseLoadModel.ovc_first_name} ${caseLoadModel.ovc_surname}',
              children: [])
        ]));
  }
}

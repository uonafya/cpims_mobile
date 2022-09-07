import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/organisation_units.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_dropdown.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';

class CaseLoadReport extends StatefulWidget {
  const CaseLoadReport({super.key});

  @override
  State<CaseLoadReport> createState() => _CaseLoadReportState();
}

class _CaseLoadReportState extends State<CaseLoadReport> {
  List<String> regions = [
    'National',
    'County',
    'Sub-County',
    'Organisation Unit',
  ];
  List<String> reportingPeriods = [
    'Select Type',
    'Monthly',
    'Quartely',
    'Yearly',
  ];
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  String selectedMonth = 'January';
  String selectedReportingPeriod = 'Select Type';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: Padding(
        padding: kSystemPadding,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 30,
          ),
          CustomCard(title: 'Report details and parameters', children: [
            const Text(
              'Report Region:',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 80,
              child: GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: 2,
                mainAxisSpacing: 0.0,
                shrinkWrap: true,
                childAspectRatio: 5,
                children: List.generate(
                    regions.length,
                    (index) => CustomRadioTile(
                          title: regions[index],
                        )),
              ),
            ),
            const Text(
              'Reporting Period',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            CustomDropdown(
                initialValue: selectedReportingPeriod,
                items: reportingPeriods,
                onChanged: (value) {
                  setState(() {
                    selectedReportingPeriod = value;
                  });
                }),
            const SizedBox(
              height: 15,
            ),
            CustomDropdown(
                initialValue:
                    selectedReportingPeriod == selectedReportingPeriod[0]
                        ? ''
                        : selectedReportingPeriod == selectedReportingPeriod[1]
                            ? selectedMonth
                            : '',
                items: selectedReportingPeriod == selectedReportingPeriod[0]
                    ? ['']
                    : selectedReportingPeriod == selectedReportingPeriod[1]
                        ? months
                        : [''],
                onChanged: (value) {
                  setState(() {
                    selectedMonth = value;
                  });
                }),
          ]),
        ]),
      ),
    );
  }
}

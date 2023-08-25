
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/services/unapproved_data.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_chip.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UnapprovedRecordsScreens extends StatefulWidget {
  const UnapprovedRecordsScreens({super.key});

  @override
  State<UnapprovedRecordsScreens> createState() =>
      _UnapprovedRecordsScreensState();
}

class _UnapprovedRecordsScreensState extends State<UnapprovedRecordsScreens> {
  List<String> unapprovedRecords = [
    'Form 1A',
    'Form 1B',
    'CPARA',
    'CPA',
  ];

  @override
  void initState() {
    super.initState();
    getRecords();
  }

  void getRecords() async {
    final prefs = await SharedPreferences.getInstance();

    final accessToken = prefs.getString('access');

    await UnapprovedDataService.fetchUnnaprovedData(accessToken);
  }

  String selectedRecord = 'Form 1A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) => CustomChip(
                  title: unapprovedRecords[index],
                  isSelected: selectedRecord == unapprovedRecords[index],
                  onTap: () {
                    setState(() {
                      selectedRecord = unapprovedRecords[index];
                    });
                  },
                ),
                itemCount: unapprovedRecords.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  width: 12,
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomCard(
              title: 'Form 1A Events List',
              children: [
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(2),
                  },
                  border: TableBorder.symmetric(
                    inside: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  children: [
                    const TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Event Type',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 10.0,
                          ),
                          child: Text(
                            'Details',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...unapprovedItems
                        .map(
                          (e) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: Text(e['eventType']),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(e['details']),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

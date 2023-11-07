import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/services/unapproved_data_service.dart';
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
    'CPT',
    'CPARA',
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      getRecords();
    });
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
            if (selectedRecord == 'CPARA')
              Column(
                children: [
                  for (var item in unapprovedItems)
                    if (item['title'] == 'CPARA')
                      ChildDetailsCard(
                        item,
                      ),
                ],
              ),
            if (selectedRecord != 'CPARA')
              DefaultTabController(
                length: 2,
                child: Expanded(
                  child: Column(
                    children: [
                      const TabBar(
                        tabs: [
                          Tab(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('SERVICES'),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('CRITICAL EVENTS'),
                            ),
                          ),
                        ],
                        indicatorColor: kPrimaryColor,
                        labelColor: Colors.black,
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: TabBarView(
                          children: [
                            FormTab(
                              selectedRecord: selectedRecord,
                              eventType: 'SERVICES',
                            ),
                            FormTab(
                              selectedRecord: selectedRecord,
                              eventType: 'CRITICAL EVENTS',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class FormTab extends StatelessWidget {
  final String selectedRecord;
  final String eventType;

  const FormTab({
    super.key,
    required this.selectedRecord,
    required this.eventType,
  });

  @override
  Widget build(BuildContext context) {
    final selectedItems = unapprovedItems
        .where((item) =>
            item['title'] == selectedRecord && item['eventType'] == eventType)
        .toList();

    return CustomCard(
      title: '$selectedRecord $eventType List',
      children: [
        if (selectedRecord == "CPARA")
          Column(
            children: selectedItems.map((e) => ChildDetailsCard(e)).toList(),
          )
        else
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(1),
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
                      'Child ID',
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 10.0,
                    ),
                    child: Text(
                      'Date',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              ...selectedItems
                  .map(
                    (e) => TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: Text(e['childID']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e['details']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e['date']),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ],
          ),
      ],
    );
  }
}

class ChildDetailsCard extends StatelessWidget {
  final Map<String, dynamic> cargiverData;

  const ChildDetailsCard(this.cargiverData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${cargiverData['caregiverName']}",
                ),
                Text(
                  "Caregiver ID: ${cargiverData['caregiverID']}",
                ),
                Text(
                  "${cargiverData['date']}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

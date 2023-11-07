import 'package:cpims_mobile/Models/unapproved_form_1_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/services/unapproved_data_service.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_chip.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';

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

  List<UnapprovedForm1DataModel> unapprovedForm1Data = [];

  void getRecords() async {
    final List<UnapprovedForm1DataModel> records =
    await UnapprovedDataService.fetchLocalUnapprovedForm1AData();
    setState(() {
      unapprovedForm1Data = records;
    });
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
                      const ChildDetailsCard(
                        cargiverData: {},
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
                              unapprovedForm1aData: unapprovedForm1Data,
                            ),
                            FormTab(
                              selectedRecord: selectedRecord,
                              eventType: 'CRITICAL EVENTS',
                              unapprovedForm1aData: unapprovedForm1Data,
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
  final List<UnapprovedForm1DataModel> unapprovedForm1aData;

  const FormTab({
    super.key,
    required this.selectedRecord,
    required this.eventType,
    required this.unapprovedForm1aData,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: '$selectedRecord $eventType List',
      children: [
        if (selectedRecord == "Form 1A" || selectedRecord == "Form 1B")
          for (final dataModel in unapprovedForm1aData)
            if (dataModel.services.isNotEmpty && eventType == "SERVICES")
              CustomForm1ACardDetail(
                unapprovedData: dataModel,
                eventOrDomainId: dataModel.services[0].domainId,
                isService: true,
              )
            else if (dataModel.criticalEvents.isNotEmpty &&
                eventType == 'CRITICAL EVENTS')
              CustomForm1ACardDetail(
                unapprovedData: dataModel,
                eventOrDomainId: dataModel.criticalEvents[0].event_id,
                isService: false,
              )
            // Column(
            //   children: unapprovedForm1aData
            //       .map((e) => CustomForm1ACardDetail(
            //             unapprovedData: e,
            //           ))
            //       .toList(),
            // )
            else if (selectedRecord == "CPT")
                const Column(
                  children: [
                    Text(
                      'Not Implemented',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                )
              else
                const Column(children: [
                  Text(
                    'Not Implemented',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ])
        // if (selectedRecord == "CPARA")
        //   Column(
        //     children: selectedItems.map((e) => ChildDetailsCard(e)).toList(),
        //   )
        // else
        //   Table(
        //     columnWidths: const {
        //       0: FlexColumnWidth(1),
        //       1: FlexColumnWidth(2),
        //       2: FlexColumnWidth(1),
        //     },
        //     border: TableBorder.symmetric(
        //       inside: BorderSide(
        //         color: Colors.grey.withOpacity(0.5),
        //       ),
        //     ),
        //     children: [
        //       const TableRow(
        //         children: [
        //           Padding(
        //             padding: EdgeInsets.symmetric(vertical: 8.0),
        //             child: Text(
        //               'Child ID',
        //               textAlign: TextAlign.start,
        //               style: TextStyle(
        //                 fontWeight: FontWeight.w600,
        //                 fontSize: 16,
        //               ),
        //             ),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.symmetric(
        //               vertical: 8.0,
        //               horizontal: 10.0,
        //             ),
        //             child: Text(
        //               'Details',
        //               textAlign: TextAlign.start,
        //               style: TextStyle(
        //                 fontWeight: FontWeight.w600,
        //                 fontSize: 16,
        //               ),
        //             ),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.symmetric(
        //               vertical: 8.0,
        //               horizontal: 10.0,
        //             ),
        //             child: Text(
        //               'Date',
        //               textAlign: TextAlign.start,
        //               style: TextStyle(
        //                 fontWeight: FontWeight.w600,
        //                 fontSize: 16,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //       ...selectedItems
        //           .map(
        //             (e) => TableRow(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(
        //                     vertical: 8.0,
        //                   ),
        //                   child: Text(e['childID']),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Text(e['details']),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Text(e['date']),
        //                 ),
        //               ],
        //             ),
        //           )
        //           .toList(),
        //     ],
        //   ),
      ],
    );
  }
}

class ChildDetailsCard extends StatelessWidget {
  final Map<String, dynamic> cargiverData;

  const ChildDetailsCard({super.key, required this.cargiverData});

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

class CustomForm1ACardDetail extends StatelessWidget {
  // list with a type of unapproved form 1A data model
  final UnapprovedForm1DataModel unapprovedData;
  final String eventOrDomainId;
  final bool isService;

  const CustomForm1ACardDetail({
    super.key,
    required this.unapprovedData,
    required this.eventOrDomainId,
    required this.isService,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const Text(
                  "CPIMS ID: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  unapprovedData.ovcCpimsId,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  isService ? "Domain ID: " : "Event ID: ",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  eventOrDomainId,
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Date of Event: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  unapprovedData.date_of_event,
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Message: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  unapprovedData.message,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
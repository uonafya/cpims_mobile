import 'package:cpims_mobile/Models/unapproved_form_1_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/services/unapproved_data_service.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_chip.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';

import '../../Models/unapproved_caseplan_form_model.dart';

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
  List<UnapprovedCasePlanModel> unapprovedCaseplanData = [];

  void getRecords() async {
    final List<UnapprovedForm1DataModel> records =
        await UnapprovedDataService.fetchLocalUnapprovedForm1AData();
    final List<UnapprovedCasePlanModel> unapprovedCaseplanRecords =
        await UnapprovedDataService.fetchLocalUnapprovedCasePlanData();
    print(unapprovedCaseplanRecords);
    setState(() {
      unapprovedForm1Data = records;
      unapprovedCaseplanData = unapprovedCaseplanRecords;
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
            if (selectedRecord == 'CPT')
              Column(
                children: [
                  ChildDetailsCard(
                    unapprovedRecords: unapprovedCaseplanData,
                    selectedRecord: selectedRecord,
                  ),
                ],
              ),
            if (selectedRecord == "CPARA")
              const Column(
                children: [Text('Hello')],
              ),
            if (selectedRecord != 'CPARA' && selectedRecord != 'CPT')
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
                              unapprovedCPTData: unapprovedCaseplanData,
                            ),
                            FormTab(
                              selectedRecord: selectedRecord,
                              eventType: 'CRITICAL EVENTS',
                              unapprovedForm1aData: unapprovedForm1Data,
                              unapprovedCPTData: unapprovedCaseplanData,
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
  final List? unapprovedForm1aData;
  final List? unapprovedCPTData;

  const FormTab({
    super.key,
    required this.selectedRecord,
    required this.eventType,
    this.unapprovedForm1aData,
    this.unapprovedCPTData,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        CustomCard(
          title: '$selectedRecord $eventType List',
          children: [
            if (selectedRecord == "Form 1A" || selectedRecord == "Form 1B")
              ...List.generate(
                (unapprovedForm1aData as dynamic).length,
                (index) {
                  final UnapprovedForm1DataModel dataModel =
                      unapprovedForm1aData![index];
                  return dataModel.services.isNotEmpty &&
                          eventType == 'SERVICES'
                      ? CustomForm1ACardDetail<UnapprovedForm1DataModel>(
                          unapprovedData: dataModel,
                          eventOrDomainId: dataModel.services[0].domainId,
                          isService: true,
                        )
                      : dataModel.criticalEvents.isNotEmpty &&
                              eventType == 'CRITICAL EVENTS'
                          ? CustomForm1ACardDetail<UnapprovedForm1DataModel>(
                              unapprovedData: dataModel,
                              eventOrDomainId:
                                  dataModel.criticalEvents[0].eventId,
                              isService: false,
                            )
                          : const Column(
                              children: [
                                Text(
                                  'Not Implemented',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            );
                },
              )
            else if (selectedRecord == "CPT")
              for (final cptdataModel in unapprovedCPTData!)
                if (cptdataModel.services.isNotEmpty && eventType == "SERVICES")
                  CustomForm1ACardDetail<UnapprovedCasePlanModel>(
                    unapprovedData: cptdataModel,
                    eventOrDomainId: cptdataModel.services[0].domainId,
                    isService: true,
                  )
                else if (cptdataModel.criticalEvents.isNotEmpty &&
                    eventType == 'CRITICAL EVENTS')
                  CustomForm1ACardDetail<UnapprovedCasePlanModel>(
                    unapprovedData: cptdataModel,
                    eventOrDomainId: cptdataModel.services[0].domainId,
                    isService: true,
                  )
          ],
        ),
      ],
    );
  }
}

class ChildDetailsCard<T> extends StatelessWidget {
  final T unapprovedRecords;
  final String selectedRecord;

  const ChildDetailsCard({
    super.key,
    required this.unapprovedRecords,
    required this.selectedRecord,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'Unapproved $selectedRecord Forms',
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListView.builder(
                itemCount: (unapprovedRecords as dynamic).length,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, index) {
                  final UnapprovedCasePlanModel unapprovedRecord =
                      (unapprovedRecords as dynamic)[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            (unapprovedRecord as dynamic).ovcCpimsId,
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
                            (unapprovedRecord as dynamic).dateOfEvent,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Message: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            (unapprovedRecord as dynamic).message,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomForm1ACardDetail<T> extends StatelessWidget {
  // list with a type of unapproved data model
  final T unapprovedData;
  final String? eventOrDomainId;
  final bool isService;

  const CustomForm1ACardDetail({
    super.key,
    required this.unapprovedData,
    this.eventOrDomainId,
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
                  (unapprovedData as dynamic).ovcCpimsId,
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
                  eventOrDomainId!,
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
                  (unapprovedData as dynamic).dateOfEvent,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Message: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  (unapprovedData as dynamic).message,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

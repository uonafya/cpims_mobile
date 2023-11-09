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

  List<UnapprovedForm1DataModel> unapprovedForm1AData = [];
  List<UnapprovedForm1DataModel> unapprovedForm1BData = [];
  List<UnapprovedCasePlanModel> unapprovedCaseplanData = [];

  void deleteUnapprovedForm1(int id) async {
    bool success = await UnapprovedDataService.deleteUnapprovedForm1(id);
    if (success) {
      setState(() {
        if (selectedRecord == unapprovedRecords[0]) {
          unapprovedForm1AData.removeWhere((element) => element.id == id);
        } else if (selectedRecord == unapprovedRecords[1]) {
          unapprovedForm1BData.removeWhere((element) => element.id == id);
        }
      });
    }
  }

  void deleteUnapprovedCPT(int id) async {
    bool success = await UnapprovedDataService.deleteUnapprovedCpt(id);
    if (success) {
      setState(() {
        unapprovedCaseplanData.removeWhere((element) => element.id == id);
      });
    }
  }

  void getRecords() async {
    final List<UnapprovedForm1DataModel> form1ARecords =
        await UnapprovedDataService.fetchLocalUnapprovedForm1AData();
    final List<UnapprovedForm1DataModel> form1BRecords =
        await UnapprovedDataService.fetchLocalUnapprovedForm1BData();
    final List<UnapprovedCasePlanModel> unapprovedCaseplanRecords =
        await UnapprovedDataService.fetchLocalUnapprovedCasePlanData();
    setState(() {
      unapprovedForm1AData = form1ARecords;
      unapprovedForm1BData = form1BRecords;
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
              ChildDetailsCard(
                unapprovedRecords: unapprovedCaseplanData,
                selectedRecord: selectedRecord,
                onDelete: deleteUnapprovedCPT,
              ),
            if (selectedRecord == "CPARA")
              const Column(
                children: [Text('Hello')],
              ),
            if (selectedRecord == unapprovedRecords[0])
              Expanded(
                child: FormTab(
                  selectedRecord: selectedRecord,
                  unapprovedForm1aData: unapprovedForm1AData,
                  onDelete: deleteUnapprovedForm1,
                ),
              ),
            if (selectedRecord == unapprovedRecords[1])
              Expanded(
                child: FormTab(
                  selectedRecord: selectedRecord,
                  unapprovedForm1aData: unapprovedForm1BData,
                  onDelete: deleteUnapprovedForm1,
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
  final List<UnapprovedForm1DataModel>? unapprovedForm1aData;
  final Function(int) onDelete;

  const FormTab({
    super.key,
    required this.selectedRecord,
    this.unapprovedForm1aData,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        CustomCard(
          title: 'Unapproved $selectedRecord List',
          children: [
            if (selectedRecord == "Form 1A" || selectedRecord == "Form 1B")
              ...List.generate(
                unapprovedForm1aData!.length,
                (index) {
                  final UnapprovedForm1DataModel dataModel =
                      unapprovedForm1aData![index];
                  return UnapprovedForm1CardDetails<UnapprovedForm1DataModel>(
                    unapprovedData: dataModel,
                    eventOrDomainId: dataModel.services[0].domainId,
                    isService: true,
                    onDelete: onDelete,
                  );
                },
              )
          ],
        ),
      ],
    );
  }
}

class ChildDetailsCard<T> extends StatelessWidget {
  final List<UnapprovedCasePlanModel> unapprovedRecords;
  final String selectedRecord;
  final Function(int)? onDelete;

  const ChildDetailsCard({
    super.key,
    required this.unapprovedRecords,
    required this.selectedRecord,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          CustomCard(
            title: 'Unapproved $selectedRecord Forms',
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                    itemCount: unapprovedRecords.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, index) {
                      final UnapprovedCasePlanModel unapprovedRecord =
                          unapprovedRecords[index];
                      return UnapprovedCasePlanFormDetails(
                        unapprovedRecord: unapprovedRecord,
                        onDelete: (int) {
                          onDelete!(int);
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UnapprovedCasePlanFormDetails extends StatelessWidget {
  const UnapprovedCasePlanFormDetails({
    super.key,
    required this.unapprovedRecord,
    required this.onDelete,
  });

  final UnapprovedCasePlanModel unapprovedRecord;
  final Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "CPIMS ID: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  unapprovedRecord.ovcCpimsId,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () async {
                      await onDelete(unapprovedRecord.id ?? 0);
                    },
                    icon: const Icon(Icons.delete)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Text(
                      "Message",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      unapprovedRecord.dateOfEvent,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  unapprovedRecord.message,
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Visibility(
              visible: unapprovedRecord.services.isNotEmpty,
              child: const Text(
                "Services",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Visibility(
                visible: unapprovedRecord.services.isNotEmpty,
                child: Column(
                  children: unapprovedRecord.services
                      .asMap()
                      .entries
                      .map((e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "#${e.key}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Domain: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(e.value.domainId),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Goal: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(e.value.goalId),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Gap: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(e.value.gapId),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Priority: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(e.value.priorityId),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Result: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(e.value.resultsId),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Reason: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(e.value.reasonId),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Service IDs",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    e.value.serviceIds.join(', '),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Responsible IDs",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    e.value.responsibleIds.join(', '),
                                  ),
                                ],
                              ),
                            ],
                          ))
                      .toList(),
                )),
          ],
        ),
      ),
    );
  }
}

class UnapprovedForm1CardDetails<T> extends StatelessWidget {
  // list with a type of unapproved data model
  final UnapprovedForm1DataModel unapprovedData;
  final String? eventOrDomainId;
  final bool isService;
  final Function(int) onDelete;

  const UnapprovedForm1CardDetails({
    super.key,
    required this.unapprovedData,
    this.eventOrDomainId,
    required this.isService,
    required this.onDelete,
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
                    fontSize: 16,
                  ),
                ),
                Text(
                  unapprovedData.ovcCpimsId,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () async {
                      await onDelete(unapprovedData.id ?? 0);
                    },
                    icon: const Icon(Icons.delete)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Text(
                      "Message",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      unapprovedData.dateOfEvent,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  unapprovedData.message,
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Visibility(
              visible: unapprovedData.services.isNotEmpty,
              child: const Text(
                "Services",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Visibility(
                visible: unapprovedData.services.isNotEmpty,
                child: Column(
                  children: unapprovedData.services
                      .map((e) => Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    const Text(
                                      "ID: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(e.serviceId.toString()),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    const Text(
                                      "Domain: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(e.domainId),
                                  ],
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                )),
            const SizedBox(
              height: 4,
            ),
            Visibility(
              visible: unapprovedData.criticalEvents.isNotEmpty,
              child: const Text(
                "Critical Events",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Visibility(
                visible: unapprovedData.criticalEvents.isNotEmpty,
                child: Column(
                  children: unapprovedData.criticalEvents
                      .map((e) => Row(
                            children: [
                              Expanded(
                                  child: Row(
                                children: [
                                  const Text(
                                    "ID: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(e.eventId),
                                ],
                              )),
                              Expanded(
                                  child: Row(
                                children: [
                                  const Text(
                                    "Date: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(e.eventDate),
                                ],
                              )),
                            ],
                          ))
                      .toList(),
                )),
          ],
        ),
      ),
    );
  }
}

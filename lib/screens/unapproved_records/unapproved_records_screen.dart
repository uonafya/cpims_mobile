import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/Models/unapproved_form_1_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/services/unapproved_data_service.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_chip.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:provider/provider.dart';

import '../../Models/unapproved_caseplan_form_model.dart';
import '../../providers/form1a_provider.dart';
import '../forms/form1a/new/form_one_a.dart';
import '../forms/form1a/new/utils/form_one_a_provider.dart';
import '../forms/form1a/utils/form_1a_options.dart';
import '../forms/form1b/utils/form1bConstants.dart';

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
    Form1AProviderNew form1aProvider = Provider.of<Form1AProviderNew>(context);

    void editUnapprovedForm1A(UnapprovedForm1DataModel unapprovedForm1A) async {
      // TODO : Refactor for efficiency
      CaseLoadModel caseLoad = CaseLoadModel();
      caseLoad.cpimsId = unapprovedForm1A.ovcCpimsId;
      caseLoad.caregiverNames = "Unknown";
      List<ValueItem> form1CriticalEvents = [];
      List<ValueItem> criticalEventsOptions = formOneACriticalEvents.map((service) {
        return ValueItem(
            label: service['event_description'], value: service['event_id']);
      }).toList();
      for (var form1ACriticalEvent in unapprovedForm1A.criticalEvents) {
        var t = criticalEventsOptions.where((element) => element.value == form1ACriticalEvent.eventId);
        if(t.isNotEmpty) {
          form1CriticalEvents.add(t.first);
        }
      }
      if (form1CriticalEvents.isNotEmpty) {
        form1aProvider.setCriticalEventsSelectedEvents(form1CriticalEvents);
      }

      List<ValueItem> form1StableServices = [];
      String stableServicesDomain = domainsList[2]['item_id'];
      List<ValueItem> stableServices = stableServicesOptions.map((service) {
        return ValueItem(
            label: service['item_description'], value: service['item_id']);
      }).toList();
      for (var form1AService in unapprovedForm1A.services) {
        if (form1AService.domainId == stableServicesDomain) {
          var t = stableServices.where((element) => element.value == form1AService.serviceId);
          if(t.isNotEmpty) {
            form1StableServices.add(t.first);
          }
        }
      }
      if (form1StableServices.isNotEmpty) {
        form1aProvider.setSelectedStableFormDataServices(
            form1StableServices, stableServicesDomain);
      }
      List<ValueItem> form1SchooledServices = [];
      String schooledServicesDomain = domainsList[0]['item_id'];
      List<ValueItem> schoolServices = schooledServicesOptions.map((service) {
        return ValueItem(
            label: service['item_description'], value: service['item_id']);
      }).toList();
      for (var form1AService in unapprovedForm1A.services) {
        if (form1AService.domainId == schooledServicesDomain) {
          var t = schoolServices.where((element) => element.value == form1AService.serviceId);
          if(t.isNotEmpty) {
            form1SchooledServices.add(t.first);
          }
        }
      }
      print("form1SchooledServices");
      print(form1SchooledServices);
      if (form1SchooledServices.isNotEmpty) {
        form1aProvider.setSelectedSchooledFormDataServices(
            form1SchooledServices, schooledServicesDomain);
      }
      List<ValueItem> form1HealthyServices = [];
      String healthyServicesDomain = domainsList[1]['item_id'];
      List<ValueItem> healthyServices = healthServicesOptions.map((service) {
        return ValueItem(
            label: service['item_description'], value: service['item_id']);
      }).toList();
      for (var form1AService in unapprovedForm1A.services) {
        if (form1AService.domainId == healthyServicesDomain) {
          var t = healthyServices.where((element) => element.value == form1AService.serviceId);
          if(t.isNotEmpty) {
            form1HealthyServices.add(t.first);
          }
        }
      }
      if (form1HealthyServices.isNotEmpty) {
        form1aProvider.setSelectedHealthServices(
            form1HealthyServices, healthyServicesDomain);
      }
      List<ValueItem> form1SafeServices = [];
      String safeServicesDomain = domainsList[3]['item_id'];
      List<ValueItem> safeServicesOptions = safeServices.map((service) {
        return ValueItem(
            label: service['item_description'], value: service['item_id']);
      }).toList();
      for (var form1AService in unapprovedForm1A.services) {
        if (form1AService.domainId == safeServicesDomain) {
          var t = safeServicesOptions.where((element) => element.value == form1AService.serviceId);
          if(t.isNotEmpty) {
            form1SafeServices.add(t.first);
          }
        }
      }
      if (form1SafeServices.isNotEmpty) {
        form1aProvider.setSelectedSafeFormDataServices(
            form1SafeServices, safeServicesDomain);
      }

      // List<> services = unapprovedForm1A.services.map((e) => null);
      context
          .read<Form1AProvider>();

      Get.to(() => FomOneA(caseLoadModel: caseLoad));
    }
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
                  onEdit: editUnapprovedForm1A,
                ),
              ),
            if (selectedRecord == unapprovedRecords[1])
              Expanded(
                child: FormTab(
                  selectedRecord: selectedRecord,
                  unapprovedForm1aData: unapprovedForm1BData,
                  onDelete: deleteUnapprovedForm1,
                  onEdit: editUnapprovedForm1A,
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
  final Function(UnapprovedForm1DataModel) onEdit;

  const FormTab({
    super.key,
    required this.selectedRecord,
    this.unapprovedForm1aData,
    required this.onDelete,
    required this.onEdit,
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
                    onEdit: onEdit,
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
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit)),
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
  final Function(UnapprovedForm1DataModel) onEdit;

  const UnapprovedForm1CardDetails({
    super.key,
    required this.unapprovedData,
    this.eventOrDomainId,
    required this.isService,
    required this.onDelete, required this.onEdit,
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
                IconButton (
                    onPressed:()async{
                      await  onEdit(unapprovedData);
                    },
                    icon: const Icon(Icons.edit)
                ),
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

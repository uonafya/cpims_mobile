import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/ovc_care/ovc_care_screen.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaregiverScreen extends StatefulWidget {
  const CaregiverScreen({super.key});

  @override
  State<CaregiverScreen> createState() => _CaregiverScreenState();
}

class _CaregiverScreenState extends State<CaregiverScreen> {
  @override
  Widget build(BuildContext context) {
    final List<CaseLoadModel> caseLoadModelData =
        context.select((UIProvider provider) => provider.caseLoadData!);
    print("caseLoadModelData: $caseLoadModelData");

    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: caseLoadModelData.length,
            itemBuilder: (context, index) {
              return CaregiverCardItem(
                caseLoadModel: caseLoadModelData[index],
                caseLoadModelList: caseLoadModelData,
              );
            }),
      ),
    );
  }
}

class CaregiverCardItem extends StatefulWidget {
  const CaregiverCardItem({
    super.key,
    required this.caseLoadModel,
    required this.caseLoadModelList,
  });
  final CaseLoadModel caseLoadModel;
  final List<CaseLoadModel> caseLoadModelList;

  @override
  State<CaregiverCardItem> createState() => _CaregiverCardItemState();
}

class _CaregiverCardItemState extends State<CaregiverCardItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final children = widget.caseLoadModelList
        .where((e) => e.caregiverNames == widget.caseLoadModel.caregiverNames)
        .toList();
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.caseLoadModel.caregiverNames}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Row(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Caregiver ID: ',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              widget.caseLoadModel.caregiverCpimsId!,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isExpanded)
          ...List.generate(
            children.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListTile(
                leading: Text(children[index].cpimsId!),
                title: Text(
                    '${children[index].ovcSurname!} ${children[index].ovcFirstName!}'),
                trailing: Text(
                    "${children[index].sex!}(${calculateAge(children[index].dateOfBirth!)})"),
                tileColor: Colors.grey[200],
              ),
            ),
          ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

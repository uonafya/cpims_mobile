import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/ovc_care/ovc_details_screen.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_dropdown.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class OVCCareScreen extends StatefulWidget {
  const OVCCareScreen({super.key});

  @override
  State<OVCCareScreen> createState() => _OVCCareScreenState();
}

class _OVCCareScreenState extends State<OVCCareScreen> {
  bool isSearching = false;
  String selectedCriteria = 'Select Criteria';
  String? searchTerm;
  List<CaseLoadModel> searchedData = [];

  void handleSearch(List<CaseLoadModel> data) {
    setState(() {
      final searchTermLowerCase = searchTerm!.toLowerCase();
      final selectedCriteriaLowerCase = selectedCriteria.toLowerCase();

      searchedData = data.where((element) {
        final firstNameLowerCase = element.ovcFirstName!.toLowerCase();
        final surnameLowerCase = element.ovcSurname!.toLowerCase();
        final cpimsIdLowerCase = element.cpimsId!.toLowerCase();
        final caregiverNamesLowerCase = element.caregiverNames!.toLowerCase();

        if (selectedCriteriaLowerCase == 'names') {
          return firstNameLowerCase.contains(searchTermLowerCase) ||
              surnameLowerCase.contains(searchTermLowerCase);
        } else if (selectedCriteriaLowerCase == 'cpims id') {
          return cpimsIdLowerCase.contains(searchTermLowerCase);
        } else if (selectedCriteriaLowerCase == 'caregiver names') {
          return caregiverNamesLowerCase.contains(searchTermLowerCase);
        } else {
          return firstNameLowerCase.contains(searchTermLowerCase) ||
              surnameLowerCase.contains(searchTermLowerCase) ||
              cpimsIdLowerCase.contains(searchTermLowerCase) ||
              caregiverNamesLowerCase.contains(searchTermLowerCase);
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final caseLoadData =
        Provider.of<UIProvider>(context, listen: false).caseLoadData;
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: ListView(
        padding: kSystemPadding,
        children: [
          const SizedBox(height: 20),
          const Text('OVC Care (Comprehensive)',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          const Text(
            'Assessment and Case Management',
            style: TextStyle(color: kTextGrey),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomCard(title: 'OVC Search', children: [
            CustomTextField(
              hintText: 'Search ...',
              onChanged: (val) {
                setState(() {
                  searchTerm = val;
                });
                handleSearch(caseLoadData!);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            CustomDropdown(
                initialValue: selectedCriteria,
                items: const [
                  'Select Criteria',
                  'Names',
                  'Caregiver Names',
                  'CPIMS ID',
                ],
                onChanged: (val) {
                  setState(() {
                    selectedCriteria = val;
                  });
                  handleSearch(caseLoadData!);
                }),
            const SizedBox(
              height: 15,
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
          if (caseLoadData != null && searchedData.isNotEmpty)
            ...searchedData.map((e) => OVCCardItem(
                  caseLoadModel: e,
                  allCaseLoadData: caseLoadData,
                )),
          if (caseLoadData != null && searchedData.isEmpty)
            Container(
                margin: const EdgeInsets.only(top: 60),
                alignment: Alignment.center,
                child: const Text('No results found')),
          if (caseLoadData == null || searchedData.isEmpty)
            SizedBox(
              height: 230.h,
            ),
          const Footer(),
        ],
      ),
    );
  }
}

class OVCCardItem extends StatefulWidget {
  const OVCCardItem(
      {super.key, required this.caseLoadModel, required this.allCaseLoadData});

  final CaseLoadModel caseLoadModel;
  final List<CaseLoadModel> allCaseLoadData;

  @override
  State<OVCCardItem> createState() => _OVCCardItemState();
}

class _OVCCardItemState extends State<OVCCardItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final children = widget.allCaseLoadData
        .where((element) =>
            element.caregiverCpimsId == widget.caseLoadModel.caregiverCpimsId)
        .toList();
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
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
                        '${widget.caseLoadModel.ovcFirstName} ${widget.caseLoadModel.ovcSurname}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          const Text(
                            'CPIMS ID: ',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            '${widget.caseLoadModel.cpimsId}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
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
                        const Text(
                          'Caregiver: ',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        Text(
                          '${widget.caseLoadModel.caregiverNames}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Spacer(),
                        Icon(isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Age: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      Text(widget.caseLoadModel.age!.toString()),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(widget.caseLoadModel.sex!),
                ],
              ),
            ),
          ),
        ),
        if (isExpanded)
          ...List.generate(
              children.length,
              (index) => ListTile(
                    onTap: () {
                      Get.to(() =>
                          OVCDetailsScreen(caseLoadModel: children[index]));
                    },
                    leading: Text(children[index].cpimsId!),
                    title: Text(
                        '${children[index].ovcSurname!} ${children[index].ovcFirstName!}'),
                    trailing: Text(
                        "${children[index].sex!}(${children[index].age!.toString()})"),
                    tileColor: Colors.grey[200],
                  )),
        if (isExpanded)
          const SizedBox(
            height: 16,
          ),
      ],
    );
  }
}

String formatSex(String sex) {
  return sex.toLowerCase() == "male" ? "M" : "F";
}

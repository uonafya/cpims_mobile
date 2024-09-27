import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/ovc_care/ovc_details_screen.dart';
import 'package:cpims_mobile/widgets/custom_card_grid_item.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_grid_view.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

class CareGiverDetailsScreen extends StatefulWidget {
  const CareGiverDetailsScreen({
    super.key,
    required this.caseLoadModel,
    required this.children,
  });

  final CaseLoadModel caseLoadModel;
  final List<CaseLoadModel> children;

  @override
  State<CareGiverDetailsScreen> createState() => _CareGiverDetailsScreenState();
}

class _CareGiverDetailsScreenState extends State<CareGiverDetailsScreen> {
  final fixedLengthList =
      List<int>.generate(3, (int index) => index * index, growable: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(),
        drawer: const Drawer(
          child: CustomDrawer(),
        ),
        body: ListView(
          padding: kSystemPadding,
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Wrap(
              runSpacing: 5.0,
              spacing: 5.0,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                Column(
                  children: [
                    Icon(FontAwesomeIcons.child),
                    //this is needed because Wrap does not have WrapCrossAlignment.baseLine
                    SizedBox(height: 5),
                  ],
                ),
                Text(
                  "OVC Caregiver",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            const Text(
              "Caregiver Details",
              style: TextStyle(color: Color(0xFf7c7f83)),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomCard(
                title: "Caregiver ID: ${widget.caseLoadModel.caregiverCpimsId}",
                children: [
                  CustomGridView(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      CustomCardGridItem(
                        header: "Surname",
                        details:
                            widget.caseLoadModel.caregiverNames!.split(" ")[0],
                      ),
                      CustomCardGridItem(
                        header: "Firstname",
                        details:
                            widget.caseLoadModel.caregiverNames!.split(" ")[1],
                      ),
                      const CustomCardGridItem(
                        header: "Sex",
                        details: "-",
                      ),
                      const CustomCardGridItem(
                        header: "Age",
                        details: "-",
                      ),
                    ],
                  ),
                ]),
            const SizedBox(
              height: 20,
            ),
            CustomCard(
              title: "Caregiver: Children",
              children: [
                Table(
                  border: TableBorder.symmetric(
                    inside: BorderSide(color: Colors.grey.withOpacity(0.5)),
                  ),
                  defaultColumnWidth: const IntrinsicColumnWidth(),
                  children: [
                    const TableRow(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "CPIMS ID",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Age",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Sex",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ]),
                    ...widget.children
                        .map((child) => TableRow(children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() =>
                                      OVCDetailsScreen(caseLoadModel: child));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${child.ovcSurname} ${child.ovcFirstName}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  child.cpimsId!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  child.age!.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  child.sex!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ]))
                        .toList(),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "CPARA Benchmarks",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Table(
              border: TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
              columnWidths: const {
                0: FixedColumnWidth(80),
              },
              children: [
                TableRow(children: [
                  Container(
                    color: const Color(0xFFd9d9d9),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Benchmarks:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  ...List<int>.generate(9, (int index) => index + 1,
                          growable: false)
                      .map((e) => Container(
                            color: const Color(0xFFe8e8e8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "$e",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ]),
                TableRow(children: [
                  Container(
                    color: const Color(0xFFd9d9d9),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Scores: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  ...List<int>.generate(9, (int index) => 0, growable: false)
                      .map((e) => const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "0",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ))
                      .toList(),
                ]),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Benchmark Result",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Row(
              children: [
                Text(
                  "Score:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  "4", // Placeholder value for Total
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Row(
              children: [
                Text(
                  "Pathway:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  "Abandoned", // Placeholder value for Inference
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Footer(),
            const SizedBox(
              height: 10,
            ),
            const Footer(),
          ],
        ));
  }
}

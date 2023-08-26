import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/widgets/custom_card_grid_item.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_grid_view.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CareGiverDetailsScreen extends StatefulWidget {
  const CareGiverDetailsScreen({super.key});

  // final CaseLoadModel caseLoadModel;

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
            const CustomCard(title: "Caregiver ID: #####", children: [
              CustomGridView(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  CustomCardGridItem(
                    header: "Surname",
                    details: "Surname",
                  ),
                  CustomCardGridItem(
                    header: "Firstname",
                    details: "Firstname",
                  ),
                  CustomCardGridItem(
                    header: "Sex",
                    details: "Sex",
                  ),
                  CustomCardGridItem(
                    header: "Age",
                    details: "18",
                  ),
                  CustomCardGridItem(
                    header: "Other",
                    details: "Other",
                  ),
                ],
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            CustomCard(
              title: "Caregiver ID: Children",
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
                    ...fixedLengthList
                        .map((e) => const TableRow(children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Firstname Middle Lastname",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "1234",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "10",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Male",
                                  style: TextStyle(
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
                        "Scores: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
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
                        "Count: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  ...List<int>.generate(9, (int index) => index + 1,
                          growable: false)
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "$e",
                              style: const TextStyle(
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
            const Footer(),
          ],
        ));
  }
}

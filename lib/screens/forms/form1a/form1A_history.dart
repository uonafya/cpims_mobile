import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Models/case_load_model.dart';
import '../../../constants.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_card_grid_item.dart';
import '../../../widgets/custom_grid_view.dart';
import '../../../widgets/drawer.dart';
import '../../../widgets/footer.dart';
import '../../cpara/widgets/ovc_sub_population_form.dart';
import '../../ovc_care/ovc_care_screen.dart';
import '../../unsynched_workflows/widgets/child_details_workflow_button.dart';
import '../case_plan/case_plan.dart';

class HistoryForm1A extends StatefulWidget {
  const HistoryForm1A({super.key, required this.caseLoadModel});
  final CaseLoadModel caseLoadModel;


  @override
  State<HistoryForm1A> createState() => _HistoryForm1AState();
}

class _HistoryForm1AState extends State<HistoryForm1A> {
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
                // Column(
                //   children: [
                //     Icon(FontAwesomeIcons.clockRotateLeft),
                //     //this is needed because Wrap does not have WrapCrossAlignment.baseLine
                //     SizedBox(height: 5),
                //   ],
                // ),
                Text(
                  "Form 1A History(s)",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const Text(
              "OVC Details",
              style: TextStyle(color: Color(0xFf7c7f83)),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomCard(
                title: "CPIMIS ID: ${widget.caseLoadModel.cpimsId}",
                children: [
                  CustomGridView(
                    crossAxisCount: 2,
                    childrenHeight: 65,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      CustomCardGridItem(
                        header: "Surname",
                        details: "${widget.caseLoadModel.ovcSurname}",
                      ),
                      CustomCardGridItem(
                        header: "Firstname",
                        details: "${widget.caseLoadModel.ovcFirstName}",
                      ),
                      CustomCardGridItem(
                        header: "Sex",
                        details: "${widget.caseLoadModel.sex}",
                      ),
                      CustomCardGridItem(
                        header: "Age",
                        details: calculateAge(
                            widget.caseLoadModel.dateOfBirth ?? '10/10/2008'),
                      ),
                      CustomCardGridItem(
                        header: "Caregiver",
                        details: "${widget.caseLoadModel.caregiverNames}",
                      ),
                    ],
                  )
                ]),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Past Assessment(s)",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // const SizedBox(
            //   height: 10,
            // ),
            const Footer(),
          ],
        ));
  }
}

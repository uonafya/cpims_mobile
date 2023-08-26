import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/cpara/cpara_forms.dart';
import 'package:cpims_mobile/screens/ovc_care/ovc_care_screen.dart';
import 'package:cpims_mobile/screens/unsynched_workflows/widgets/child_details_grid_item.dart';
import 'package:cpims_mobile/screens/unsynched_workflows/widgets/child_details_workflow_button.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../cpara/widgets/ovc_sub_population_form.dart';

class OVCDetailsScreen extends StatefulWidget {
  const OVCDetailsScreen({super.key, required this.caseLoadModel});
  final CaseLoadModel caseLoadModel;

  @override
  State<OVCDetailsScreen> createState() => _OVCDetailsScreenState();
}

class _OVCDetailsScreenState extends State<OVCDetailsScreen> {
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
                  "OVC Care",
                  style: TextStyle(
                    fontSize: 24,
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
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: (1 / 0.4),
                    children: [
                      ChildDetailsGridItem(
                        header: "Surname",
                        details: "${widget.caseLoadModel.ovcSurname}",
                      ),
                      ChildDetailsGridItem(
                        header: "Firstname",
                        details: "${widget.caseLoadModel.ovcFirstName}",
                      ),
                      ChildDetailsGridItem(
                        header: "Sex",
                        details: "${widget.caseLoadModel.sex}",
                      ),
                      ChildDetailsGridItem(
                        header: "Age",
                        details: calculateAge(
                            widget.caseLoadModel.dateOfBirth ?? '10/10/2008'),
                      ),
                      ChildDetailsGridItem(
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
              "Available Forms",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ChildDetailsWorkflowButton(
              workflowName: "Form A",
              onClick: () {},
            ),
            ChildDetailsWorkflowButton(
              workflowName: "Form B",
              onClick: () {},
            ),
             ChildDetailsWorkflowButton(
              workflowName: "Case Plan Template",
              onClick: () {},
            ),
             ChildDetailsWorkflowButton(
              workflowName: "CPARA",
              onClick: () {
                Get.to(() =>  CparaFormsScreen(caseLoadModel: widget.caseLoadModel));

              },
            ),
            ChildDetailsWorkflowButton(
              workflowName: "OVC Prepopulation",
              onClick: () {
                Get.to(() => CheckboxForm(caseLoadModel: widget.caseLoadModel));
              },
            ),

           
            const SizedBox(
              height: 10,
            ),
            const Footer(),
          ],
        ));
  }
}

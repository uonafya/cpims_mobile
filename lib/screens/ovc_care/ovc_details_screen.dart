import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/form1a_provider.dart';
import 'package:cpims_mobile/screens/cpara/cpara_forms.dart';
import 'package:cpims_mobile/screens/cpara/provider/cpara_provider.dart';
import 'package:cpims_mobile/screens/forms/case_plan/case_plan.dart';
import 'package:cpims_mobile/screens/forms/form1a/form_1A.dart';
import 'package:cpims_mobile/screens/forms/form1b/form_1B.dart';
import 'package:cpims_mobile/screens/ovc_care/ovc_care_screen.dart';
import 'package:cpims_mobile/widgets/custom_card_grid_item.dart';
import 'package:cpims_mobile/screens/unsynched_workflows/widgets/child_details_workflow_button.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_grid_view.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import '../cpara/widgets/ovc_sub_population_form.dart';
import '../forms/case_plan/cpt/new_case_plan_template.dart';

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
  void initState() {
    // context.read<CparaProvider>().updateCaseLoadModel(widget.caseLoadModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<CparaProvider>(context, listen: true);
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
            Wrap(
              children: [
                CustomCard(
                    title:
                        "CPIMS ID: ${widget.caseLoadModel.cpimsId} \n CARE GIVER: ${widget.caseLoadModel.caregiverNames} \n CAREGIVER ID: ${widget.caseLoadModel.caregiverCpimsId}",
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
                                widget.caseLoadModel.dateOfBirth ?? ''),
                          ),
                        ],
                      )
                    ])
              ],
            ),
            const SizedBox(
              height: 10,
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
              workflowName: "Form 1A",
              onClick: () {
                context
                    .read<Form1AProvider>()
                    .updateCaseLoadModel(widget.caseLoadModel);
                Get.to(() => Form1AScreen(caseLoadModel: widget.caseLoadModel));
              },
            ),
            ChildDetailsWorkflowButton(
              workflowName: "Form 1B",
              onClick: () {
                Get.to(() => Form1BScreen(
                      caseLoad: widget.caseLoadModel,
                    ));
              },
            ),
            ChildDetailsWorkflowButton(
              workflowName: "CPARA",
              onClick: () {
                context
                    .read<CparaProvider>()
                    .updateCaseLoadModel(widget.caseLoadModel);
                Get.to(() =>
                    CparaFormsScreen(caseLoadModel: widget.caseLoadModel));
              },
            ),
            ChildDetailsWorkflowButton(
              workflowName: "OVC Sub Population",
              onClick: () {
                Get.to(() => CheckboxForm(caseLoadModel: widget.caseLoadModel));
              },
            ),
            ChildDetailsWorkflowButton(
              workflowName: "Case Plan Template",
              onClick: () {
                Get.to(
                    () => CasePlanTemplateForm(caseLoad: widget.caseLoadModel));
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

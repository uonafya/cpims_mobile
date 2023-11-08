import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/app_meta_data_provider.dart';
import 'package:cpims_mobile/providers/form1a_provider.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/cpara/cpara_forms.dart';
import 'package:cpims_mobile/screens/cpara/provider/cpara_provider.dart';
import 'package:cpims_mobile/screens/forms/form1b/form_1B.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/screens/hiv_management_form_screen.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/screens/hiv_management_form_screen.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_assessment.dart';
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

import '../forms/case_plan/cpt/new_case_plan_template.dart';
import '../forms/form1a/new/form_one_a.dart';

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
                        "CPIMS ID: ${widget.caseLoadModel.cpimsId} (${widget.caseLoadModel.ovchivstatus}) \n CARE GIVER: ${widget.caseLoadModel.caregiverNames} \n CAREGIVER ID: ${widget.caseLoadModel.caregiverCpimsId}",
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
                          // CustomCardGridItem(
                          //   header: "",
                          //   details: "${widget.caseLoadModel.ovchivstatus}",
                          // ),
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
                String startDateTime = DateTime.now().toString();
                context
                    .read<AppMetaDataProvider>()
                    .updateStartTimeInterview(startDateTime);

                Get.to(() => FomOneA(caseLoadModel: widget.caseLoadModel));
              },
            ),
            ChildDetailsWorkflowButton(
              workflowName: "Form 1B",
              onClick: () {
                Get.to(() => Form1BScreen(
                      caseLoad: widget.caseLoadModel,
                    ));
                String startDateTime = DateTime.now().toString();
                context
                    .read<AppMetaDataProvider>()
                    .updateStartTimeInterview(startDateTime);
              },
            ),
            ChildDetailsWorkflowButton(
              workflowName: "CPARA",
              onClick: () {
                // Get instance of current CPARA provider
                var oldCpimsId =
                    context.read<CparaProvider>().caseLoadModel?.cpimsId;

                // Add check here
                if (widget.caseLoadModel.cpimsId != oldCpimsId) {
                  // Clear previous CPARA data
                  context.read<CparaProvider>().clearCparaProvider();
                }
                context
                    .read<CparaProvider>()
                    .updateCaseLoadModel(widget.caseLoadModel);
                final caseLoadData =
                    Provider.of<UIProvider>(context, listen: false)
                        .caseLoadData;
                context
                    .read<CparaProvider>()
                    .updateChildren(caseLoadData ?? []);
                // Set start time to form meta data
                String startDateTime = DateTime.now().toString();
                context
                    .read<AppMetaDataProvider>()
                    .updateStartTimeInterview(startDateTime);

                Get.to(() =>
                    CparaFormsScreen(caseLoadModel: widget.caseLoadModel));
              },
            ),
            ChildDetailsWorkflowButton(
              workflowName: "Case Plan Template",
              onClick: () {
                Get.to(
                    () => CasePlanTemplateForm(caseLoad: widget.caseLoadModel));
              },
            ),
            if (widget.caseLoadModel.ovchivstatus == "Positive")
              ChildDetailsWorkflowButton(
                workflowName: "HIV Management Form",
                onClick: () {
                  Get.to(
                    () => HIVManagementForm(caseLoad: widget.caseLoadModel),
                  );
                },
              ),
            if (widget.caseLoadModel.ovchivstatus != "Positive")
              ChildDetailsWorkflowButton(
                workflowName: "HIV Assessment form",
                onClick: () {
                  Get.to(() => HIVAssessmentScreen(
                        caseLoadModel: widget.caseLoadModel,
                      ));
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

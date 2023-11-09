import 'package:cpims_mobile/screens/forms/case_plan/cpt/models/healthy_cpt_model.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/models/safe_cpt_model.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/models/schooled_cpt_model.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/models/stable_cpt_model.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/new_cpt_provider.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddCPTButton extends StatefulWidget {
  const AddCPTButton({super.key, this.onTap, required this.formattedDate});
  final Function? onTap;
  final String formattedDate;

  @override
  State<AddCPTButton> createState() => _AddCPTButtonState();
}

class _AddCPTButtonState extends State<AddCPTButton> {
  DateTime currentDateOfCasePlan = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        text: "Add",
        onTap: () async {
          final provider = Provider.of<CptProvider>(context, listen: false);

          try {
            if (widget.formattedDate.isEmpty) {
              Get.snackbar(
                'Error',
                'Please select date of caseplan',
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
              return;
            }

            CptHealthFormData? cptHealthFormData =
                context.read<CptProvider>().cptHealthFormData ??
                    CptHealthFormData();
            CptSafeFormData? cptSafeFormData =
                context.read<CptProvider>().cptSafeFormData ??
                    CptSafeFormData();
            CptStableFormData? cptStableFormData =
                context.read<CptProvider>().cptStableFormData ??
                    CptStableFormData();
            CptschooledFormData? cptschooledFormData =
                context.read<CptProvider>().cptschooledFormData ??
                    CptschooledFormData();

            if (cptHealthFormData.serviceIds != null &&
                cptHealthFormData.goalId != null &&
                cptHealthFormData.gapId != null &&
                cptHealthFormData.priorityId != null &&
                cptHealthFormData.responsibleIds != null &&
                cptHealthFormData.resultsId != null) {
              String? completionDateValue =
                  cptHealthFormData.completionDate ?? '';
              String? reason = cptHealthFormData.reasonId ?? '';
              Map<String, dynamic> healthService = {
                'domain_id': "DHNU",
                'service_id': cptHealthFormData.serviceIds,
                'goal_id': cptHealthFormData.goalId,
                'gap_id': cptHealthFormData.gapId,
                'priority_id': cptHealthFormData.priorityId,
                'responsible_id': cptHealthFormData.responsibleIds,
                'results_id': cptHealthFormData.resultsId,
                'reason_id': reason,
                'completion_date': completionDateValue,
              };
              provider.servicesList.add(healthService);
              provider.updateCptList(CptHealthFormData.fromJson(healthService));
            }

            if (cptSafeFormData.serviceIds != null &&
                cptSafeFormData.goalId != null &&
                cptSafeFormData.gapId != null &&
                cptSafeFormData.priorityId != null &&
                cptSafeFormData.responsibleIds != null &&
                cptSafeFormData.resultsId != null) {
              String? completionDateValue =
                  cptSafeFormData.completionDate ?? '';
              String? reason = cptSafeFormData.reasonId ?? '';
              Map<String, dynamic> safeService = {
                'domain_id': 'DPRO',
                'service_id': cptSafeFormData.serviceIds,
                'goal_id': cptSafeFormData.goalId,
                'gap_id': cptSafeFormData.gapId,
                'priority_id': cptSafeFormData.priorityId,
                'responsible_id': cptSafeFormData.responsibleIds,
                'results_id': cptSafeFormData.resultsId,
                'reason_id': reason,
                'completion_date': completionDateValue,
              };
              provider.servicesList.add(safeService);
              provider.updateCptSafeList(CptSafeFormData.fromJson(safeService));
            }

            if (cptStableFormData.serviceIds != null &&
                cptStableFormData.goalId != null &&
                cptStableFormData.gapId != null &&
                cptStableFormData.priorityId != null &&
                cptStableFormData.responsibleIds != null &&
                cptStableFormData.resultsId != null) {
              String? completionDateValue =
                  cptStableFormData.completionDate ?? '';
              String? reason = cptStableFormData.reasonId ?? '';
              Map<String, dynamic> stableService = {
                'domain_id': 'DHES',
                'service_id': cptStableFormData.serviceIds,
                'goal_id': cptStableFormData.goalId,
                'gap_id': cptStableFormData.gapId,
                'priority_id': cptStableFormData.priorityId,
                'responsible_id': cptStableFormData.responsibleIds,
                'results_id': cptStableFormData.resultsId,
                'reason_id': reason,
                'completion_date': completionDateValue,
              };
              provider.servicesList.add(stableService);
              provider.updateCptStableList(
                  CptStableFormData.fromJson(stableService));
            }

            if (cptschooledFormData.serviceIds != null &&
                cptschooledFormData.goalId != null &&
                cptschooledFormData.gapId != null &&
                cptschooledFormData.priorityId != null &&
                cptschooledFormData.responsibleIds != null &&
                cptschooledFormData.resultsId != null) {
              String? completionDateValue =
                  cptschooledFormData.completionDate ?? '';
              String? reason = cptschooledFormData.reasonId ?? '';
              Map<String, dynamic> schooledService = {
                'domain_id': 'DEDU',
                'service_id': cptschooledFormData.serviceIds,
                'goal_id': cptschooledFormData.goalId,
                'gap_id': cptschooledFormData.gapId,
                'priority_id': cptschooledFormData.priorityId,
                'responsible_id': cptschooledFormData.responsibleIds,
                'results_id': cptschooledFormData.resultsId,
                'reason_id': reason,
                'completion_date': completionDateValue,
              };
              provider.servicesList.add(schooledService);
              provider.updateCptSchooledList(
                  CptschooledFormData.fromJson(schooledService));
            }
          } catch (e) {
            debugPrint(e.toString());
          }

          // if (selectedStep == 0 && provider.cptHealthFormData != null) {
          //   provider.updateCptFormData(provider.cptHealthFormData!);
          // } else if (selectedStep == 1 && provider.cptSafeFormData != null) {
          //   provider.updateCptSafeFormData(provider.cptSafeFormData!);
          // } else if (selectedStep == 2 && provider.cptschooledFormData != null) {
          //   provider.updateCptSchooledFormData(provider.cptschooledFormData!);
          // } else if (selectedStep == 3 && provider.cptStableFormData != null) {
          //   provider.updateCptStableFormData(provider.cptStableFormData!);
          // }

          // context.read<CptProvider>().clearProviderData();
          if (widget.onTap != null) widget.onTap!();
          setState(() {});
        });
  }
}

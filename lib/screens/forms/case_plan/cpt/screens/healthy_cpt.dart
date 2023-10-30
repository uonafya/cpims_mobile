import 'dart:core';

import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/new_cpt_provider.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import '../../../../../Models/caseplan_form_model.dart';
import '../../../../../services/form_service.dart';
import '../../../../../widgets/custom_forms_date_picker.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../../../registry/organisation_units/widgets/steps_wrapper.dart';
import '../models/healthy_cpt_model.dart';


class HealthyCasePlan extends StatefulWidget {
  final CaseLoadModel? caseLoadModel;

  const HealthyCasePlan({super.key, required this.caseLoadModel});

  @override
  State<HealthyCasePlan> createState() => _HealthyCasePlanState();
}

class _HealthyCasePlanState extends State<HealthyCasePlan> {
  DateTime currentDateOfCasePlan = DateTime.now();
  DateTime completionDate = DateTime.now();
  String reasonForNotAchievingCasePlan = "";
  List<ValueItem> selectedGoalOptions = [];
  List<ValueItem> selectedNeedOptions = [];
  List<ValueItem> selectedPriorityActionOptions = [];
  List<ValueItem> selectedServicesOptions = [];
  List<ValueItem> selectedPersonsResponsibleOptions = [];
  List<ValueItem> selectedResultsOptions = [];
  List<String?> selectedServiceIds = [];
  List<String?> selectedPersonResponsibleIds = [];

  TextEditingController textEditingController = TextEditingController();
  List<ValueItem> casePlanProviderDomainList = [];
  List<ValueItem> casePlanGoalHealthList = [];
  List<ValueItem> casePlanGapsHealthList = [];
  List<ValueItem> casePlanPrioritiesHealthList = [];
  List<ValueItem> casePlanServicesHealthList = [];
  List<ValueItem> casePlanProviderPersonsResponsibleList = [];
  List<ValueItem> casePlanProviderResultList = [];
  CptProvider cptProvider = CptProvider();

  @override
  void initState() {
    super.initState();
    cptProvider = context.read<CptProvider>();

    casePlanProviderDomainList =
        cptProvider.csAllDomains.map((domain) {
          return ValueItem(
              label: "- ${domain['item_description']}", value: domain['item_id']);
        }).toList();

    casePlanGoalHealthList =
        cptProvider.cpGoalsHealth.map((domain) {
          return ValueItem(
              label: "- ${domain['item_description']}", value: domain['item_id']);
        }).toList();

    casePlanGapsHealthList =
        cptProvider.cpGapsHealth.map((domain) {
          return ValueItem(
              label: "- ${domain['item_description']}", value: domain['item_id']);
        }).toList();

    casePlanPrioritiesHealthList =
        cptProvider.cpPrioritiesHealth.map((domain) {
          return ValueItem(
              label: "- ${domain['item_description']}", value: domain['item_id']);
        }).toList();

    casePlanServicesHealthList =
        cptProvider.cpServicesHealth.map((domain) {
          return ValueItem(
              label: "- ${domain['item_description']}", value: domain['item_id']);
        }).toList();

    casePlanProviderPersonsResponsibleList =
        cptProvider.csPersonsResponsibleList.map((personResponsible) {
          return ValueItem(
              label: "- ${personResponsible['item_description']}",
              value: personResponsible['item_id']);
        }).toList();

    casePlanProviderResultList =
        cptProvider.csResultsList.map((resultList) {
          return ValueItem(
              label: "- ${resultList['name']}", value: resultList['id']);
        }).toList();

    // fetching the data from the provider
    CptHealthFormData cptHealthFormData = context.read<CptProvider>().cptHealthFormData ?? CptHealthFormData();
    // Update respective fields
    if(cptHealthFormData.goalId != null){
      selectedGoalOptions = casePlanGoalHealthList.where((element) => element.value?.trim().toLowerCase() == cptHealthFormData.goalId?.trim().toLowerCase()).toList();
    }
    if(cptHealthFormData.gapId != null){
      selectedNeedOptions = casePlanGapsHealthList.where((element) => element.value?.trim().toLowerCase() == cptHealthFormData.gapId?.trim().toLowerCase()).toList();
    }
    if(cptHealthFormData.priorityId != null){
      selectedPriorityActionOptions = casePlanPrioritiesHealthList.where((element) => element.value?.trim().toLowerCase() == cptHealthFormData.priorityId?.trim().toLowerCase()).toList();
    }
    if(cptHealthFormData.serviceIds != null && cptHealthFormData.serviceIds!.isNotEmpty){
      for(String? serviceId in cptHealthFormData.serviceIds!){
        selectedServicesOptions.add(casePlanServicesHealthList.where((element) => element.value?.trim().toLowerCase() == serviceId?.trim().toLowerCase()).toList()[0]);
      }
    }

    if(cptHealthFormData.responsibleIds != null && cptHealthFormData.responsibleIds!.isNotEmpty){
      for(String? responsibleId in cptHealthFormData.responsibleIds!){
        selectedPersonsResponsibleOptions.add(casePlanProviderPersonsResponsibleList.where((element) => element.value?.trim().toLowerCase() == responsibleId?.trim().toLowerCase()).toList()[0]);
      }
    }

    if(cptHealthFormData.resultsId != null){
      selectedResultsOptions = casePlanProviderResultList.where((element) => element.value?.trim().toLowerCase() == cptHealthFormData.resultsId?.trim().toLowerCase()).toList();
    }

    completionDate = cptHealthFormData.completionDate != null
        ? DateTime.parse(cptHealthFormData.completionDate!)
        : completionDate;

    textEditingController.text = cptHealthFormData.reasonId ?? "";
  }

  @override
  Widget build(BuildContext context) {

    return StepsWrapper(
      title: 'Health Domain Case Plan',
      children: [
        // const Row(
        //   children: [
        //     Text(
        //       'Date of Case Plan*',
        //       style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 10),
        // CustomFormsDatePicker(
        //   hintText: 'Please select the Date',
        //   selectedDateTime: currentDateOfCasePlan,
        //   onDateSelected: (selectedDate) {
        //     currentDateOfCasePlan = selectedDate;
        //     CptHealthFormData cptHealthFormData =
        //         context.read<CptProvider>().cptHealthFormData ??
        //             CptHealthFormData();
        //     context.read<CptProvider>().updateCptFormData(
        //         cptHealthFormData.copyWith(
        //             dateOfEvent: currentDateOfCasePlan.toIso8601String()));
        //     print("The selected date was $currentDateOfCasePlan");
        //   },
        // ),
        // const SizedBox(height: 10),
        const Row(
          children: [
            Text(
              'Domain*',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          readOnly: true,
          initialValue: 'Health',
          decoration: const InputDecoration(
            labelText: 'Health',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Text(
              'Goal*',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Please select the Goal',
          onOptionSelected: (selectedEvents) {
            CptHealthFormData cptHealtFormData =
                context.read<CptProvider>().cptHealthFormData ??
                    CptHealthFormData();
            context.read<CptProvider>().updateCptFormData(
                cptHealtFormData.copyWith(goalId: selectedEvents[0].value));
            // Print the updated goalId
            print("The selected goal was ${selectedEvents[0].value}");
          },
          selectedOptions: selectedGoalOptions,
          options: casePlanGoalHealthList,
          maxItems: 35,
          disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
          selectionType: SelectionType.single,
          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
          dropdownHeight: 300,
          optionTextStyle: const TextStyle(fontSize: 16),
          selectedOptionIcon: const Icon(Icons.check_circle),
          borderRadius: BorderRadius.circular(5.w)
              .topLeft
              .x, // Set the desired border radius value
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Text(
              'Needs/Gaps*',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Please select the Needs/Gaps',
          onOptionSelected: (selectedEvents) {
            // Ensure that you have a valid CasePlanHealthyModel instance
            CptHealthFormData cptHealthFormData =
                context.read<CptProvider>().cptHealthFormData ??
                    CptHealthFormData();
            context.read<CptProvider>().updateCptFormData(
                cptHealthFormData.copyWith(gapId: selectedEvents[0].value));
            // Print the updated goalId
            print("The selected need was ${selectedEvents[0].value}");
          },
          options: casePlanGapsHealthList,
          selectedOptions: selectedNeedOptions,
          maxItems: 35,
          disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
          selectionType: SelectionType.single,
          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
          dropdownHeight: 300,
          optionTextStyle: const TextStyle(fontSize: 16),
          selectedOptionIcon: const Icon(Icons.check_circle),
          borderRadius: BorderRadius.circular(5.w)
              .topLeft
              .x, // Set the desired border radius value
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Text(
              'Priority Actions*',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Please select the Priority Actions',
          onOptionSelected: (selectedEvents) {
            // Ensure that you have a valid CasePlanHealthyModel instance
            CptHealthFormData cptHealtFormData =
                context.read<CptProvider>().cptHealthFormData ??
                    CptHealthFormData();
            context.read<CptProvider>().updateCptFormData(
                cptHealtFormData.copyWith(priorityId: selectedEvents[0].value));
            // Print the updated goalId
            print("The selected prioity was ${selectedEvents[0].value}");
          },
          options: casePlanPrioritiesHealthList,
          selectedOptions: selectedPriorityActionOptions,
          maxItems: 35,
          disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
          selectionType: SelectionType.single,
          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
          dropdownHeight: 300,
          optionTextStyle: const TextStyle(fontSize: 16),
          selectedOptionIcon: const Icon(Icons.check_circle),
          borderRadius: BorderRadius.circular(5.w)
              .topLeft
              .x, // Set the desired border radius value
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Text(
              'Services*',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Please Select the Services',
          onOptionSelected: (selectedEvents) {
            // Ensure that you have a valid CasePlanHealthyModel instance
            CptHealthFormData cptHealtFormData =
                context.read<CptProvider>().cptHealthFormData ??
                    CptHealthFormData();
            context
                .read<CptProvider>()
                .updateCptFormData(cptHealtFormData.copyWith(
              serviceIds: selectedEvents.map((item) => item.value).toList(),
            ));
            selectedServiceIds =
                selectedEvents.map((item) => item.value).toList();
            print("The selected service IDs are $selectedServiceIds");
          },
          selectedOptions: selectedServicesOptions,
          options: casePlanServicesHealthList,
          maxItems: 13,
          disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
          selectionType: SelectionType.multi,
          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
          dropdownHeight: 300,
          optionTextStyle: const TextStyle(fontSize: 16),
          selectedOptionIcon: const Icon(Icons.check_circle),
          borderRadius: BorderRadius.circular(5.w)
              .topLeft
              .x, // Set the desired border radius value
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Text(
              'Person Responsible*',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Please select Person(s) Responsible',
          onOptionSelected: (selectedEvents) {
            // Ensure that you have a valid CasePlanHealthyModel instance
            CptHealthFormData cptHealtFormData =
                context.read<CptProvider>().cptHealthFormData ??
                    CptHealthFormData();
            context
                .read<CptProvider>()
                .updateCptFormData(cptHealtFormData.copyWith(
              responsibleIds:
              selectedEvents.map((item) => item.value).toList(),
            ));
            selectedPersonResponsibleIds =
                selectedEvents.map((item) => item.value).toList();
            print(
                "The selected responsible IDs are $selectedPersonResponsibleIds");
          },
          selectedOptions: selectedPersonsResponsibleOptions,
          options: casePlanProviderPersonsResponsibleList,
          maxItems: 13,
          disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
          selectionType: SelectionType.multi,
          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
          dropdownHeight: 300,
          optionTextStyle: const TextStyle(fontSize: 16),
          selectedOptionIcon: const Icon(Icons.check_circle),
          borderRadius: BorderRadius.circular(5.w)
              .topLeft
              .x, // Set the desired border radius value
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Text(
              'Results*',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Please select the Result(s)',
          onOptionSelected: (selectedEvents) {
            CptHealthFormData cptHealtFormData =
                context.read<CptProvider>().cptHealthFormData ??
                    CptHealthFormData();
            context.read<CptProvider>().updateCptFormData(
                cptHealtFormData.copyWith(resultsId: selectedEvents[0].value));
            // Print the updated goalId
            print("The selected result was ${selectedEvents[0].value}");
          },
          selectedOptions: selectedResultsOptions,
          options: casePlanProviderResultList,
          maxItems: 13,
          disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
          selectionType: SelectionType.single,
          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
          dropdownHeight: 300,
          optionTextStyle: const TextStyle(fontSize: 16),
          selectedOptionIcon: const Icon(Icons.check_circle),
          borderRadius: BorderRadius.circular(5.w)
              .topLeft
              .x, // Set the desired border radius value
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Text(
              'Date to be Completed*',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        CustomFormsDatePicker(
          hintText: 'Select the date',
          selectedDateTime: completionDate,
          onDateSelected: (selectedDate) {
            completionDate = selectedDate;
            CptHealthFormData cptHealthFormData =
                context.read<CptProvider>().cptHealthFormData ??
                    CptHealthFormData();
            context.read<CptProvider>().updateCptFormData(cptHealthFormData
                .copyWith(completionDate: completionDate.toIso8601String()));
            print("The selected date was $completionDate");
          },
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Text(
              'Reason(s)',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        CustomTextField(
          hintText: 'Please Write the Reasons',
          controller: textEditingController,
          onChanged: (val) {
            CptHealthFormData cptHealthFormData =
                context.read<CptProvider>().cptHealthFormData ??
                    CptHealthFormData();

            CptHealthFormData updatedFormData = cptHealthFormData.copyWith(
              reasonId: val,
            );
            context.read<CptProvider>().updateCptFormData(updatedFormData);
          },
        ),
        const SizedBox(height: 10),
        //BUTTON TO SAVE
        // Row(
        //   children: [
        //     Expanded(
        //         child: CustomButton(
        //       onTap: () async {
        //         String ovcId = widget.caseLoadModel!.cpimsId ?? "";
        //         reasonForNotAchievingCasePlan =
        //             textEditingController.text.toString();
        //
        //         CptHealthFormData cptHealthFormData =
        //             context.read<CptProvider>().cptHealthFormData ??
        //                 CptHealthFormData();
        //
        //         // Update all the fields at once
        //         CptHealthFormData updatedFormData = cptHealthFormData.copyWith(
        //           reasonId: reasonForNotAchievingCasePlan,
        //           ovcCpimsId: ovcId,
        //           domainId: casePlanProviderDomainList[0].value,
        //         );
        //
        //         context.read<CptProvider>().updateCptFormData(updatedFormData);
        //
        //         // Retrieve the updated CptHealthFormData
        //         CptHealthFormData? healthCptFormData =
        //             context.read<CptProvider>().cptHealthFormData;
        //
        //         // Map the updated CptHealthFormData to CasePlanHealthyModel
        //         CasePlanHealthyModel casePlanModel =
        //             mapCptHealthFormDataToCasePlan(healthCptFormData!);
        //
        //         //map caseplan healthyModelToCasePlanFormModel
        //         CasePlanModel casePlanFormModel =
        //             mapCasePlanHealthyToCasePlan(casePlanModel);
        //
        //         bool isFormSaved =
        //             await CasePlanService.saveCasePlanLocal(casePlanFormModel);
        //         if (isFormSaved) {
        //           Get.snackbar(
        //             'Success',
        //             'Health Case Plan Saved Successfully',
        //             snackPosition: SnackPosition.BOTTOM,
        //             backgroundColor: Colors.green,
        //             colorText: Colors.white,
        //             duration: const Duration(seconds: 2),
        //           );
        //         }
        //       },
        //       text: 'Save',
        //     )),
        //   ],
        // ),
      ],
    );
  }
}


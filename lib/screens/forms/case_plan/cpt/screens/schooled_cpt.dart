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

import '../../../../../Models/case_load_model.dart';
import '../../../../../Models/caseplan_form_model.dart';
import '../../../../../providers/case_plan_provider.dart';
import '../../../../../services/form_service.dart';
import '../../../../../widgets/custom_forms_date_picker.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../../../registry/organisation_units/widgets/steps_wrapper.dart';
import '../models/schooled_cpt_model.dart';
import '../new_cpt_provider.dart';

class SchooledCasePlanTemplate extends StatefulWidget {
  final CaseLoadModel? caseLoadModel;

  SchooledCasePlanTemplate({Key? key, this.caseLoadModel}) : super(key: key);

  @override
  State<SchooledCasePlanTemplate> createState() =>
      _SchooledCasePlanTemplateState();
}

class _SchooledCasePlanTemplateState extends State<SchooledCasePlanTemplate> {
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

  @override
  Widget build(BuildContext context) {
    CptProvider cptProvider = Provider.of<CptProvider>(context);
    TextEditingController _textEditingController = TextEditingController();

    List<ValueItem> casePlanProviderDomainList =
        cptProvider.csAllDomains.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    //schooled
    List<ValueItem> casePlanGoalSchooledList =
        cptProvider.cpGoalsSchool.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanGapsSchooledList =
        cptProvider.cpGapssSchool.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanPrioritiesSchooledList =
        cptProvider.cpPrioritiesSchool.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanServicesSchooledList =
        cptProvider.cpServicesSchool.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanProviderPersonsResponsibleList =
        cptProvider.csPersonsResponsibleList.map((personResponsible) {
      return ValueItem(
          label: "- ${personResponsible['item_description']}",
          value: personResponsible['item_id']);
    }).toList();

    List<ValueItem> casePlanProviderResultList =
        cptProvider.csResultsList.map((resultList) {
      return ValueItem(
          label: "- ${resultList['name']}", value: resultList['id']);
    }).toList();

    return StepsWrapper(
      title: 'Schooled',
      children: [
        const Row(
          children: [
            Text(
              'Date of Case Plan*',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        CustomFormsDatePicker(
          hintText: 'Please select the Date',
          selectedDateTime: currentDateOfCasePlan,
          onDateSelected: (selectedDate) {
            currentDateOfCasePlan = selectedDate;
            CptschooledFormData cptSchooledFormData =
                context.read<CptProvider>().cptschooledFormData ??
                    CptschooledFormData();
            context.read<CptProvider>().updateCptSchooledFormData(
                cptSchooledFormData.copyWith(
                    dateOfEvent: currentDateOfCasePlan.toIso8601String()));
            print("The selected date was $currentDateOfCasePlan");
          },
        ),
        const SizedBox(height: 10),
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
            labelText: 'Label text',
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
            // Ensure that you have a valid CasePlanHealthyModel instance
            CptschooledFormData cptschooledFormData =
                context.read<CptProvider>().cptschooledFormData ??
                    CptschooledFormData();
            context.read<CptProvider>().updateCptSchooledFormData(
                cptschooledFormData.copyWith(goalId: selectedEvents[0].value));
            // Print the updated goalId
            print("The selected goal was ${selectedEvents[0].value}");
          },
          selectedOptions: selectedGoalOptions,
          options: casePlanGoalSchooledList,
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
            CptschooledFormData cptschooledFormData =
                context.read<CptProvider>().cptschooledFormData ??
                    CptschooledFormData();
            context.read<CptProvider>().updateCptSchooledFormData(
                cptschooledFormData.copyWith(gapId: selectedEvents[0].value));
            // Print the updated goalId
            print("The selected need was ${selectedEvents[0].value}");
          },
          options: casePlanGapsSchooledList,
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
            CptschooledFormData cptschooledFormData =
                context.read<CptProvider>().cptschooledFormData ??
                    CptschooledFormData();
            context.read<CptProvider>().updateCptSchooledFormData(
                cptschooledFormData.copyWith(
                    priorityId: selectedEvents[0].value));
            print("The selected priority was ${selectedEvents[0].value}");
          },
          options: casePlanPrioritiesSchooledList,
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
            CptschooledFormData cptschooledFormData =
                context.read<CptProvider>().cptschooledFormData ??
                    CptschooledFormData();
            context
                .read<CptProvider>()
                .updateCptSchooledFormData(cptschooledFormData.copyWith(
                  serviceIds: selectedEvents.map((item) => item.value).toList(),
                ));
            selectedServiceIds =
                selectedEvents.map((item) => item.value).toList();
            print("The selected service IDs are $selectedServiceIds");
          },
          selectedOptions: selectedServicesOptions,
          options: casePlanServicesSchooledList,
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
            CptschooledFormData cptschooledFormData =
                context.read<CptProvider>().cptschooledFormData ??
                    CptschooledFormData();
            context
                .read<CptProvider>()
                .updateCptSchooledFormData(cptschooledFormData.copyWith(
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
            CptschooledFormData cptschooledFormData =
                context.read<CptProvider>().cptschooledFormData ??
                    CptschooledFormData();
            context.read<CptProvider>().updateCptSchooledFormData(
                cptschooledFormData.copyWith(
                    resultsId: selectedEvents[0].value));
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
            CptschooledFormData cptschooledFormData =
                context.read<CptProvider>().cptschooledFormData ??
                    CptschooledFormData();
            context.read<CptProvider>().updateCptSchooledFormData(
                cptschooledFormData.copyWith(
                    completionDate: completionDate.toIso8601String()));
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
          controller: _textEditingController,
        ),
        const SizedBox(height: 10),
        //BUTTON TO SAVE
        Row(
          children: [
            Expanded(
                child: CustomButton(
              text: 'Save',
              onTap: () async {
                String ovcId = widget.caseLoadModel!.cpimsId ?? "";
                reasonForNotAchievingCasePlan =
                    _textEditingController.text.toString();

                CptschooledFormData cptschooledFormData =
                    context.read<CptProvider>().cptschooledFormData ??
                        CptschooledFormData();

                // Update all the fields at once
                CptschooledFormData updatedSafeFormData =
                    cptschooledFormData.copyWith(
                  reasonId: reasonForNotAchievingCasePlan,
                  ovcCpimsId: ovcId,
                  domainId: casePlanProviderDomainList[0].value,
                );

                context
                    .read<CptProvider>()
                    .updateCptSchooledFormData(updatedSafeFormData);

                // Retrieve the updated CptSchooledFormData
                CptschooledFormData? safeCptFormData =
                    context.read<CptProvider>().cptschooledFormData;

                print("The case plan model is $safeCptFormData");

                // Map the updated CptSchooledFormData to CasePlanHealthyModel
                CasePlanschooledModel caseSafePlanModel =
                    mapCptschooledHealthFormDataToCasePlan(safeCptFormData!);

                //map caseplan healthyModelToCasePlanFormModel
                CasePlanModel casePlanFormSafeModel =
                    mapCasePlanschooledToCasePlan(caseSafePlanModel);

                bool isFormSaved = await CasePlanService.saveCasePlanLocal(
                    casePlanFormSafeModel);
                if (isFormSaved) {
                  Get.snackbar(
                    'Success',
                    'Schooled Case Plan Saved Successfully',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    duration: const Duration(seconds: 2),
                  );
                }
              },
              //navigate to the next step
            ))
          ],
        ),
      ],
    );
  }
}

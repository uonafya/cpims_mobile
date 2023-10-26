import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/screens/forms/case_plan/utils/case_plan_dummy_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../../../Models/caseplan_form_model.dart';
import '../../../../../providers/case_plan_provider.dart';
import '../../../../../widgets/custom_forms_date_picker.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../../../registry/organisation_units/widgets/steps_wrapper.dart';

class StableCasePlan extends StatefulWidget {
  const StableCasePlan({super.key});

  @override
  State<StableCasePlan> createState() => _StableCasePlanState();
}

class _StableCasePlanState extends State<StableCasePlan> {
  List<ValueItem> selectedServicesList = [];
  List<ValueItem> selectedPersonsResponsible = [];
  DateTime currentDateOfCasePlan = DateTime.now();
  DateTime completionDate = DateTime.now();
  String reasonForNotAchievingCasePlan= "";

  @override
  Widget build(BuildContext context) {
    CasePlanProvider casePlanProvider = Provider.of<CasePlanProvider>(context);
    TextEditingController _textEditingController = TextEditingController();

    List<ValueItem> casePlanProviderDomainList =
    casePlanProvider.csAllDomains.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanProviderPersonsResponsibleList =
    casePlanProvider.csPersonsResponsibleList.map((personResponsible) {
      return ValueItem(
          label: "- ${personResponsible['item_description']}",
          value: personResponsible['item_id']);
    }).toList();

    List<ValueItem> casePlanProviderResultList =
    casePlanProvider.csResultsList.map((resultList) {
      return ValueItem(
          label: "- ${resultList['name']}", value: resultList['id']);
    }).toList();

    //stable
    List<ValueItem> casePlanGoalStableList =
    casePlanProvider.cpGoalsStable.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanGapsStableList =
    casePlanProvider.cpGapsStable.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanPrioritiesStableList =
    casePlanProvider.cpPrioritiesStable.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanServicesStableList =
    casePlanProvider.cpServicesStable.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    selectedServicesList = casePlanProvider.cpFormData.selectedDomain;
    List<ValueItem> selectedDomain = casePlanProvider.cpFormData.selectedDomain;
    selectedPersonsResponsible =
        casePlanProvider.cpFormData.selectedPersonsResponsible;
    List<ValueItem> selectedGoals = casePlanProvider.cpFormData.selectedGoal;
    List<ValueItem> selectedNeed = casePlanProvider.cpFormData.selectedNeed;
    List<ValueItem> selectedPriorityAction =
        casePlanProvider.cpFormData.selectedPriorityAction;
    List<ValueItem> selectedResult = casePlanProvider.cpFormData.selectedResult;

    List<CasePlanModel> caseplanModelFoThisOvC = [];
    return StepsWrapper(
      title: 'Stable',
      children: [
        const Row(
          children: [
            Text(
              'Date of Case Plan*',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        CustomFormsDatePicker(
          hintText: 'Please select the Date',
          selectedDateTime: currentDateOfCasePlan,
          onDateSelected: (selectedDate) {
            currentDateOfCasePlan = selectedDate;
            casePlanProvider
                .setSelectedDOE(currentDateOfCasePlan);
          },
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Text(
              'Domain*',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Please select the Domains',
          onOptionSelected: (selectedEvents) {
            casePlanProvider
                .setSelectedDomain(selectedEvents);
            // Print the selected domain value
            if (selectedEvents.isNotEmpty) {
              print(
                  "selected Domain: ${selectedEvents[0].value}");
            }
          },
          selectedOptions: selectedDomain,
          options: casePlanProviderDomainList,
          maxItems: 35,
          disabledOptions: const [
            ValueItem(label: 'Option 1', value: '1')
          ],
          selectionType: SelectionType.single,
          chipConfig:
          const ChipConfig(wrapType: WrapType.wrap),
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
              'Goal*',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Please select the Goal',
          onOptionSelected: (selectedEvents) {
            casePlanProvider.setSelectedGoal(selectedEvents);
          },
          selectedOptions:
          casePlanProvider.cpFormData.selectedGoal,
          options: (selectedDomain.isNotEmpty) ? casePlanGoalStableList : List.empty(),

          maxItems: 35,
          disabledOptions: const [
            ValueItem(label: 'Option 1', value: '1')
          ],
          selectionType: SelectionType.single,
          chipConfig:
          const ChipConfig(wrapType: WrapType.wrap),
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
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Please select the Needs/Gaps',
          onOptionSelected: (selectedEvents) {
            casePlanProvider.setSelectedNeed(selectedEvents);
          },
          options: (selectedDomain.isNotEmpty) ? casePlanGapsStableList : List.empty(),
          selectedOptions:
          casePlanProvider.cpFormData.selectedNeed,
          maxItems: 35,
          disabledOptions: const [
            ValueItem(label: 'Option 1', value: '1')
          ],
          selectionType: SelectionType.single,
          chipConfig:
          const ChipConfig(wrapType: WrapType.wrap),
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
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Please select the Priority Actions',
          onOptionSelected: (selectedEvents) {
            casePlanProvider
                .setSelectedPriorityAction(selectedEvents);
            // CustomToastWidget.showToast("selected PA: ${casePlanProvider.cpFormData.selectedPriorityAction[0].value}");
          },
          options: (selectedDomain.isNotEmpty)
              ? casePlanPrioritiesStableList : List.empty(),
          selectedOptions: casePlanProvider
              .cpFormData.selectedPriorityAction,
          maxItems: 35,
          disabledOptions: const [
            ValueItem(label: 'Option 1', value: '1')
          ],
          selectionType: SelectionType.single,
          chipConfig:
          const ChipConfig(wrapType: WrapType.wrap),
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
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Please Select the Services',
          onOptionSelected: (selectedEvents) {
            casePlanProvider
                .setSelectedServicesList(selectedEvents);
            print(
                "selected Services: ${selectedEvents[0].value}");
          },
          selectedOptions:
          casePlanProvider.cpFormData.selectedServices,
          options: (selectedDomain.isNotEmpty)
              ? casePlanServicesStableList : List.empty(),
          maxItems: 13,
          disabledOptions: const [
            ValueItem(label: 'Option 1', value: '1')
          ],
          selectionType: SelectionType.multi,
          chipConfig:
          const ChipConfig(wrapType: WrapType.wrap),
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
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Please select Person(s) Responsible',
          onOptionSelected: (selectedEvents) {
            casePlanProvider
                .setSelectedPersonsList(selectedEvents);
          },
          selectedOptions: casePlanProvider
              .cpFormData.selectedPersonsResponsible,
          options: casePlanProviderPersonsResponsibleList,
          maxItems: 13,
          disabledOptions: const [
            ValueItem(label: 'Option 1', value: '1')
          ],
          selectionType: SelectionType.multi,
          chipConfig:
          const ChipConfig(wrapType: WrapType.wrap),
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
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Please select the Result(s)',
          onOptionSelected: (selectedEvents) {
            casePlanProvider
                .setSelectedResults(selectedEvents);
          },
          options: casePlanProviderResultList,
          maxItems: 13,
          disabledOptions: const [
            ValueItem(label: 'Option 1', value: '1')
          ],
          selectionType: SelectionType.single,
          chipConfig:
          const ChipConfig(wrapType: WrapType.wrap),
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
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        CustomFormsDatePicker(
          hintText: 'Select the date',
          selectedDateTime: completionDate,
          onDateSelected: (selectedDate) {
            completionDate = selectedDate;
            casePlanProvider
                .setSelectedDateToBeCompleted(completionDate);
          },
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Text(
              'Reason(s)',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        CustomTextField(
          hintText: 'Please Write the Reasons',
          controller: _textEditingController
        ),
      ],
    );
  }
}

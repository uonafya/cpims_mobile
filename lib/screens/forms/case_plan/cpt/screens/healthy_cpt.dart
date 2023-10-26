import 'dart:core';

import 'package:cpims_mobile/screens/forms/case_plan/cpt/new_cpt_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import '../../../../../widgets/custom_forms_date_picker.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../../../registry/organisation_units/widgets/steps_wrapper.dart';
import '../models/healthy_cpt_model.dart';

class HealthyCasePlan extends StatefulWidget {
  const HealthyCasePlan({super.key});

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

  @override
  Widget build(BuildContext context) {
    // CasePlanProvider casePlanProvider = Provider.of<CasePlanProvider>(context);
    CptProvider cptProvider = Provider.of<CptProvider>(context);
    TextEditingController _textEditingController = TextEditingController();

    List<ValueItem> casePlanProviderDomainList =
        cptProvider.csAllDomains.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanGoalHealthList =
        cptProvider.cpGoalsHealth.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanGapsHealthList =
        cptProvider.cpGapsHealth.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanPrioritiesHealthList =
        cptProvider.cpPrioritiesHealth.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanServicesHealthList =
        cptProvider.cpServicesHealth.map((domain) {
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
      title: 'Health Domain Case Plan',
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
            CasePlanHealthyModel casePlanHealthyModel =
                context.read<CptProvider>().casePlanHealthyModel ??
                    CasePlanHealthyModel();
            context.read<CptProvider>().casePlanHealthyModel =
                casePlanHealthyModel.copyWith(
                    dateOfEvent: currentDateOfCasePlan.toIso8601String());
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
            CasePlanHealthyModel casePlanHealthyModel =
                context.read<CptProvider>().casePlanHealthyModel ??
                    CasePlanHealthyModel();
            CasePlanHealthyModel updatedModel = casePlanHealthyModel.copyWith(
              services: List.from(
                  casePlanHealthyModel.services ?? []), // Copy the list
            );
            if (updatedModel.services != null &&
                updatedModel.services!.isNotEmpty) {
              updatedModel.services![0] = updatedModel.services![0].copyWith(
                goalId: selectedEvents[0].value,
              );
              selectedGoalOptions = selectedEvents;
            }
            context.read<CptProvider>().casePlanHealthyModel = updatedModel;
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
            CasePlanHealthyModel casePlanHealthyModel =
                context.read<CptProvider>().casePlanHealthyModel ??
                    CasePlanHealthyModel();
            CasePlanHealthyModel updatedModel = casePlanHealthyModel.copyWith(
              services: List.from(
                  casePlanHealthyModel.services ?? []), // Copy the list
            );
            if (updatedModel.services != null &&
                updatedModel.services!.isNotEmpty) {
              updatedModel.services![0] = updatedModel.services![0].copyWith(
                gapId: selectedEvents[0].value,
              );
              selectedGoalOptions = selectedEvents;
            }
            context.read<CptProvider>().casePlanHealthyModel = updatedModel;
            print("The selected gap was ${selectedEvents[0].value}");
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
            CasePlanHealthyModel casePlanHealthyModel =
                context.read<CptProvider>().casePlanHealthyModel ??
                    CasePlanHealthyModel();
            CasePlanHealthyModel updatedModel = casePlanHealthyModel.copyWith(
              services: List.from(
                  casePlanHealthyModel.services ?? []), // Copy the list
            );
            if (updatedModel.services != null &&
                updatedModel.services!.isNotEmpty) {
              updatedModel.services![0] = updatedModel.services![0].copyWith(
                priorityId: selectedEvents[0].value,
              );
              selectedGoalOptions = selectedEvents;
            }
            context.read<CptProvider>().casePlanHealthyModel = updatedModel;
            print("The selected priority was ${selectedEvents[0].value}");
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
            CasePlanHealthyModel casePlanHealthyModel =
                context.read<CptProvider>().casePlanHealthyModel ??
                    CasePlanHealthyModel();
            CasePlanHealthyModel updatedModel = casePlanHealthyModel.copyWith(
              services: List.from(
                  casePlanHealthyModel.services ?? []), // Copy the list
            );

            if (updatedModel.services != null &&
                updatedModel.services!.isNotEmpty) {
              updatedModel.services![0] = updatedModel.services![0].copyWith(
                serviceIds: selectedEvents.map((item) => item.value).toList(),
              );
            }

            context.read<CptProvider>().casePlanHealthyModel = updatedModel;

            // Extract and store just the service IDs
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
            CasePlanHealthyModel casePlanHealthyModel =
                context.read<CptProvider>().casePlanHealthyModel ??
                    CasePlanHealthyModel();
            CasePlanHealthyModel updatedModel = casePlanHealthyModel.copyWith(
              services: List.from(
                  casePlanHealthyModel.services ?? []), // Copy the list
            );

            if (updatedModel.services != null &&
                updatedModel.services!.isNotEmpty) {
              updatedModel.services![0] = updatedModel.services![0].copyWith(
                responsibleIds:
                    selectedEvents.map((item) => item.value).toList(),
              );
            }

            context.read<CptProvider>().casePlanHealthyModel = updatedModel;

            // Extract and store just the service IDs
            selectedPersonResponsibleIds =
                selectedEvents.map((item) => item.value).toList();
            print(
                "The selected person responible is IDs are $selectedPersonResponsibleIds");
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
            CasePlanHealthyModel casePlanHealthyModel =
                context.read<CptProvider>().casePlanHealthyModel ??
                    CasePlanHealthyModel();
            CasePlanHealthyModel updatedModel = casePlanHealthyModel.copyWith(
              services: List.from(
                  casePlanHealthyModel.services ?? []), // Copy the list
            );
            if (updatedModel.services != null &&
                updatedModel.services!.isNotEmpty) {
              updatedModel.services![0] = updatedModel.services![0].copyWith(
                resultsId: selectedEvents[0].value,
              );
              selectedResultsOptions = selectedEvents;
            }
            context.read<CptProvider>().casePlanHealthyModel = updatedModel;
            print("The selected result  was ${selectedEvents[0].value}");
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
            CasePlanHealthyModel casePlanHealthyModel =
                context.read<CptProvider>().casePlanHealthyModel ??
                    CasePlanHealthyModel();
            CasePlanHealthyModel updatedModel = casePlanHealthyModel.copyWith(
              services: List.from(
                  casePlanHealthyModel.services ?? []), // Copy the list
            );
            if (updatedModel.services != null &&
                updatedModel.services!.isNotEmpty) {
              updatedModel.services![0] = updatedModel.services![0].copyWith(
                completionDate: completionDate.toIso8601String(),
              );
              completionDate = selectedDate;
            }
            context.read<CptProvider>().casePlanHealthyModel = updatedModel;
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
      ],
    );
  }
}

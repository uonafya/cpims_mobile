import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/new_cpt_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/custom_forms_date_picker.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../../../registry/organisation_units/widgets/steps_wrapper.dart';
import '../models/stable_cpt_model.dart';

class StableCasePlan extends StatefulWidget {
  final CaseLoadModel caseLoadModel;

  const StableCasePlan({Key? key, required this.caseLoadModel})
      : super(key: key);

  @override
  State<StableCasePlan> createState() => _StableCasePlanState();
}

class _StableCasePlanState extends State<StableCasePlan> {
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
  List<ValueItem> cptProviderDomainList = [];
  List<ValueItem> casePlanGoalStableList = [];
  List<ValueItem> casePlanGapsStableList = [];
  List<ValueItem> casePlanPrioritiesStableList = [];
  List<ValueItem> casePlanServicesStableList = [];
  List<ValueItem> casePlanProviderPersonsResponsibleList = [];
  List<ValueItem> casePlanProviderResultList = [];
  CptProvider cptProvider = CptProvider();

  @override
  void initState() {
    cptProvider = context.read<CptProvider>();
    cptProviderDomainList = cptProvider.csAllDomains.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    casePlanProviderPersonsResponsibleList =
        cptProvider.csPersonsResponsibleList.map((personResponsible) {
      return ValueItem(
          label: "- ${personResponsible['item_description']}",
          value: personResponsible['item_id']);
    }).toList();

    casePlanProviderResultList = cptProvider.csResultsList.map((resultList) {
      return ValueItem(
          label: "- ${resultList['name']}", value: resultList['id']);
    }).toList();

    //stable
    casePlanGoalStableList = cptProvider.cpGoalsStable.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    casePlanGapsStableList = cptProvider.cpGapsStable.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();
    casePlanPrioritiesStableList = cptProvider.cpPrioritiesStable.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    casePlanServicesStableList = cptProvider.cpServicesStable.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    casePlanProviderPersonsResponsibleList =
        cptProvider.csPersonsResponsibleList.map((personResponsible) {
      return ValueItem(
          label: "- ${personResponsible['item_description']}",
          value: personResponsible['item_id']);
    }).toList();

    casePlanProviderResultList = cptProvider.csResultsList.map((resultList) {
      return ValueItem(
          label: "- ${resultList['name']}", value: resultList['id']);
    }).toList();

    // fetching the data from the provider
    CptStableFormData cptStableFormData =
        context.read<CptProvider>().cptStableFormData ?? CptStableFormData();
    if (cptStableFormData.goalId != null) {
      selectedGoalOptions = casePlanGoalStableList
          .where((element) =>
              element.value?.trim().toLowerCase() ==
              cptStableFormData.goalId?.trim().toLowerCase())
          .toList();
    }
    if (cptStableFormData.gapId != null) {
      selectedNeedOptions = casePlanGapsStableList
          .where((element) =>
              element.value?.trim().toLowerCase() ==
              cptStableFormData.gapId?.trim().toLowerCase())
          .toList();
    }
    if (cptStableFormData.priorityId != null) {
      selectedPriorityActionOptions = casePlanPrioritiesStableList
          .where((element) =>
              element.value?.trim().toLowerCase() ==
              cptStableFormData.priorityId?.trim().toLowerCase())
          .toList();
    }
    if (cptStableFormData.serviceIds != null &&
        cptStableFormData.serviceIds!.isNotEmpty) {
      for (String? serviceId in cptStableFormData.serviceIds!) {
        selectedServicesOptions.add(casePlanServicesStableList
            .where((element) =>
                element.value?.trim().toLowerCase() ==
                serviceId?.trim().toLowerCase())
            .toList()[0]);
      }
    }

    if (cptStableFormData.responsibleIds != null &&
        cptStableFormData.responsibleIds!.isNotEmpty) {
      for (String? responsibleId in cptStableFormData.responsibleIds!) {
        selectedPersonsResponsibleOptions.add(
            casePlanProviderPersonsResponsibleList
                .where((element) =>
                    element.value?.trim().toLowerCase() ==
                    responsibleId?.trim().toLowerCase())
                .toList()[0]);
      }
    }

    if (cptStableFormData.resultsId != null) {
      selectedResultsOptions = casePlanProviderResultList
          .where((element) =>
              element.value?.trim().toLowerCase() ==
              cptStableFormData.resultsId?.trim().toLowerCase())
          .toList();
    }

    completionDate = cptStableFormData.completionDate != null
        ? DateTime.parse(cptStableFormData.completionDate!)
        : completionDate;

    textEditingController.text = cptStableFormData.reasonId ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return StepsWrapper(
      title: 'Stable',
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
        //     CptStableFormData cptStableFormData =
        //         context.read<CptProvider>().cptStableFormData ??
        //             CptStableFormData();
        //     context.read<CptProvider>().updateCptStableFormData(
        //         cptStableFormData.copyWith(
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
          initialValue: 'Stable',
          decoration: const InputDecoration(
            labelText: 'Stable',
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
            CptStableFormData cptStableFormData =
                context.read<CptProvider>().cptStableFormData ??
                    CptStableFormData();
            context.read<CptProvider>().updateCptStableFormData(
                cptStableFormData.copyWith(goalId: selectedEvents[0].value));
            // Print the updated goalId
            print("The selected goal was ${selectedEvents[0].value}");
          },
          selectedOptions: selectedGoalOptions,
          options: casePlanGoalStableList,
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
            CptStableFormData cptStableFormData =
                context.read<CptProvider>().cptStableFormData ??
                    CptStableFormData();
            context.read<CptProvider>().updateCptStableFormData(
                cptStableFormData.copyWith(gapId: selectedEvents[0].value));
            // Print the updated goalId
            print("The selected need was ${selectedEvents[0].value}");
          },
          options: casePlanGapsStableList,
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
            CptStableFormData cptStableFormData =
                context.read<CptProvider>().cptStableFormData ??
                    CptStableFormData();
            context.read<CptProvider>().updateCptStableFormData(
                cptStableFormData.copyWith(
                    priorityId: selectedEvents[0].value));
            // Print the updated goalId
            print("The selected prioity was ${selectedEvents[0].value}");
          },
          options: casePlanPrioritiesStableList,
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
            CptStableFormData cptStableFormData =
                context.read<CptProvider>().cptStableFormData ??
                    CptStableFormData();
            context
                .read<CptProvider>()
                .updateCptStableFormData(cptStableFormData.copyWith(
                  serviceIds: selectedEvents.map((item) => item.value).toList(),
                ));
            selectedServiceIds =
                selectedEvents.map((item) => item.value).toList();
            print("The selected service IDs are $selectedServiceIds");
          },
          selectedOptions: selectedServicesOptions,
          options: casePlanServicesStableList,
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
            CptStableFormData cptStableFormData =
                context.read<CptProvider>().cptStableFormData ??
                    CptStableFormData();
            context
                .read<CptProvider>()
                .updateCptStableFormData(cptStableFormData.copyWith(
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
            CptStableFormData cptStableFormData =
                context.read<CptProvider>().cptStableFormData ??
                    CptStableFormData();
            context.read<CptProvider>().updateCptStableFormData(
                cptStableFormData.copyWith(resultsId: selectedEvents[0].value));
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
            CptStableFormData cptStableFormData =
                context.read<CptProvider>().cptStableFormData ??
                    CptStableFormData();
            context.read<CptProvider>().updateCptStableFormData(
                cptStableFormData.copyWith(
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
          controller: textEditingController,
          onChanged: (val) {
            CptStableFormData cptStableFormData =
                context.read<CptProvider>().cptStableFormData ??
                    CptStableFormData();

            CptStableFormData updatedFormData = cptStableFormData.copyWith(
              reasonId: val,
            );
            context
                .read<CptProvider>()
                .updateCptStableFormData(updatedFormData);
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

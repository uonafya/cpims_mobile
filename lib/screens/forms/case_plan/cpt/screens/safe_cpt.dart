import 'package:cpims_mobile/screens/forms/case_plan/cpt/models/safe_cpt_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../../../Models/case_load_model.dart';
import '../../../../../widgets/custom_forms_date_picker.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../../../registry/organisation_units/widgets/steps_wrapper.dart';
import '../new_cpt_provider.dart';

class SafeCasePlan extends StatefulWidget {
  final CaseLoadModel? caseLoadModel;

  const SafeCasePlan({Key? key, this.caseLoadModel}) : super(key: key);

  @override
  State<SafeCasePlan> createState() => _SafeCasePlanState();
}

class _SafeCasePlanState extends State<SafeCasePlan> {
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
  List<ValueItem> casePlanGoalSafeList = [];
  List<ValueItem> casePlanGapsSafeList = [];
  List<ValueItem> casePlanPrioritiesSafeList = [];
  List<ValueItem> casePlanServicesSafeList = [];
  List<ValueItem> casePlanProviderPersonsResponsibleList = [];
  List<ValueItem> casePlanProviderResultList = [];
  CptProvider cptProvider = CptProvider();

  @override
  Widget build(BuildContext context) {
    CptProvider cptProvider = Provider.of<CptProvider>(context);
    TextEditingController textEditingController = TextEditingController();

    //safe
    List<ValueItem> casePlanGoalSafeList =
        cptProvider.cpGoalsSafe.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanGapsSafeList =
        cptProvider.cpGapssSafe.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanPrioritiesSafeList =
        cptProvider.cpPrioritiesSafe.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanServicesSafeList =
        cptProvider.cpServicesSafe.map((domain) {
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

    List<ValueItem> casePlanProviderDomainList =
        cptProvider.csAllDomains.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    // fetching the data from the provider
    CptSafeFormData cptsafeFormData =
        context.read<CptProvider>().cptSafeFormData ?? CptSafeFormData();
    // Update respective fields
    if (cptsafeFormData.goalId != null) {
      selectedGoalOptions = casePlanGoalSafeList
          .where((element) =>
              element.value?.trim().toLowerCase() ==
              cptsafeFormData.goalId?.trim().toLowerCase())
          .toList();
    }
    if (cptsafeFormData.gapId != null) {
      selectedNeedOptions = casePlanGapsSafeList
          .where((element) =>
              element.value?.trim().toLowerCase() ==
              cptsafeFormData.gapId?.trim().toLowerCase())
          .toList();
    }
    if (cptsafeFormData.priorityId != null) {
      selectedPriorityActionOptions = casePlanPrioritiesSafeList
          .where((element) =>
              element.value?.trim().toLowerCase() ==
              cptsafeFormData.priorityId?.trim().toLowerCase())
          .toList();
    }
    if (cptsafeFormData.serviceIds != null &&
        cptsafeFormData.serviceIds!.isNotEmpty) {
      for (String? serviceId in cptsafeFormData.serviceIds!) {
        selectedServicesOptions.add(casePlanServicesSafeList
            .where((element) =>
                element.value?.trim().toLowerCase() ==
                serviceId?.trim().toLowerCase())
            .toList()[0]);
      }
    }

    if (cptsafeFormData.responsibleIds != null &&
        cptsafeFormData.responsibleIds!.isNotEmpty) {
      for (String? responsibleId in cptsafeFormData.responsibleIds!) {
        selectedPersonsResponsibleOptions.add(
            casePlanProviderPersonsResponsibleList
                .where((element) =>
                    element.value?.trim().toLowerCase() ==
                    responsibleId?.trim().toLowerCase())
                .toList()[0]);
      }
    }

    if (cptsafeFormData.resultsId != null) {
      selectedResultsOptions = casePlanProviderResultList
          .where((element) =>
              element.value?.trim().toLowerCase() ==
              cptsafeFormData.resultsId?.trim().toLowerCase())
          .toList();
    }

    completionDate = cptsafeFormData.completionDate != null
        ? DateTime.parse(cptsafeFormData.completionDate!)
        : completionDate;

    textEditingController.text = cptsafeFormData.reasonId ?? "";

    return StepsWrapper(title: 'Safe', children: [
      // const Row(
      //   children: [
      //     // Text(
      //     //   'Date of Case Plan*',
      //     //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      //     // ),
      //   ],
      // ),
      // const SizedBox(height: 10),
      // CustomFormsDatePicker(
      //   hintText: 'Please select the Date',
      //   selectedDateTime: currentDateOfCasePlan,
      //   onDateSelected: (selectedDate) {
      //     currentDateOfCasePlan = selectedDate;
      //     CptSafeFormData cptSafeFormData =
      //         context.read<CptProvider>().cptSafeFormData ?? CptSafeFormData();
      //     context.read<CptProvider>().updateCptSafeFormData(cptSafeFormData
      //         .copyWith(dateOfEvent: currentDateOfCasePlan.toIso8601String()));
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
        initialValue: 'Safe',
        decoration: const InputDecoration(
          labelText: 'Safe',
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
          CptSafeFormData cptSafeFormData =
              context.read<CptProvider>().cptSafeFormData ?? CptSafeFormData();
          context.read<CptProvider>().updateCptSafeFormData(
              cptSafeFormData.copyWith(goalId: selectedEvents[0].value));
          // Print the updated goalId
          print("The selected goal was ${selectedEvents[0].value}");
        },
        selectedOptions: selectedGoalOptions,
        options: casePlanGoalSafeList,
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
          CptSafeFormData cptSafeFormData =
              context.read<CptProvider>().cptSafeFormData ?? CptSafeFormData();
          context.read<CptProvider>().updateCptSafeFormData(
              cptSafeFormData.copyWith(gapId: selectedEvents[0].value));
          // Print the updated goalId
          print("The selected need was ${selectedEvents[0].value}");
        },
        options: casePlanGapsSafeList,
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
          CptSafeFormData cptSafeFormData =
              context.read<CptProvider>().cptSafeFormData ?? CptSafeFormData();
          context.read<CptProvider>().updateCptSafeFormData(
              cptSafeFormData.copyWith(priorityId: selectedEvents[0].value));
          print("The selected priority was ${selectedEvents[0].value}");
        },
        options: casePlanPrioritiesSafeList,
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
          CptSafeFormData cptSafeFormData =
              context.read<CptProvider>().cptSafeFormData ?? CptSafeFormData();
          context
              .read<CptProvider>()
              .updateCptSafeFormData(cptSafeFormData.copyWith(
                serviceIds: selectedEvents.map((item) => item.value).toList(),
              ));
          selectedServiceIds =
              selectedEvents.map((item) => item.value).toList();
          print("The selected service IDs are $selectedServiceIds");
        },
        selectedOptions: selectedServicesOptions,
        options: casePlanServicesSafeList,
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
          CptSafeFormData cptSafeFormData =
              context.read<CptProvider>().cptSafeFormData ?? CptSafeFormData();
          context
              .read<CptProvider>()
              .updateCptSafeFormData(cptSafeFormData.copyWith(
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
          CptSafeFormData cptSafeFormData =
              context.read<CptProvider>().cptSafeFormData ?? CptSafeFormData();
          context.read<CptProvider>().updateCptSafeFormData(
              cptSafeFormData.copyWith(resultsId: selectedEvents[0].value));
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
          CptSafeFormData cptSafeFormData =
              context.read<CptProvider>().cptSafeFormData ?? CptSafeFormData();
          context.read<CptProvider>().updateCptSafeFormData(cptSafeFormData
              .copyWith(completionDate: completionDate.toIso8601String()));
        },
      ),
      const SizedBox(height: 10),
      const Row(
        children: [
          Text(
            'Reasons',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      const SizedBox(height: 10),
      CustomTextField(
        hintText: 'Please Write the Reasons',
        controller: textEditingController,
        onChanged: (val) {
          CptSafeFormData cptSafeFormData =
              context.read<CptProvider>().cptSafeFormData ?? CptSafeFormData();

          CptSafeFormData updatedSafeFormData = cptSafeFormData.copyWith(
            reasonId: val,
          );
          context
              .read<CptProvider>()
              .updateCptSafeFormData(updatedSafeFormData);
        },
      ),
      const SizedBox(height: 10),
      //BUTTON TO SAVE
    ]);
  }
}

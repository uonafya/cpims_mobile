import 'package:cpims_mobile/screens/forms/case_plan/cpt/models/safe_cpt_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import '../models/healthy_cpt_model.dart';
import '../new_cpt_provider.dart';

class SafeCasePlan extends StatefulWidget {
  final CaseLoadModel? caseLoadModel;

  SafeCasePlan({Key? key, this.caseLoadModel}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    CptProvider cptProvider = Provider.of<CptProvider>(context);
    TextEditingController _textEditingController = TextEditingController();

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

    return StepsWrapper(title: 'Safe', children: [
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
          CptHealthFormData cptHealthFormData =
              context.read<CptProvider>().cptHealthFormData ??
                  CptHealthFormData();
          context.read<CptProvider>().updateCptFormData(cptHealthFormData
              .copyWith(dateOfEvent: currentDateOfCasePlan.toIso8601String()));
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
          // Ensure that you have a valid CasePlanHealthyModel instance
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
          // Ensure that you have a valid CasePlanHealthyModel instance
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
          // Ensure that you have a valid CasePlanHealthyModel instance
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
      ElevatedButton(
        onPressed: () async {
          String ovcId = widget.caseLoadModel!.cpimsId ?? "";
          reasonForNotAchievingCasePlan =
              _textEditingController.text.toString();

          CptSafeFormData cptSafeFormData =
              context.read<CptProvider>().cptSafeFormData ?? CptSafeFormData();

          // Update all the fields at once
          CptSafeFormData updatedSafeFormData = cptSafeFormData.copyWith(
            reasonId: reasonForNotAchievingCasePlan,
            ovcCpimsId: ovcId,
            domainId: casePlanProviderDomainList[3].value,
          );

          context
              .read<CptProvider>()
              .updateCptSafeFormData(updatedSafeFormData);

          // Retrieve the updated CptHealthFormData
          CptSafeFormData? safeCptFormData =
              context.read<CptProvider>().cptSafeFormData;

          print("The case plan model is $safeCptFormData");

          // Map the updated CptHealthFormData to CasePlanHealthyModel
          CasePlanSafeModel caseSafePlanModel =
              mapCptSafeHealthFormDataToCasePlan(safeCptFormData!);

          //map caseplan healthyModelToCasePlanFormModel
          CasePlanModel casePlanFormSafeModel =
              mapCasePlanSafeToCasePlan(caseSafePlanModel);

          bool isFormSaved =
              await CasePlanService.saveCasePlanLocal(casePlanFormSafeModel);
          if (isFormSaved) {
            print("The case plan model is $casePlanFormSafeModel");
          }
        },
        child: const Text('Save'),
        //navigate to the next step
      ),
    ]);
  }
}

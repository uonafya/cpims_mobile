import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/new_cpt_provider.dart';
import 'package:cpims_mobile/screens/forms/case_plan/utils/case_plan_dummy_data.dart';
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
import '../../../../../providers/case_plan_provider.dart';
import '../../../../../services/form_service.dart';
import '../../../../../widgets/custom_forms_date_picker.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../../../registry/organisation_units/widgets/steps_wrapper.dart';
import '../models/safe_cpt_model.dart';
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

  @override
  Widget build(BuildContext context) {
    CptProvider cptProvider = Provider.of<CptProvider>(context);
    TextEditingController _textEditingController = TextEditingController();

    List<ValueItem> cptProviderDomainList =
        cptProvider.csAllDomains.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> cptProviderPersonsResponsibleList =
        cptProvider.csPersonsResponsibleList.map((personResponsible) {
      return ValueItem(
          label: "- ${personResponsible['item_description']}",
          value: personResponsible['item_id']);
    }).toList();

    List<ValueItem> cptProviderResultList =
        cptProvider.csResultsList.map((resultList) {
      return ValueItem(
          label: "- ${resultList['name']}", value: resultList['id']);
    }).toList();

    //stable
    List<ValueItem> casePlanGoalStableList =
        cptProvider.cpGoalsStable.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanGapsStableList =
        cptProvider.cpGapsStable.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanPrioritiesStableList =
        cptProvider.cpPrioritiesStable.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanServicesStableList =
        cptProvider.cpServicesStable.map((domain) {
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

    return StepsWrapper(
      title: 'Stable',
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
            CptStableFormData cptStableFormData =
                context.read<CptProvider>().cptStableFormData ??
                    CptStableFormData();
            context.read<CptProvider>().updateCptStableFormData(
                cptStableFormData.copyWith(
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
          controller: _textEditingController,
        ),
        const SizedBox(height: 10),
        //BUTTON TO SAVE
        ElevatedButton(
          onPressed: () async {
            String ovcId = widget.caseLoadModel!.cpimsId ?? "";
            reasonForNotAchievingCasePlan =
                _textEditingController.text.toString();

            CptStableFormData cptStableFormData =
                context.read<CptProvider>().cptStableFormData ??
                    CptStableFormData();

            // Update all the fields at once
            CptStableFormData updatedFormData = cptStableFormData.copyWith(
              reasonId: reasonForNotAchievingCasePlan,
              ovcCpimsId: ovcId,
              domainId: casePlanProviderDomainList[2].value,
            );

            context
                .read<CptProvider>()
                .updateCptStableFormData(updatedFormData);

            // Retrieve the updated CptStableFormData
            CptStableFormData? stableCptFormData =
                context.read<CptProvider>().cptStableFormData;

            print("The case plan model is $stableCptFormData");
            CasePlanStableModel casePlanModel =
                mapCptStableFormDataToCasePlan(stableCptFormData!);
            CasePlanModel casePlanFormModel =
                mapCasePlanStableToCasePlan(casePlanModel);
            bool isFormSaved =
                await CasePlanService.saveCasePlanLocal(casePlanFormModel);
            if (isFormSaved) {
              Get.snackbar(
                'Success',
                'Stable Case Plan Saved Successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
              );
            }
          },
          child: const Text('Save'),
          //navigate to the next step
        ),
      ],
    );
  }
}

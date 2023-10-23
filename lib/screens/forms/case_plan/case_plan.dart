import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/case_plan_provider.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../Models/case_load_model.dart';
import '../../../widgets/custom_toast.dart';

class CasePlanTemplateScreen extends StatefulWidget {
  final CaseLoadModel caseLoadModel;

  const CasePlanTemplateScreen({super.key, required this.caseLoadModel});

  @override
  State<CasePlanTemplateScreen> createState() => _CasePlanTemplateScreenState();
}

class _CasePlanTemplateScreenState extends State<CasePlanTemplateScreen> {
  List<ValueItem> selectedServicesList = [];
  List<ValueItem> selectedPersonsResponsible = [];

  @override
  Widget build(BuildContext context) {
    CasePlanProvider casePlanProvider = Provider.of<CasePlanProvider>(context);

    List<ValueItem> casePlanProviderDomainList =
        casePlanProvider.csDomainList.map((domain) {
      return ValueItem(
          label: "- ${domain['domainName']}", value: domain['domainId']);
    }).toList();

    List<ValueItem> casePlanProviderPriorityActionList =
        casePlanProvider.csPriorityActionList.map((priorityAction) {
      return ValueItem(
          label: "- ${priorityAction['actionName']}",
          value: priorityAction['actionId']);
    }).toList();

    List<ValueItem> casePlanProviderGoalList =
        casePlanProvider.csNeedsList.map((need) {
      return ValueItem(label: "- ${need['needName']}", value: need['needId']);
    }).toList();

    List<ValueItem> casePlanProviderNeedsList =
        casePlanProvider.csGoalList.map((goal) {
      return ValueItem(label: "- ${goal['goalName']}", value: goal['goalId']);
    }).toList();

    List<ValueItem> casePlanProviderServicesList =
        casePlanProvider.csServicesList.map((service) {
      return ValueItem(
          label: "- ${service['serviceName']}", value: service['serviceId']);
    }).toList();

    List<ValueItem> casePlanProviderPersonsResponsibleList =
        casePlanProvider.csPersonsResponsibleList.map((personResponsible) {
      return ValueItem(
          label: "- ${personResponsible['name']}",
          value: personResponsible['id']);
    }).toList();

    List<ValueItem> casePlanProviderResultList =
        casePlanProvider.csResultsList.map((resultList) {
      return ValueItem(
          label: "- ${resultList['name']}", value: resultList['id']);
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

    DateTime currentlySelectedDate = DateTime.now();
    DateTime completionDate = DateTime.now();

    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(height: 20),
          const Text('Forms',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          const Text(
            'Case Plan Template',
            style: TextStyle(color: kTextGrey),
          ),
          const SizedBox(height: 10),
          Consumer<CasePlanProvider>(
              builder: (context, casePlanProvider, child) {
            return Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ]),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      color: Colors.black,
                      child: Text(
                        ' CASE PLAN TEMPLATE \n CPIMS NAMES: ${widget.caseLoadModel.ovcSurname}  ${widget.caseLoadModel.ovcFirstName} \n CPIMS ID: ${widget.caseLoadModel.cpimsId} \n CARE GIVER: ${widget.caseLoadModel.caregiverNames}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
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
                          const CustomDatePicker(
                            hintText: 'Please select the Date',
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
                              print("selected Domain: ${casePlanProvider.cpFormData.selectedDomain[0].value}");
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
                            options: casePlanProviderGoalList,
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
                            options: casePlanProviderNeedsList,
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
                            options: casePlanProviderPriorityActionList,
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
                            },
                            selectedOptions:
                                casePlanProvider.cpFormData.selectedServices,
                            options: casePlanProviderServicesList,
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
                            onOptionSelected: (selectedEvents) {},
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
                          const CustomDatePicker(
                            hintText: 'Select the date',
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
                          const CustomTextField(
                            hintText: 'Please Write the Reasons',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(children: [
                      Expanded(
                        child: CustomButton(
                          text: "Submit",
                          onTap: () async {
                            bool isFormSaved = await casePlanProvider
                                .saveCasaPlanDataLocally();
                            // CustomToastWidget.showToast("Form saved successfully :  ${casePlanProvider.cpFormData.selectedPriorityAction.isEmpty}");
                            if (isFormSaved == true) {
                              CustomToastWidget.showToast(
                                  "Form saved successfully!!");
                              await Future.delayed(const Duration(seconds: 2));
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(children: [
                      Expanded(
                        // Adjust the width value as needed
                        child: CustomButton(
                            text: 'Cancel',
                            color: kTextGrey,
                            onTap: () {
                              Navigator.of(context).pop();
                            }),
                      )
                    ]),
                    const SizedBox(height: 20),
                    // const SizedBox(
                    //     width: 300, // Adjust the width value as needed
                    //     child: HistoryAssessmentListWidget()),
                  ],
                ));
          }),
          const Footer(),
        ],
      ),
    );
  }
}

class HistoryAssessmentListWidget extends StatelessWidget {
  const HistoryAssessmentListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return const AssessmentItemWidget();
        });
  }
}

class AssessmentItemWidget extends StatelessWidget {
  const AssessmentItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Text(
            'Child not Adhering to ARVs',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Expanded(
          child: Text(
            '28-Aug-2023',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 10),
        Icon(
          CupertinoIcons.delete,
          color: Colors.red,
        )
      ],
    );
  }
}

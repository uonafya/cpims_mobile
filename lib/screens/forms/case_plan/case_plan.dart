import 'package:cpims_mobile/Models/caseplan_form_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/case_plan_provider.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:cpims_mobile/widgets/custom_forms_date_picker.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../Models/case_load_model.dart';

class CasePlanTemplateScreen extends StatefulWidget {
  final CaseLoadModel caseLoadModel;

  const CasePlanTemplateScreen({super.key, required this.caseLoadModel});

  @override
  State<CasePlanTemplateScreen> createState() => _CasePlanTemplateScreenState();
}

class _CasePlanTemplateScreenState extends State<CasePlanTemplateScreen> {
  List<ValueItem> selectedServicesList = [];
  List<ValueItem> selectedPersonsResponsible = [];
  DateTime currentDateOfCasePlan = DateTime.now();

  @override
  Widget build(BuildContext context) {
    CasePlanProvider casePlanProvider = Provider.of<CasePlanProvider>(context);
    TextEditingController _textEditingController = TextEditingController();

    List<ValueItem> casePlanProviderDomainList =
        casePlanProvider.csAllDomains.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    //health
    List<ValueItem> casePlanGoalHealthList =
        casePlanProvider.cpGoalsHealth.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanGapsHealthList =
        casePlanProvider.cpGapsHealth.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanPrioritiesHealthList =
        casePlanProvider.cpPrioritiesHealth.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanServicesHealthList =
        casePlanProvider.cpServicesHealth.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    //safe
    List<ValueItem> casePlanGoalSafeList =
        casePlanProvider.cpGoalsSafe.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanGapsSafeList =
        casePlanProvider.cpGapssSafe.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanPrioritiesSafeList =
        casePlanProvider.cpPrioritiesSafe.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanServicesSafeList =
        casePlanProvider.cpServicesSafe.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
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

    //schooled
    List<ValueItem> casePlanGoalSchooledList =
        casePlanProvider.cpGoalsSchool.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanGapsSchooledList =
        casePlanProvider.cpGapssSchool.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanPrioritiesSchooledList =
        casePlanProvider.cpPrioritiesSchool.map((domain) {
      return ValueItem(
          label: "- ${domain['item_description']}", value: domain['item_id']);
    }).toList();

    List<ValueItem> casePlanServicesSchooledList =
        casePlanProvider.cpServicesSchool.map((domain) {
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

    selectedServicesList = casePlanProvider.cpFormData.selectedDomain;
    List<ValueItem> selectedDomain = casePlanProvider.cpFormData.selectedDomain;
    selectedPersonsResponsible =
        casePlanProvider.cpFormData.selectedPersonsResponsible;
    List<ValueItem> selectedGoals = casePlanProvider.cpFormData.selectedGoal;
    List<ValueItem> selectedNeed = casePlanProvider.cpFormData.selectedNeed;
    List<ValueItem> selectedPriorityAction =
        casePlanProvider.cpFormData.selectedPriorityAction;
    List<ValueItem> selectedResult = casePlanProvider.cpFormData.selectedResult;
    // String selectedReason=casePlanProvider.cpFormData.selectedReason;

    List<CasePlanModel> caseplanModelFoThisOvC = [];

    DateTime currentlySelectedDate = DateTime.now();
    DateTime completionDate = DateTime.now();

    void resetDomain() {
      selectedDomain = [];
    }

    void resetResults() {
      casePlanProvider.setSelectedResults([]);
    }

    void resetGoal() {
      casePlanProvider.setSelectedGoal([]); // For multi-select dropdown
    }

    void resetNeed() {
      casePlanProvider.setSelectedNeed([]); // For multi-select dropdown
    }

    void resetPriorityAction() {
      casePlanProvider
          .setSelectedPriorityAction([]); // For multi-select dropdown
    }

    void resetServices() {
      casePlanProvider.setSelectedServicesList([]); // For multi-select dropdown
    }

    void resetPersonsResponsible() {
      casePlanProvider.setSelectedPersonsList([]); // For multi-select dropdown
    }

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
                            options: (selectedDomain.isNotEmpty &&
                                    selectedDomain[0].value == 'DHNU')
                                ? casePlanGoalHealthList
                                : (selectedDomain.isNotEmpty &&
                                        selectedDomain[0].value == 'DPRO')
                                    ? casePlanGoalSafeList
                                    : (selectedDomain.isNotEmpty &&
                                            selectedDomain[0].value == 'DHES')
                                        ? casePlanGoalStableList
                                        : (selectedDomain.isNotEmpty &&
                                                selectedDomain[0].value ==
                                                    'DEDU')
                                            ? casePlanGoalSchooledList
                                            : List.empty(),
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
                            options: (selectedDomain.isNotEmpty &&
                                    selectedDomain[0].value == 'DHNU')
                                ? casePlanGapsHealthList
                                : (selectedDomain.isNotEmpty &&
                                        selectedDomain[0].value == 'DPRO')
                                    ? casePlanGapsSafeList
                                    : (selectedDomain.isNotEmpty &&
                                            selectedDomain[0].value == 'DHES')
                                        ? casePlanGapsStableList
                                        : (selectedDomain.isNotEmpty &&
                                                selectedDomain[0].value ==
                                                    'DEDU')
                                            ? casePlanGapsSchooledList
                                            : List.empty(),
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
                            options: (selectedDomain.isNotEmpty &&
                                    selectedDomain[0].value == 'DHNU')
                                ? casePlanPrioritiesHealthList
                                : (selectedDomain.isNotEmpty &&
                                        selectedDomain[0].value == 'DPRO')
                                    ? casePlanPrioritiesSafeList
                                    : (selectedDomain.isNotEmpty &&
                                            selectedDomain[0].value == 'DHES')
                                        ? casePlanPrioritiesStableList
                                        : (selectedDomain.isNotEmpty &&
                                                selectedDomain[0].value ==
                                                    'DEDU')
                                            ? casePlanPrioritiesSchooledList
                                            : List.empty(),
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
                            options: (selectedDomain.isNotEmpty &&
                                    selectedDomain[0].value == 'DHNU')
                                ? casePlanServicesHealthList
                                : (selectedDomain.isNotEmpty &&
                                        selectedDomain[0].value == 'DPRO')
                                    ? casePlanServicesSafeList
                                    : (selectedDomain.isNotEmpty &&
                                            selectedDomain[0].value == 'DHES')
                                        ? casePlanServicesStableList
                                        : (selectedDomain.isNotEmpty &&
                                                selectedDomain[0].value ==
                                                    'DEDU')
                                            ? casePlanServicesSchooledList
                                            : List.empty(),
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
                            controller: _textEditingController,
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
                            String ovcCpimsId = widget.caseLoadModel.cpimsId!;
                            // String dateOfCaseplan=currentlySelectedDate.toString();
                            //  String dateToBeCompleted=completionDate.toString();
                            //  List<CasePlanServiceModel> servicesList = selectedServicesList.map((e) => CasePlanServiceModel(
                            //    domainId: e.value!,
                            //    serviceIds: selectedServicesList.map((e) => e.value).where((value) => value != null).toList(), // Filter out null values
                            //    goalId: selectedGoals[0].value!,
                            //    gapId: selectedNeed[0].value!,
                            //    priorityId: selectedPriorityAction[0].value!,
                            //    responsibleIds: selectedPersonsResponsible.map((e) => e.value).where((value) => value != null).toList(), // Filter out null values
                            //    resultsId: selectedResult[0].value!,
                            //    reasonId: _textEditingController.text,
                            //    completionDate: dateToBeCompleted,
                            //  )).toList();
                            //
                            //  //caseplan model
                            //  CasePlanModel casePlanModel = CasePlanModel(
                            //    ovcCpimsId: ovcCpimsId,
                            //    dateOfEvent: dateOfCaseplan,
                            //    services: servicesList,
                            //  );
                            //
                            //  print("caseplan model selected: $casePlanModel");

                            bool isFormSaved = await casePlanProvider
                                .saveCasePlanLocally(ovcCpimsId);
                            if (isFormSaved == true) {
                              Get.snackbar(
                                'Success',
                                'Form saved successfully',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                              resetDomain();
                              resetGoal();
                              resetNeed();
                              resetPriorityAction();
                              resetServices();
                              resetPersonsResponsible();
                              resetResults();
                              //exit this page
                              //  Navigator.of(context).pop();
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
                    SizedBox(
                        width: 300, // Adjust the width value as needed
                        child: HistoryAssessmentListWidget(
                            casePlanModelFromDb: caseplanModelFoThisOvC)),
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
  List<CasePlanModel> casePlanModelFromDb;

  HistoryAssessmentListWidget({Key? key, required this.casePlanModelFromDb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 10,
        columns: const <DataColumn>[
          DataColumn(
            label: Text('Domain',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Needs/Gaps',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Priority Actions',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Services',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Responsible',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Completed',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Results',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Reasons',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Action',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          DataColumn(
              label: Text('Delete',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
        ],
        rows: casePlanModelFromDb.map((casePlanModel) {
          return DataRow(
            cells: <DataCell>[
              for (var service in casePlanModel.services)
                DataCell(Text(service.domainId)),
            ],
          );
        }).toList(),
      ),
    );
  }
}

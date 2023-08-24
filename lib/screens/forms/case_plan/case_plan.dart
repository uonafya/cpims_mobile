import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:cpims_mobile/widgets/custom_dropdown_multiselect.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class CasePlanTemplateScreen extends StatefulWidget {
  const CasePlanTemplateScreen({super.key});

  @override
  State<CasePlanTemplateScreen> createState() => _CasePlanTemplateScreenState();
}

class _CasePlanTemplateScreenState extends State<CasePlanTemplateScreen> {
  List<String> typeOfDomain = [
    'Education - (Schooled)',
    'Health and Nutrition - (Healthy)',
    'Economic Strengthening - (Stable)',
    'Protection - (Safe)',
    'Shelter and Care',
  ];
  List<String> selectedEvents = [];
  List<String> selectedValues = [];

  List<String> typeOfEvents = [
    'OCE1 - Child Pregnant',
    'OCE2 - Child not Adhering to ARVs',
    'OCE3 - Child Malnourished',
    'OCE4 - Child HIV status Changed',
    'OCE5 - Child Acquired Opportunistic Infection'
  ];

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 30),
          Container(
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
                    child: const Text(
                      'Case Plan Details',
                      style: TextStyle(color: Colors.white),
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
                          hint: 'Please   select the Domains',
                          onOptionSelected: (selectedEvents) {
                            setState(() {
                              this.selectedEvents =
                                  selectedEvents.cast<String>().toList();
                            });
                          },
                          options: const <ValueItem>[
                            ValueItem(
                                label: 'Education - (Schooled)', value: '1'),
                            ValueItem(
                                label: 'Health and Nutrition - (Healthy)',
                                value: '2'),
                            ValueItem(
                                label: 'Economic Strengthening - (Stable)',
                                value: '3'),
                            ValueItem(label: 'Protection - (Safe)', value: '4'),
                            ValueItem(label: 'Shelter and Care', value: '5'),
                          ],
                          maxItems: 35,
                          disabledOptions: const [
                            ValueItem(label: 'Option 1', value: '1')
                          ],
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
                            setState(() {
                              this.selectedEvents =
                                  selectedEvents.cast<String>().toList();
                            });
                          },
                          options: const <ValueItem>[
                            ValueItem(
                                label: 'Education - (Schooled)', value: '1'),
                            ValueItem(
                                label: 'Health and Nutrition - (Healthy)',
                                value: '2'),
                            ValueItem(
                                label: 'Economic Strengthening - (Stable)',
                                value: '3'),
                            ValueItem(label: 'Protection - (Safe)', value: '4'),
                            ValueItem(label: 'Shelter and Care', value: '5'),
                          ],
                          maxItems: 35,
                          disabledOptions: const [
                            ValueItem(label: 'Option 1', value: '1')
                          ],
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
                            setState(() {
                              this.selectedEvents =
                                  selectedEvents.cast<String>().toList();
                            });
                          },
                          options: const <ValueItem>[
                            ValueItem(
                                label: 'Education - (Schooled)', value: '1'),
                            ValueItem(
                                label: 'Health and Nutrition - (Healthy)',
                                value: '2'),
                            ValueItem(
                                label: 'Economic Strengthening - (Stable)',
                                value: '3'),
                            ValueItem(label: 'Protection - (Safe)', value: '4'),
                            ValueItem(label: 'Shelter and Care', value: '5'),
                          ],
                          maxItems: 35,
                          disabledOptions: const [
                            ValueItem(label: 'Option 1', value: '1')
                          ],
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
                            setState(() {
                              this.selectedEvents =
                                  selectedEvents.cast<String>().toList();
                            });
                          },
                          options: const <ValueItem>[
                            ValueItem(
                                label: 'Education - (Schooled)', value: '1'),
                            ValueItem(
                                label: 'Health and Nutrition - (Healthy)',
                                value: '2'),
                            ValueItem(
                                label: 'Economic Strengthening - (Stable)',
                                value: '3'),
                            ValueItem(label: 'Protection - (Safe)', value: '4'),
                            ValueItem(label: 'Shelter and Care', value: '5'),
                          ],
                          maxItems: 35,
                          disabledOptions: const [
                            ValueItem(label: 'Option 1', value: '1')
                          ],
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
                            setState(() {
                              this.selectedEvents =
                                  selectedEvents.cast<String>().toList();
                            });
                          },
                          options: const <ValueItem>[
                            ValueItem(label: 'Child Pregnant', value: '1'),
                            ValueItem(
                                label: 'Child not Adhering to ARVs',
                                value: '2'),
                            ValueItem(label: 'Child Malnourished', value: '3'),
                            ValueItem(
                                label: 'Child HIV status Changed', value: '4'),
                            ValueItem(
                                label: 'Child Acquired Opportunistic Infection',
                                value: '5'),
                          ],
                          maxItems: 13,
                          disabledOptions: const [
                            ValueItem(label: 'Option 1', value: '1')
                          ],
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
                            setState(() {
                              this.selectedEvents =
                                  selectedEvents.cast<String>().toList();
                            });
                          },
                          options: const <ValueItem>[
                            ValueItem(label: 'Child Pregnant', value: '1'),
                            ValueItem(
                                label: 'Child not Adhering to ARVs',
                                value: '2'),
                            ValueItem(label: 'Child Malnourished', value: '3'),
                            ValueItem(
                                label: 'Child HIV status Changed', value: '4'),
                            ValueItem(
                                label: 'Child Acquired Opportunistic Infection',
                                value: '5'),
                          ],
                          maxItems: 13,
                          disabledOptions: const [
                            ValueItem(label: 'Option 1', value: '1')
                          ],
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
                            setState(() {
                              this.selectedEvents =
                                  selectedEvents.cast<String>().toList();
                            });
                          },
                          options: const <ValueItem>[
                            ValueItem(label: 'Achieved', value: '1'),
                            ValueItem(label: 'Not Achieved', value: '2'),
                          ],
                          maxItems: 13,
                          disabledOptions: const [
                            ValueItem(label: 'Option 1', value: '1')
                          ],
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
                  const Center(
                    child: SizedBox(
                      width: 120,
                      child: CustomButton(
                        text: 'Add',
                        color: kTextGrey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(
                    width: 300, // Adjust the width value as needed
                    child: CustomButton(
                      text: 'Submit Assessment(s)',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    width: 300, // Adjust the width value as needed
                    child: CustomButton(
                      text: 'Cancel',
                      color: kTextGrey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                      width: 300, // Adjust the width value as needed
                      child: HistoryAssessmentListWidget()),
                ],
              )),
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

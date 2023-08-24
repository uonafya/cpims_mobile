import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/form1a_provider.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

class ServicesDetails extends StatefulWidget {
  const ServicesDetails({Key? key}) : super(key: key);

  @override
  State<ServicesDetails> createState() => _ServicesDetailsState();
}

class _ServicesDetailsState extends State<ServicesDetails> {
  List<String> typeOfDomain = [
    'Education - (Schooled)',
    'Health and Nutrition - (Healthy)',
    'Economic Strengthening - (Stable)',
    'Protection - (Safe)',
    'Shelter and Care',
  ];
  List<String> selectedDomain = [];
  List<String> selectedServices = [];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Form1AProvider(),
      child: StepsWrapper(
        title: 'Services',
        children: [
          const Text(
            'Domain*',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          MultiSelectDropDown(
            showClearIcon: true,
            hint: 'Select the Domains',
            onOptionSelected: (selectedDomain) {},
            options: const <ValueItem>[
              ValueItem(label: 'Education - (Schooled)', value: '1'),
              ValueItem(label: 'Health and Nutrition - (Healthy)', value: '2'),
              ValueItem(label: 'Economic Strengthening - (Stable)', value: '3'),
              ValueItem(label: 'Protection - (Safe)', value: '4'),
              ValueItem(label: 'Shelter and Care', value: '5'),
            ],
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
          const Text(
            'Service(s)*',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          MultiSelectDropDown(
            showClearIcon: true,
            hint: 'Select the Services',
            onOptionSelected: (selectedServices) {
              setState(() {});
            },
            options: const <ValueItem>[
              ValueItem(
                  label:
                      'CP22bHEs -Completed referral to access viral load testing services',
                  value: '1'),
              ValueItem(
                  label:
                      'CP23HEs -Provided with transport to clinic appointment',
                  value: '2'),
              ValueItem(
                  label: 'CP24HEs -Provided with appointment reminder messages',
                  value: '3'),
              ValueItem(
                  label:
                      'CP25HEs -Provided with age-appropriate counseling and HIV disclosure support',
                  value: '4'),
              ValueItem(
                  label:
                      'CP26HEs -Provided with age-appropriate HIV treatment literacy',
                  value: '5'),
            ],
            maxItems: 35,
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
          const Text(
            'Date Critical Event Recorded*',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const CustomDatePicker(
            hintText: 'Select the date',
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
            text: 'Add',
            color: kTextGrey,
            onTap: () {},
          ),
          const SizedBox(
            height: 35,
          ),
          const Text(
            'History Assessements',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Details',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  'Date Recorded',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Actions',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(),
          const HistoryAssessmentListWidget()
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

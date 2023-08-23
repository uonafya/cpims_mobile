import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class ServicesDetails extends StatefulWidget {
  const ServicesDetails({super.key});

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
  List<String> selectedEvents = [];

  @override
  Widget build(BuildContext context) {
    return StepsWrapper(
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
          onOptionSelected: (selectedEvents) {
            setState(() {
              this.selectedEvents = selectedEvents.cast<String>().toList();
            });
          },
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
          borderRadius: BorderRadius.circular(5.w).topLeft.x,
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
          onOptionSelected: (selectedEvents) {
            setState(() {
              this.selectedEvents = selectedEvents.cast<String>().toList();
            });
          },
          options: const <ValueItem>[
            ValueItem(
                label:
                    'CP22bHEs -Completed referral to access viral load testing services',
                value: '1'),
            ValueItem(
                label: 'CP23HEs -Provided with transport to clinic appointment',
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
          'Date Of Service*',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const CustomDatePicker(),
        const SizedBox(
          height: 15,
        ),
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
        const CustomButton(text: 'Add', color: kTextGrey),
        const SizedBox(
          height: 35,
        ),
        const Row(
          children: [
            Flexible(
              child: CustomButton(
                text: 'Submit Event(s)',
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: CustomButton(
                text: 'Cancel',
                color: kTextGrey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

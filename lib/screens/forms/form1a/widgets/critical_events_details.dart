import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class CriticalEventsScreen extends StatefulWidget {
  const CriticalEventsScreen({Key? key}) : super(key: key);

  @override
  State<CriticalEventsScreen> createState() => _CriticalEventsScreenState();
}

class _CriticalEventsScreenState extends State<CriticalEventsScreen> {
  List<String> selectedCriticalEvents = [];

  @override
  Widget build(BuildContext context) {
    return StepsWrapper(
      title: 'Events',
      children: [
        const Text(
          'Critical Event(s)*',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        MultiSelectDropDown(
          showClearIcon: true,
          hint: 'Please Critical Event(s)',
          onOptionSelected: (selectedCriticalEvents) {
            setState(() {
              this.selectedCriticalEvents =
                  selectedCriticalEvents.cast<String>().toList();
            });
          },
          options: const <ValueItem>[
            ValueItem(label: 'Child Pregnant', value: '1'),
            ValueItem(label: 'Child not Adhering to ARVs', value: '2'),
            ValueItem(label: 'Child Malnourished', value: '3'),
            ValueItem(label: 'Child HIV status Changed', value: '4'),
            ValueItem(
                label: 'Child Acquired Opportunistic Infection', value: '5'),
          ],
          maxItems: 13,
          selectionType: SelectionType.multi,
          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
          dropdownHeight: 300,
          optionTextStyle: const TextStyle(fontSize: 16),
          selectedOptionIcon: const Icon(Icons.check_circle),
          borderRadius: BorderRadius.circular(5.w).topLeft.x,
        ),
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
        CustomButton(
          text: 'Submit Critical Event(s)',
          onTap: () {},
        ),
        const SizedBox(
          height: 15,
        ),
        CustomButton(
          text: 'Cancel',
          color: kTextGrey,
          onTap: () {
            // logic here
          },
        ),
        const SizedBox(
          height: 15,
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
        const SizedBox(
          height: 15,
        ),
        const HistoryAssessmentListWidget(),
        const SizedBox(
          height: 15,
        ),
      ],
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
        itemCount: 10,
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

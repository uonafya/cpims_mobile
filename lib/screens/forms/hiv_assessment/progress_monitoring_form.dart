import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProgressMonitoringForm extends StatefulWidget {
  const ProgressMonitoringForm({super.key});

  @override
  State<ProgressMonitoringForm> createState() => _ProgressMonitoringFormState();
}

class _ProgressMonitoringFormState extends State<ProgressMonitoringForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "3. PROGRESS MONITORING",
            style: TextStyle(
                color: Colors.blue[900],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("1.Does the parent accept HIV testing for the child?"),
          const SizedBox(
            height: 10,
          ),
          CustomRadioButton(
            isNaAvailable: false,
            optionSelected: (val) {},
          ),
          const CustomDatePicker(
            hintText: "Report Date",
          ),
          const SizedBox(height: 14),
          const Divider(),
          const Text("2. Was a formal referral made for HIV testing?"),
          CustomRadioButton(
            isNaAvailable: false,
            optionSelected: (val) {},
          ),
          const CustomDatePicker(
            hintText: "Report Date",
          ),
          const SizedBox(
            height: 4,
          ),
          const Text("3. Was the referal for HIV testing completed?"),
          const SizedBox(
            height: 4,
          ),
          CustomRadioButton(
            isNaAvailable: false,
            optionSelected: (val) {},
          ),
          const CustomDatePicker(
            hintText: "Report Date",
          ),
          const SizedBox(
            height: 14,
          ),
          const Text("3a. If no (formal referral made), report why not	"),
          const SizedBox(height: 10),
          const CustomTextField(
            hintText: "Response",
          ),
          const SizedBox(
            height: 14,
          ),
          const Text(
              "3b. If yes(formal referral made), ellicit the HIV test result of the child from the caregiver."),
          const SizedBox(height: 10),
          CustomRadioButton(
            isNaAvailable: false,
            optionSelected: (val) {},
          ),
          const SizedBox(
            height: 14,
          ),
          const Text("4. If HIV positive(3b), was the child referred for ART?"),
          const SizedBox(height: 10),
          CustomRadioButton(
            isNaAvailable: false,
            optionSelected: (val) {},
          ),
          const CustomDatePicker(
            hintText: "Report Date",
          ),
          const SizedBox(
            height: 14,
          ),
          const Text("5. If HIV positive(3b), was the ART referral completed?"),
          const SizedBox(height: 10),
          CustomRadioButton(
            isNaAvailable: false,
            optionSelected: (val) {},
          ),
          const CustomDatePicker(
            hintText: "Report Date",
          ),
          const SizedBox(
            height: 14,
          ),
          const Text(
              "6. (If applicable) Record facility of child's ART enrollment	"),
          const SizedBox(height: 10),
          const CustomTextField(
            hintText: "Search for facility here",
          ),
        ],
      ),
    );
  }
}

import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HIVCurrentStatusModel {
  final String dateOfAssessment;
  final String statusOfChild;
  final String hivStatus;
  final String hivTestDone;
  final String hivTestDoneDate;

  HIVCurrentStatusModel({
    required this.dateOfAssessment,
    required this.statusOfChild,
    required this.hivStatus,
    required this.hivTestDone,
    required this.hivTestDoneDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'dateOfAssessment': dateOfAssessment,
      'statusOfChild': statusOfChild,
      'hivStatus': hivStatus,
      'hivTestDone': hivTestDone,
      'hivTestDoneDate': hivTestDoneDate,
    };
  }

  HIVCurrentStatusModel copyWith({
    String? dateOfAssessment,
    String? statusOfChild,
    String? hivStatus,
    String? hivTestDone,
    String? hivTestDoneDate,
  }) {
    return HIVCurrentStatusModel(
      dateOfAssessment: dateOfAssessment ?? this.dateOfAssessment,
      statusOfChild: statusOfChild ?? this.statusOfChild,
      hivStatus: hivStatus ?? this.hivStatus,
      hivTestDone: hivTestDone ?? this.hivTestDone,
      hivTestDoneDate: hivTestDoneDate ?? this.hivTestDoneDate,
    );
  }
}

class HIVCurrentStatusForm extends StatefulWidget {
  const HIVCurrentStatusForm({super.key});

  @override
  State<HIVCurrentStatusForm> createState() => _HIVCurrentStatusFormState();
}

class _HIVCurrentStatusFormState extends State<HIVCurrentStatusForm> {
  HIVCurrentStatusModel? formData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "1. CURRENT HIV STATUS",
            style: TextStyle(
                color: Colors.blue[900],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("1a) Date of assessment"),
          const SizedBox(
            height: 10,
          ),
          CustomDatePicker(initialDate: DateTime.now()),
          const SizedBox(height: 14),
          const Divider(),
          const Text(
              "1b) Does the caregiver know the status of the child? /Does the Adolescent and youth (>15) years know his/her status?"),
          CustomRadioButton(isNaAvailable: false, optionSelected: (val) {}),
          const SizedBox(
            height: 4,
          ),
          const Text("What is the HIV Status"),
          const SizedBox(
            height: 4,
          ),
          CustomRadioButton(
            isNaAvailable: false,
            optionSelected: (val) {},
          ),
          const SizedBox(
            height: 14,
          ),
          const Divider(),
          const Text("1c) Was the HIV test done less than 6 months ago?	"),
          const SizedBox(height: 10),
          CustomRadioButton(isNaAvailable: false, optionSelected: (val) {}),
        ],
      ),
    );
  }
}

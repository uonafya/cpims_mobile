import 'package:cpims_mobile/screens/cpara/provider/hiv_assessment_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_stable_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/widgets/custom_dynamic_radio_button.dart';
import 'package:cpims_mobile/widgets/form_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HIVCurrentStatusModel {
  final String? ovcCPIMSID;
  final DateTime? dateOfAssessment;
  final String? statusOfChild;
  final String? hivStatus;
  final String? hivTestDone;
  final String? hivTestDoneDate;

  HIVCurrentStatusModel({
    this.ovcCPIMSID,
    this.dateOfAssessment,
    this.statusOfChild,
    this.hivStatus,
    this.hivTestDone,
    this.hivTestDoneDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'ovcCPIMSID': ovcCPIMSID,
      'dateOfAssessment': dateOfAssessment,
      'statusOfChild': statusOfChild,
      'hivStatus': hivStatus,
      'hivTestDone': hivTestDone,
      'hivTestDoneDate': hivTestDoneDate,
    };
  }

  HIVCurrentStatusModel copyWith({
    String? ovcCPIMSID,
    DateTime? dateOfAssessment,
    String? statusOfChild,
    String? hivStatus,
    String? hivTestDone,
    String? hivTestDoneDate,
  }) {
    return HIVCurrentStatusModel(
      ovcCPIMSID: ovcCPIMSID ?? this.ovcCPIMSID,
      dateOfAssessment: dateOfAssessment ?? this.dateOfAssessment,
      statusOfChild: statusOfChild ?? this.statusOfChild,
      hivStatus: hivStatus ?? this.hivStatus,
      hivTestDone: hivTestDone ?? this.hivTestDone,
      hivTestDoneDate: hivTestDoneDate ?? this.hivTestDoneDate,
    );
  }
}

class HIVCurrentStatusForm extends StatefulWidget {
  const HIVCurrentStatusForm({
    super.key,
  });

  @override
  State<HIVCurrentStatusForm> createState() => _HIVCurrentStatusFormState();
}

class _HIVCurrentStatusFormState extends State<HIVCurrentStatusForm> {
  DateTime? dateOfAssessment;
  String? statusOfChild;
  String? hivStatus;
  String? hivTestDone;
  String? hivTestDoneDate;

  void handleOnFormSaved() {
    final val = HIVCurrentStatusModel(
      dateOfAssessment: dateOfAssessment,
      statusOfChild: statusOfChild,
      hivStatus: hivStatus,
      hivTestDone: hivTestDone,
      hivTestDoneDate: hivTestDoneDate,
    );
    Provider.of<HIVAssessmentProvider>(context, listen: false)
        .updateHIVCurrentStatusModel(val);
  }

  @override
  Widget build(BuildContext context) {
    final hivAssessmentProvider =
        Provider.of<HIVAssessmentProvider>(context).hivCurrentStatusModel;
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
          FormSection(
            children: [
              const Text("1a) Date of assessment"),
              const SizedBox(
                height: 10,
              ),
              DateTextField(
                label: "Date of assessment",
                enabled: true,
                onDateSelected: (date) {
                  setState(() {
                    dateOfAssessment = date;
                    handleOnFormSaved();
                  });
                },
                identifier: DateTextFieldIdentifier.dateOfAssessment,
              ),
              const SizedBox(height: 14),
            ],
          ),
          const Divider(),
          FormSection(children: [
            const Text(
                "1b) Does the caregiver know the status of the child? /Does the Adolescent and youth (>15) years know his/her status?"),
            CustomRadioButton(
                isNaAvailable: false,
                option: hivAssessmentProvider != null &&
                        hivAssessmentProvider.statusOfChild != null
                    ? convertingStringToRadioButtonOptions(
                        hivAssessmentProvider.statusOfChild!)
                    : null,
                optionSelected: (val) {
                  setState(() {
                    statusOfChild = convertingRadioButtonOptionsToString(val);
                    handleOnFormSaved();
                  });
                }),
          ]),
          FormSection(
            isDisabled: statusOfChild == "No",
            children: [
              const Text("What is the HIV Status"),
              const SizedBox(
                height: 4,
              ),
              CustomDynamicRadioButton(
                isNaAvailable: false,
                optionSelected: (val) {
                  setState(() {
                    hivStatus = val;
                    handleOnFormSaved();
                    if (hivStatus == "HIV_Positive") {
                      Provider.of<HIVAssessmentProvider>(context, listen: false)
                          .clearForms();
                    }
                  });
                },
                option: hivAssessmentProvider != null &&
                        hivAssessmentProvider.hivStatus != null
                    ? hivAssessmentProvider.hivStatus!
                    : null,
                customOptions: const [
                  "HIV_Positive",
                  "HIV_Negative",
                ],
              ),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
          const Divider(),
          FormSection(
            isDisabled: statusOfChild == "No" || hivStatus == "HIV_Positive",
            children: [
              const Text("1c) Was the HIV test done less than 6 months ago?	"),
              const SizedBox(height: 10),
              CustomRadioButton(
                  isNaAvailable: false,
                  option: hivAssessmentProvider != null &&
                          hivAssessmentProvider.hivTestDone != null
                      ? convertingStringToRadioButtonOptions(
                          hivAssessmentProvider.hivTestDone!)
                      : null,
                  optionSelected: (val) {
                    setState(() {
                      hivTestDone = convertingRadioButtonOptionsToString(val);
                      handleOnFormSaved();
                      if (hivTestDone == "Yes") {
                        Provider.of<HIVAssessmentProvider>(context,
                                listen: false)
                            .clearForms();
                      }
                    });
                  }),
            ],
          ),
        ],
      ),
    );
  }
}

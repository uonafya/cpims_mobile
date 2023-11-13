import 'package:cpims_mobile/providers/preventive_assesment_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_stable_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/widgets/custom_dropdown.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/form_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ServiceReferralForm extends StatefulWidget {
  const ServiceReferralForm({super.key});

  @override
  State<ServiceReferralForm> createState() => _ServiceReferralFormState();
}

class _ServiceReferralFormState extends State<ServiceReferralForm> {
  List<String> clientList = [
    "Please select",
    "OVC",
    "Caregiver",
  ];
  List<String> hasCompletedList = [
    "Please select",
    "VMMC",
    "PV/RC",
    "PSS",
    "HTS",
    "LEGALAID",
    "DREAMS",
    "OVC COMPREHENSIVE",
    "Others",
  ];
  String hasServiceOffered = "";
  String client = "Please select";
  String hasCompleted = "Please select";
  TextEditingController otherReasons = TextEditingController();
  String referralCompleted = "";
  String dateOfService = "";

  void updateForm() {
    final provider =
        Provider.of<PreventiveAssessmentProvider>(context, listen: false);
    final data = ServicesReferralFormModel(
      hasServiceOffered: hasServiceOffered,
      client: client,
      hasCompleted: hasCompleted,
      otherReasons: otherReasons.text,
      referralCompleted: referralCompleted,
      dateOfService: dateOfService,
    );

    provider.updateServicesReferralFormModel(data);
  }

  @override
  Widget build(BuildContext context) {
    final formData = Provider.of<PreventiveAssessmentProvider>(context)
        .servicesReferralFormModel;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        children: [
          FormSection(children: [
            const Text("Completed All Session *"),
            CustomRadioButton(
                isNaAvailable: false,
                option: formData.hasServiceOffered.isNotEmpty
                    ? convertingStringToRadioButtonOptions(
                        formData.hasServiceOffered)
                    : null,
                optionSelected: (val) {
                  setState(() {
                    hasServiceOffered =
                        convertingRadioButtonOptionsToString(val);
                    updateForm();
                  });
                }),
            const SizedBox(
              height: 14,
            ),
          ]),
          FormSection(
            children: [
              const Text("Client *"),
              const SizedBox(
                height: 10,
              ),
              CustomDropdown(
                  initialValue: formData.client,
                  items: clientList,
                  onChanged: (val) {
                    setState(() {
                      client = val;
                      updateForm();
                    });
                  }),
              const SizedBox(height: 14),
            ],
          ),
          FormSection(
            children: [
              const Text("Referred/Completed *"),
              const SizedBox(
                height: 10,
              ),
              CustomDropdown(
                  initialValue: formData.hasCompleted,
                  items: hasCompletedList,
                  onChanged: (val) {
                    setState(() {
                      hasCompleted = val;
                    });
                  }),
              const SizedBox(height: 14),
            ],
          ),
          FormSection(
            isDisabled: true,
            children: [
              const Text("Other reasons specified *"),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: otherReasons,
                hintText: formData.otherReasons.isNotEmpty
                    ? formData.otherReasons
                    : "Other services specify",
              ),
              const SizedBox(height: 14),
            ],
          ),
          FormSection(children: [
            const Text("Referral Completed(C)"),
            CustomRadioButton(
                isNaAvailable: false,
                option: formData.referralCompleted.isNotEmpty
                    ? convertingStringToRadioButtonOptions(
                        formData.referralCompleted)
                    : null,
                optionSelected: (val) {
                  setState(() {
                    referralCompleted =
                        convertingRadioButtonOptionsToString(val);
                  });
                }),
            const SizedBox(
              height: 14,
            ),
          ]),
          FormSection(
            children: [
              const Text("Date of service *"),
              const SizedBox(
                height: 10,
              ),
              DateTextField(
                label: formData.dateOfService.isNotEmpty
                    ? formData.dateOfService
                    : "Date of service encounter",
                enabled: true,
                onDateSelected: (date) {
                  setState(() {
                    dateOfService = DateFormat("yyyy-MM-dd").format(date!);
                    updateForm();
                  });
                },
                identifier: DateTextFieldIdentifier.dateOfAssessment,
              ),
              const SizedBox(height: 14),
            ],
          ),
        ],
      ),
    );
  }
}

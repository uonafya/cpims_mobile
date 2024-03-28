import 'package:cpims_mobile/screens/cpara/provider/hiv_assessment_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_stable_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_assessment.dart';
import 'package:cpims_mobile/widgets/custom_dynamic_radio_button.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/form_section.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'hiv_current_status_form.dart';

class ProgressMonitoringModel {
  final String parentAcceptHivTesting;
  final String parentAcceptHivTestingDate;
  final String formalReferralMade;
  final String formalReferralMadeDate;
  final String formalReferralCompleted;
  final String formalReferralCompletedDate;
  String reasonForNotMakingReferral;
  final String hivTestResult;
  final String referredForArt;
  final String referredForArtDate;
  final String artReferralCompleted;
  final String artReferralCompletedDate;
  final String facilityOfArtEnrollment;

  ProgressMonitoringModel({
    this.parentAcceptHivTesting = "",
    this.parentAcceptHivTestingDate = "",
    this.formalReferralMade = "",
    this.formalReferralMadeDate = "",
    this.formalReferralCompleted = "",
    this.formalReferralCompletedDate = "",
    this.reasonForNotMakingReferral = "",
    this.hivTestResult = "",
    this.referredForArt = "",
    this.referredForArtDate = "",
    this.artReferralCompleted = "",
    this.artReferralCompletedDate = "",
    this.facilityOfArtEnrollment = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'HIV_RS_14': parentAcceptHivTesting,
      'HIV_RS_15': parentAcceptHivTestingDate,
      'HIV_RS_16': formalReferralMade,
      'HIV_RS_17': formalReferralMadeDate,
      'HIV_RS_18': formalReferralCompleted,
      'HIV_RS_18A': reasonForNotMakingReferral,
      'HIV_RS_18B': hivTestResult,
      'HIV_RS_21': referredForArt,
      'HIV_RS_22': referredForArtDate,
      'HIV_RS_23': artReferralCompleted,
      'HIV_RS_24': artReferralCompletedDate,
      'HIV_RA_3Q6': facilityOfArtEnrollment,
    };
  }
}

class ProgressMonitoringForm extends StatefulWidget {
  const ProgressMonitoringForm({super.key});

  @override
  State<ProgressMonitoringForm> createState() => _ProgressMonitoringFormState();
}

class _ProgressMonitoringFormState extends State<ProgressMonitoringForm> {
  String parentAcceptHivTesting = "";
  String parentAcceptHivTestingDate = "";
  String formalReferralMade = "";
  String formalReferralMadeDate = "";
  String formalReferralCompleted = "";
  String formalReferralCompletedDate = "";
  String reasonForNotMakingReferral = "A";
  String hivTestResult = "";
  String referredForArt = "";
  String referredForArtDate = "";
  String artReferralCompleted = "";
  String artReferralCompletedDate = "";
  String facilityOfArtEnrollment = "";

  HIVCurrentStatusModel currentStatus = HIVCurrentStatusModel();
  var previousAssessmentController = TextEditingController();

  void handleOnFormSaved() {
    final val = ProgressMonitoringModel(
      parentAcceptHivTesting: parentAcceptHivTesting,
      parentAcceptHivTestingDate: parentAcceptHivTestingDate,
      formalReferralMade: formalReferralMade,
      formalReferralMadeDate: formalReferralMadeDate,
      formalReferralCompleted: formalReferralCompleted,
      formalReferralCompletedDate: formalReferralCompletedDate,
      reasonForNotMakingReferral:
          reasonForNotMakingReferral.isEmpty ? "" : reasonForNotMakingReferral,
      hivTestResult: hivTestResult,
      referredForArt: referredForArt,
      referredForArtDate: referredForArtDate,
      artReferralCompleted: artReferralCompleted,
      artReferralCompletedDate: artReferralCompletedDate,
      facilityOfArtEnrollment: facilityOfArtEnrollment,
    );
    Provider.of<HIVAssessmentProvider>(context, listen: false)
        .updateProgressMonitoringModel(val);
  }

  @override
  void initState() {
    super.initState();
    currentStatus = context.read<HIVAssessmentProvider>().hivCurrentStatusModel;
    final formData =
        context.read<HIVAssessmentProvider>().progressMonitoringModel;

    parentAcceptHivTesting = formData.parentAcceptHivTesting;
    parentAcceptHivTestingDate = formData.parentAcceptHivTestingDate;
    formalReferralMade = formData.formalReferralMade;
    formalReferralMadeDate = formData.formalReferralMadeDate;
    formalReferralCompleted = formData.formalReferralCompleted;
    formalReferralCompletedDate = formData.formalReferralCompletedDate;
    reasonForNotMakingReferral = formData.reasonForNotMakingReferral;
    hivTestResult = formData.hivTestResult;
    referredForArt = formData.referredForArt;
    referredForArtDate = formData.referredForArtDate;
    artReferralCompleted = formData.artReferralCompleted;
    artReferralCompletedDate = formData.artReferralCompletedDate;
    facilityOfArtEnrollment = formData.facilityOfArtEnrollment;
  }

  @override
  Widget build(BuildContext context) {
    final formData =
        context.watch<HIVAssessmentProvider>().progressMonitoringModel;

    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: FormSection(
        isVisibleCondition: () {
          return (currentStatus.statusOfChild == "Yes" &&
              currentStatus.hivStatus == "HIV_Negative" &&
              currentStatus.hivTestDone == "No");
        },
        children: [
          Column(
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
                option: convertingStringToRadioButtonOptions(
                    parentAcceptHivTesting),
                optionSelected: (val) {
                  parentAcceptHivTesting =
                      convertingRadioButtonOptionsToString(val);
                  if (parentAcceptHivTesting == "No") {
                    parentAcceptHivTestingDate = "";
                  }
                  handleOnFormSaved();
                },
              ),
              if (formData.parentAcceptHivTesting == "Yes")
                DateTextField2(
                    label: 'Report Date',
                    enabled: true,
                    initialValue: parentAcceptHivTestingDate ?? "",
                    updateDate: (String? newDate) {
                      parentAcceptHivTestingDate = newDate ??
                          DateFormat("yyyy-MM-dd").format(DateTime.now());
                      handleOnFormSaved();
                    }),
              const SizedBox(height: 14),
              const Divider(),
              const Text("2. Was a formal referral made for HIV testing?"),
              CustomRadioButton(
                isNaAvailable: false,
                option:
                    convertingStringToRadioButtonOptions(formalReferralMade),
                optionSelected: (val) {
                  formalReferralMade =
                      convertingRadioButtonOptionsToString(val);
                  if (formalReferralMade == "No") {
                    formalReferralMadeDate = "";
                  }
                  handleOnFormSaved();
                },
              ),
              if (formData.formalReferralMade == "Yes")
                DateTextField2(
                    label: 'Report Date',
                    enabled: true,
                    initialValue: formalReferralMadeDate ?? "",
                    updateDate: (String? newDate) {
                      formalReferralMadeDate = newDate ??
                          DateFormat("yyyy-MM-dd").format(DateTime.now());
                      handleOnFormSaved();
                    }),
              const SizedBox(
                height: 4,
              ),
              const Text("3. Was the referral for HIV testing completed?"),
              const SizedBox(
                height: 4,
              ),
              CustomRadioButton(
                isNaAvailable: false,
                option: convertingStringToRadioButtonOptions(
                    formalReferralCompleted),
                optionSelected: (val) {
                  formalReferralCompleted =
                      convertingRadioButtonOptionsToString(val);
                  if (formalReferralCompleted == "No") {
                    formalReferralCompletedDate = "";
                    reasonForNotMakingReferral = "";
                  }
                  handleOnFormSaved();
                },
              ),
              if (formData.formalReferralCompleted == "Yes")
                DateTextField2(
                    label: 'Report Date',
                    enabled: true,
                    initialValue: formalReferralCompletedDate ?? "",
                    updateDate: (String? newDate) {
                      formalReferralCompletedDate = newDate ??
                          DateFormat("yyyy-MM-dd").format(DateTime.now());
                      handleOnFormSaved();
                    }),
              const SizedBox(
                height: 14,
              ),
              FormSection(
                isVisibleCondition: () {
                  return formalReferralCompleted == "No";
                },
                children: [
                  const Text(
                      "3a. If no (formal referral made), report why not"),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: "Response",
                    initialValue: reasonForNotMakingReferral,
                    onChanged: (val) {
                      reasonForNotMakingReferral = val;
                      handleOnFormSaved();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              const Text(
                  "3b. If yes(formal referral made), ellicit the HIV test result of the child from the caregiver."),
              const SizedBox(height: 10),
              CustomDynamicRadioButton(
                isNaAvailable: false,
                option: hivTestResult.isNotEmpty ? hivTestResult : null,
                optionSelected: (val) {
                  hivTestResult = val!;
                  if (hivTestResult == "HIV_NEGATIVE") {
                    artReferralCompleted = "";
                    artReferralCompletedDate = "";
                    referredForArt = "";
                    referredForArtDate = "";
                    facilityOfArtEnrollment = "";
                  }
                  handleOnFormSaved();
                },
                customOptions: const [
                  "HIV_Positive",
                  "HIV_NEGATIVE",
                  "HIV_UNKOWN/UNDISCLOSED"
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              FormSection(
                isVisibleCondition: () {
                  return hivTestResult == "HIV_Positive" &&
                      hivTestResult.isNotEmpty;
                },
                children: [
                  const Text(
                      "4. If HIV positive(3b), was the child referred for ART?"),
                  const SizedBox(height: 10),
                  CustomRadioButton(
                    isNaAvailable: false,
                    option:
                        convertingStringToRadioButtonOptions(referredForArt),
                    optionSelected: (val) {
                      referredForArt =
                          convertingRadioButtonOptionsToString(val);
                      if (referredForArt == "No") {
                        referredForArtDate = "";
                      }
                      handleOnFormSaved();
                    },
                  ),
                  if (formData.referredForArt == "Yes")
                    DateTextField2(
                        label: 'Report Date',
                        enabled: true,
                        initialValue: referredForArtDate ?? "",
                        updateDate: (String? newDate) {
                          referredForArtDate = newDate ??
                              DateFormat("yyyy-MM-dd").format(DateTime.now());
                          handleOnFormSaved();
                        }),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              FormSection(
                isVisibleCondition: () {
                  return hivTestResult == "HIV_Positive" &&
                      hivTestResult.isNotEmpty;
                },
                children: [
                  const Text(
                      "5. If HIV positive(3b), was the ART referral completed?"),
                  const SizedBox(height: 10),
                  CustomRadioButton(
                    isNaAvailable: false,
                    option: convertingStringToRadioButtonOptions(
                        artReferralCompleted),
                    optionSelected: (val) {
                      artReferralCompleted =
                          convertingRadioButtonOptionsToString(val);
                      if (artReferralCompleted == "No") {
                        artReferralCompletedDate = "";
                      }
                      handleOnFormSaved();
                    },
                  ),
                  if (formData.artReferralCompleted == "Yes")
                    DateTextField2(
                        label: 'Report Date',
                        enabled: true,
                        initialValue: artReferralCompletedDate ?? "",
                        updateDate: (String? newDate) {
                          artReferralCompletedDate = newDate ??
                              DateFormat("yyyy-MM-dd").format(DateTime.now());
                          handleOnFormSaved();
                        }),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              FormSection(
                isVisibleCondition: () {
                  return hivTestResult == "HIV_Positive" &&
                      hivTestResult.isNotEmpty;
                },
                children: [
                  const Text(
                      "6. (If applicable) Record facility of child's ART enrollment	"),
                  const SizedBox(height: 10),
                  CustomTextField(
                      hintText: "Enter MFL Code",
                      initialValue: facilityOfArtEnrollment,
                      onChanged: (val) {
                        facilityOfArtEnrollment = val;
                        handleOnFormSaved();
                      }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

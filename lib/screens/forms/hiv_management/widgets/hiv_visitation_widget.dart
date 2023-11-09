import 'package:cpims_mobile/providers/hiv_management_form_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_stable_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/models/hiv_management_form_model.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/utils.dart';
import 'package:cpims_mobile/widgets/custom_dynamic_checkbox_widget.dart';
import 'package:cpims_mobile/widgets/custom_dynamic_radio_button.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/form_section.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HIVVisitationWidget extends StatefulWidget {
  const HIVVisitationWidget({super.key});

  @override
  State<HIVVisitationWidget> createState() => _HIVVisitationWidgetState();
}

class _HIVVisitationWidgetState extends State<HIVVisitationWidget> {
  Set<String> selectedOptions = <String>{};

  String visitDate = '';
  String durationOnARTs = '';
  String height = '';
  String mUAC = '';
  String arvDrugsAdherence = '';
  String arvDrugsDuration = '';
  String adherenceCounseling = '';
  String treatmentSupporter = '';
  String treatmentSupporterSex = '';
  String treatmentSupporterAge = '';
  String treatmentSupporterHIVStatus = '';
  String viralLoadResults = '';
  String labInvestigationsDate = '';
  String detectableViralLoadInterventions = '';
  String disclosure = '';
  String mUACScore = '';
  String zScore = '';
  Set<String> nutritionalSupport = const <String>{};
  String supportGroupStatus = '';
  String nhifEnrollment = '';
  String nhifEnrollmentStatus = '';
  String referralServices = '';
  String nextAppointmentDate = '';
  String peerEducatorName = '';
  String peerEducatorContact = '';

  TextEditingController durationOnARTsController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController muACController = TextEditingController();
  TextEditingController arvDrugsDurationController = TextEditingController();
  TextEditingController treatmentSupportAgeController = TextEditingController();
  TextEditingController viralLoadResultsController = TextEditingController();
  TextEditingController zScoreController = TextEditingController();
  TextEditingController referralServicesController = TextEditingController();
  TextEditingController peerEducatorNameController = TextEditingController();
  TextEditingController peerEducatorContactController = TextEditingController();

  void handleOptionsSelected(Set<String> options) {
    setState(() {
      selectedOptions = options;
      nutritionalSupport = selectedOptions;
    });
  }

  void handleOnSave() {
    final formData = HIVVisitationFormModel(
      visitDate: visitDate,
      durationOnARTs: durationOnARTs,
      height: height,
      mUAC: mUAC,
      arvDrugsAdherence:
      arvDrugsAdherence.split(' ').where((s) => s.length > 1).join(' '),
      arvDrugsDuration: arvDrugsDuration,
      adherenceCounseling: adherenceCounseling,
      treatmentSupporter: treatmentSupporter,
      treatmentSupporterSex: treatmentSupporterSex,
      treatmentSupporterAge: treatmentSupporterAge,
      treatmentSupporterHIVStatus: treatmentSupporterHIVStatus,
      viralLoadResults: viralLoadResults,
      labInvestigationsDate: labInvestigationsDate,
      detectableViralLoadInterventions: detectableViralLoadInterventions,
      disclosure: disclosure,
      mUACScore: mUACScore,
      zScore: zScore,
      nutritionalSupport: nutritionalSupport.toList(),
      supportGroupStatus: supportGroupStatus,
      nhifEnrollment: nhifEnrollment,
      nhifEnrollmentStatus: nhifEnrollmentStatus,
      referralServices: referralServices,
      nextAppointmentDate: nextAppointmentDate,
      peerEducatorName: peerEducatorName,
      peerEducatorContact: peerEducatorContact,
    );

    Provider.of<HIVManagementFormProvider>(context, listen: false)
        .updateHIVVisitationModel(formData);
    final isComplete = areAllFieldsFilled();

    if (isComplete) {
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please fill in the required fields"),
          backgroundColor: Colors.red,
        ));
      }
    }

    if (kDebugMode) {
      print(formData.toJson());
    }
  }

  bool areAllFieldsFilled() {
    // Define a list of required fields to check if they are filled in
    final List<String> requiredFields = [
      visitDate,
      durationOnARTs,
      height,
      mUAC,
      arvDrugsAdherence,
      arvDrugsDuration,
      adherenceCounseling,
      treatmentSupporter,
      treatmentSupporterSex,
      treatmentSupporterAge,
      treatmentSupporterHIVStatus,
      viralLoadResults,
      labInvestigationsDate,
      detectableViralLoadInterventions,
      disclosure,
      mUACScore,
      zScore,
      nutritionalSupport.toString(),
      supportGroupStatus,
      nhifEnrollment,
      nhifEnrollmentStatus,
      referralServices,
      nextAppointmentDate,
      peerEducatorName,
      peerEducatorContact,
    ];

    // Check if any required field is empty
    return requiredFields.every((field) => field.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return StepsWrapper(
      title: '2. Visitation',
      children: [
        FormSection(
          children: [
            const Text(
              'Q1) Visit Date',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            DateTextField(
              label: 'Date',
              enabled: true,
              onDateSelected: (date) {
                setState(() {
                  visitDate = formattedDate(date!);
                  handleOnSave();
                });
              },
              identifier: DateTextFieldIdentifier.dateOfAssessment,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q2) Duration on ARTs (in months)	',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: durationOnARTsController,
              onChanged: (val) {
                setState(() {
                  durationOnARTs = durationOnARTsController.text;
                  handleOnSave();
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q3) Height (cm)',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: heightController,
              onChanged: (val) {
                setState(() {
                  height = heightController.text;
                  handleOnSave();
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q4) MUAC',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: muACController,
              onChanged: (val) {
                setState(() {
                  mUAC = muACController.text;
                  handleOnSave();
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q5) ARV drugs - Adherence',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDynamicRadioButton(
              isNaAvailable: false,
              optionSelected: (String? option) {
                setState(() {
                  arvDrugsAdherence = option!;
                  handleOnSave();
                });
              },
              customOptions: const ['Good', 'Fair', 'Poor'],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q6) ARV drugs - Duration for drugs (in months)',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: arvDrugsDurationController,
              onChanged: (val) {
                setState(() {
                  arvDrugsDuration = arvDrugsDurationController.text;
                  handleOnSave();
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q7) Adherence Counseling',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDynamicRadioButton(
              isNaAvailable: false,
              optionSelected: (String? option) {
                setState(() {
                  adherenceCounseling = option!;
                  handleOnSave();
                });
              },
              customOptions: const [
                'Treatment Preparation',
                'Booster Adherence',
                'Enhanced Adherence'
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q8) Treatment supporter',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDynamicRadioButton(
              isNaAvailable: false,
              optionSelected: (String? option) {
                setState(() {
                  treatmentSupporter = option!;
                  handleOnSave();
                });
              },
              customOptions: const [
                'Biological parent',
                'Sibling',
                'Grandparent',
                'Other Relatives',
                'Others'
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q10) Treatment supporter-Sex',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDynamicRadioButton(
              isNaAvailable: false,
              optionSelected: (String? option) {
                setState(() {
                  treatmentSupporterSex = option!;
                  handleOnSave();
                });
              },
              customOptions: const [
                'Male',
                'Female',
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q11) Treatment supporter-Age',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'Age',
              controller: treatmentSupportAgeController,
              onChanged: (val) {
                setState(() {
                  treatmentSupporterAge = treatmentSupportAgeController.text;
                  handleOnSave();
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q12) Treatment supporter-HIV_Status',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDynamicRadioButton(
              isNaAvailable: false,
              optionSelected: (String? option) {
                setState(() {
                  treatmentSupporterHIVStatus = option!;
                });
              },
              customOptions: const [
                'HIV_Positive',
                'HIV_NEGATIVE',
                'HIV_UNKOWN/UNDISCLOSED',
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q13) Lab Investigations-Viral load results',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'Viral Load Results (if LDL enter 1)',
              controller: viralLoadResultsController,
              onChanged: (val) {
                setState(() {
                  viralLoadResults = viralLoadResultsController.text;
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q14) Lab Investigations - Date*',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            DateTextField(
              label: 'Date',
              enabled: true,
              onDateSelected: (date) {
                setState(() {
                  labInvestigationsDate = formattedDate(date!);
                  handleOnSave();
                });
              },
              identifier: DateTextFieldIdentifier.dateOfAssessment,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q15) Detectable (>401 cp/ml)Viral load interventions',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDynamicRadioButton(
              isNaAvailable: false,
              optionSelected: (String? option) {
                setState(() {
                  detectableViralLoadInterventions = option!;
                  handleOnSave();
                });
              },
              customOptions: const [
                'Direct Observed Therapy',
                'Case Conferencing done',
                'Case Plan Reviewed',
                'Discussed Multi-disciplinary Team',
                'Special Support Group',
                'Transport to clinic',
                'HH visit',
                'Disclosure',
                'Escort for Clinic appointments',
                'provision of pill boxes',
                'Provision of alarm watches/clocks',
                'Other'
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q16) Disclosure',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDynamicRadioButton(
              isNaAvailable: false,
              optionSelected: (String? option) {
                setState(() {
                  disclosure = option!;
                  handleOnSave();
                });
              },
              customOptions: const [
                'Not Done',
                'Partial',
                'Full Disclosure',
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q17) Nutritional assessment-MUAC Score',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDynamicRadioButton(
              isNaAvailable: false,
              optionSelected: (String? option) {
                setState(() {
                  mUACScore = option!;
                  handleOnSave();
                });
              },
              customOptions: const [
                'Red',
                'Yellow',
                'Green',
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q18) Nutritional assessment-BMI(Z Score)',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'nutritional assessment',
              controller: zScoreController,
              onChanged: (val) {
                setState(() {
                  zScore = zScoreController.text;
                  handleOnSave();
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q19) Nutritional support',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDynamicCheckBox(
              options: const [
                'Therapeutic Feeding if <2yrs',
                'Infant Feeding Counselling if <2yrs',
                'Food Support',
                'Exclusive Breastfeeding',
                'ExclusiveReplacementFeeding',
                'Mixed Feeding'
              ],
              selectedOptions: selectedOptions,
              optionsSelected: handleOptionsSelected,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q20) Enrolled in support group(status)',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDynamicRadioButton(
              customOptions: const [
                'Active',
                'Dormant',
                'Not Enrolled',
              ],
              isNaAvailable: false,
              optionSelected: (String? option) {
                supportGroupStatus = option!;
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q21) Enrolled in NHIF?',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomRadioButton(
              optionSelected: (RadioButtonOptions? options) {
                setState(() {
                  nhifEnrollment =
                      convertingRadioButtonOptionsToString(options);
                  handleOnSave();
                });
              },
              isNaAvailable: false,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q22) Enrolled in NHIF - Status?',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDynamicRadioButton(
              customOptions: const [
                'Active',
                'Dormant',
              ],
              isNaAvailable: false,
              optionSelected: (String? option) {
                setState(() {
                  nhifEnrollmentStatus = option!;
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q23) Referral services (specify)',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'Services',
              controller: referralServicesController,
              onChanged: (val) {
                setState(() {
                  referralServices = referralServicesController.text;
                  handleOnSave();
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q24) Date of Next Appointment *',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            DateTextField(
              label: 'Date',
              enabled: true,
              allowFutureDates: true,
              identifier: DateTextFieldIdentifier.dateOfAssessment,
              onDateSelected: (DateTime? date) {
                setState(() {
                  nextAppointmentDate = formattedDate(date!);
                  handleOnSave();
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q25) Peer Educator Name',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: peerEducatorNameController,
              onChanged: (val) {
                setState(() {
                  peerEducatorName = peerEducatorNameController.text;
                  handleOnSave();
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        FormSection(
          children: [
            const Text(
              'Q26) Peer Educator Contacts',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: peerEducatorContactController,
              onChanged: (val) {
                setState(() {
                  peerEducatorContact = peerEducatorContactController.text;
                  handleOnSave();
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

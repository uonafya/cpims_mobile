import 'package:cpims_mobile/providers/hiv_management_form_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_stable_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/models/hiv_management_form_model.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:cpims_mobile/widgets/custom_dynamic_checkbox_widget.dart';
import 'package:cpims_mobile/widgets/custom_dynamic_radio_button.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/form_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HIVVisitationWidget extends StatefulWidget {
  const HIVVisitationWidget({super.key});

  @override
  State<HIVVisitationWidget> createState() => _HIVVisitationWidgetState();
}

class _HIVVisitationWidgetState extends State<HIVVisitationWidget> {
  Set<String> selectedOptions = <String>{};

  DateTime? visitDate;
  String? durationOnARTs;
  String? height;
  DateTime? mUAC;
  String? arvDrugsAdherence;
  String? arvDrugsDuration;
  String? adherenceCounseling;
  String? treatmentSupporter;
  String? treatmentSupporterSex;
  String? treatmentSupporterAge;
  String? treatmentSupporterHIVStatus;
  String? viralLoadResults;
  DateTime? labInvestigationsDate;
  String? detectableViralLoadInterventions;
  String? disclosure;
  String? mUACScore;
  String? zScore;
  Set<String>? nutritionalSupport;
  String? supportGroupStatus;
  String? nhifEnrollment;
  String? nhifEnrollmentStatus;
  String? referralServices;
  DateTime? nextAppointmentDate;
  String? peerEducatorName;
  String? peerEducatorContact;

  TextEditingController durationOnARTsController = TextEditingController();
  TextEditingController heightController = TextEditingController();
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
    final formData = HIVManagementFormModel(
      visitDate: visitDate,
      durationOnARTs: durationOnARTs,
      height: height,
      mUAC: mUAC,
      arvDrugsAdherence: arvDrugsAdherence,
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
      nutritionalSupport: nutritionalSupport,
      supportGroupStatus: supportGroupStatus,
      nhifEnrollment: nhifEnrollment,
      nhifEnrollmentStatus: nhifEnrollmentStatus,
      referralServices: referralServices,
      nextAppointmentDate: nextAppointmentDate,
      peerEducatorName: peerEducatorName,
      peerEducatorContact: peerEducatorContact,
    );
    Provider.of<HIVManagementFormProvider>(context, listen: false)
        .updateHIVManagementModel(formData);
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
                  visitDate = date;
                  handleOnSave();
                });
              },
              identifier: DateTextFieldIdentifier.dateOfAssessment,
            ),
          ],
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
        FormSection(
          children: [
            const Text(
              'Q4) MUAC',
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
                  mUAC = date;
                  handleOnSave();
                });
              },
              identifier: DateTextFieldIdentifier.dateOfAssessment,
            ),
          ],
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
                  arvDrugsAdherence = option;
                  handleOnSave();
                });
              },
              customOptions: const ['Good', 'Fair', 'Poor'],
            ),
          ],
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
                  adherenceCounseling = option;
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
                  treatmentSupporter = option;
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
                  treatmentSupporterSex = option;
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
                  treatmentSupporterHIVStatus = option;
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
              label: 'If Yes, Date',
              enabled: true,
              onDateSelected: (date) {
                setState(() {
                  labInvestigationsDate = date;
                  handleOnSave();
                });
              },
              identifier: DateTextFieldIdentifier.dateOfAssessment,
            ),
          ],
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
                  detectableViralLoadInterventions = option;
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
                  disclosure = option;
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
                  mUACScore = option;
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
                supportGroupStatus = option;
              },
            ),
          ],
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
                  nhifEnrollmentStatus = option;
                });
              },
            ),
          ],
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
              identifier: DateTextFieldIdentifier.dateOfAssessment,
              onDateSelected: (DateTime? date) {
                setState(() {
                  nextAppointmentDate = date;
                  handleOnSave();
                });
              },
            ),
          ],
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

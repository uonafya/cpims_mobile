import 'package:cpims_mobile/providers/hiv_management_form_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_stable_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/models/hiv_management_form_model.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/utils/hiv_management_form_status_provider.dart';
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
  late final HivManagementFormModel hivVisitationFormData;

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

  void handleOptionsSelected(Set<String> options) {
    setState(() {
      selectedOptions = options;
      nutritionalSupport = selectedOptions;
    });
  }

  void handleOnSave() {
    // Get the existing instance of HivManagementFormModel from the provider
    final provider = Provider.of<HIVManagementFormProvider>(context, listen: false);

    provider.updateFormHivManagementModel(
      visitDate: visitDate,
        durationOnARTs: durationOnARTs,
      height : height,
      mUAC : mUAC,
      arvDrugsAdherence : arvDrugsAdherence.split(' ').where((s) => s.length > 1).join(' '),
      arvDrugsDuration : arvDrugsDuration,
      adherenceCounseling : adherenceCounseling,
      treatmentSupporter : treatmentSupporter,
      treatmentSupporterSex : treatmentSupporterSex,
      treatmentSupporterAge : treatmentSupporterAge,
      treatmentSupporterHIVStatus :treatmentSupporterHIVStatus,
      viralLoadResults : viralLoadResults,
      labInvestigationsDate : labInvestigationsDate,
      detectableViralLoadInterventions : detectableViralLoadInterventions,
      disclosure : disclosure,
      mUACScore : mUACScore,
      zScore : zScore,
      nutritionalSupport : nutritionalSupport.toList(),
      supportGroupStatus : supportGroupStatus,
      nhifEnrollment : nhifEnrollment,
      nhifEnrollmentStatus : nhifEnrollmentStatus,
      referralServices : referralServices,
      nextAppointmentDate : nextAppointmentDate,
      peerEducatorName : peerEducatorName,
      peerEducatorContact : peerEducatorContact
    );

    // // Notify the provider about the changes
    // Provider.of<HIVManagementFormProvider>(context, listen: false).notifyListeners();
    //
    // final isComplete = areAllFieldsFilled();
    // final formCompletionStatus = context.read<FormCompletionStatusProvider>();
    //
    // if (isComplete) {
    //   formCompletionStatus.setHIVManagementFormCompleted(true);
    // } else {
    //   formCompletionStatus.setHIVManagementFormCompleted(false);
    // }
    //
    // if (kDebugMode) {
    //   print(formModel.toJson());
    // }
  }

  bool areAllFieldsFilled() {
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
  void initState() {
    super.initState();
    hivVisitationFormData = Provider.of<HIVManagementFormProvider>(context, listen: false).hivManagementFormModel;
  }

  @override
  Widget build(BuildContext context) {
    // final hivVisitationFormData =
    //     Provider.of<HIVManagementFormProvider>(context).hivManagementFormModel;
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
            DateTextField2New(
              label: hivVisitationFormData.visitDate.isNotEmpty
                  ? hivVisitationFormData.visitDate
                  : 'Date',
              enabled: true,
              updateDate: (String? newDate) {
                setState(() {
                  visitDate = newDate!;
                });
                debugPrint('Visit Date: $visitDate');
                // HIVManagementFormProvider provider =
                //     Provider.of<HIVManagementFormProvider>(context,
                //         listen: false);
                // HivManagementFormModel updatedModel = provider
                //     .hivManagementFormModel
                //     .copyWith(visitDate: visitDate);
                // provider.updateHIVVisitationModel(updatedModel);
                handleOnSave();
              },
              allowPastDates: true,
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
              keyboardType: TextInputType.number,
              initialValue: hivVisitationFormData.durationOnARTs,
              onChanged: (val) {
                durationOnARTs = val;
                debugPrint('Duration on ARTs: $durationOnARTs');
                handleOnSave();
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
              keyboardType: TextInputType.number,
              initialValue: hivVisitationFormData.height,
              onChanged: (val) {
                height = val;
                debugPrint('Height: $height');
                handleOnSave();
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
              initialValue: hivVisitationFormData.mUAC,
              onChanged: (val) {
                mUAC = val;
                debugPrint('MUAC: $mUAC');
                handleOnSave();
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
              option: hivVisitationFormData.arvDrugsAdherence.isNotEmpty
                  ? convertingStringToRadioButtonOptions(
                          hivVisitationFormData.arvDrugsAdherence)
                      .toString()
                  : null,
              optionSelected: (String? option) {
                setState(() {
                  arvDrugsAdherence = option!;
                  debugPrint('ARV Drugs Adherence: $arvDrugsAdherence');
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
              keyboardType: TextInputType.number,
              initialValue: hivVisitationFormData.arvDrugsDuration,
              onChanged: (val) {
                setState(() {
                  arvDrugsDuration = val;
                  debugPrint('ARV Drugs Duration: $arvDrugsDuration');
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
              option: hivVisitationFormData.adherenceCounseling.isNotEmpty
                  ? hivVisitationFormData.adherenceCounseling
                  : null,
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
              option: hivVisitationFormData.treatmentSupporter.isNotEmpty
                  ? hivVisitationFormData.treatmentSupporter
                  : null,
              optionSelected: (String? option) {
                setState(() {
                  treatmentSupporter = option!;
                  debugPrint('Treatment Supporter: $treatmentSupporter');
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
              option: hivVisitationFormData.treatmentSupporterSex.isNotEmpty
                  ? hivVisitationFormData.treatmentSupporterSex
                  : null,
              optionSelected: (String? option) {
                setState(() {
                  treatmentSupporterSex = option!;
                  debugPrint('Treatment support-sex : $treatmentSupporterSex');
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
              keyboardType: TextInputType.number,
              hintText: 'Age',
              initialValue: hivVisitationFormData.treatmentSupporterAge,
              onChanged: (val) {
                treatmentSupporterAge = val;
                handleOnSave();
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
              option:
                  hivVisitationFormData.treatmentSupporterHIVStatus.isNotEmpty
                      ? hivVisitationFormData.treatmentSupporterHIVStatus
                      : null,
              optionSelected: (String? option) {
                setState(() {
                  treatmentSupporterHIVStatus = option!;
                  handleOnSave();
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
              keyboardType: TextInputType.number,
              hintText: 'Viral Load Results (if LDL enter 1)',
              initialValue: hivVisitationFormData.viralLoadResults,
              onChanged: (val) {
                viralLoadResults = val;
                if (viralLoadResults.isEmpty) {
                  labInvestigationsDate = '';
                }
                debugPrint('Viral Load Results: $viralLoadResults');
                // HIVManagementFormProvider provider =
                //     Provider.of<HIVManagementFormProvider>(context,
                //         listen: false);
                // HivManagementFormModel updatedModel = provider
                //     .hivManagementFormModel
                //     .copyWith(viralLoadResults: viralLoadResults);
                // provider.updateHIVVisitationModel(updatedModel);
                handleOnSave();
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
            // NewDateTextField(
            //   label: hivVisitationFormData.labInvestigationsDate.isNotEmpty
            //       ? hivVisitationFormData.labInvestigationsDate
            //       : 'Date',
            //   enabled: true,
            //   onDateSelected: (date) {
            //     setState(() {
            //       labInvestigationsDate = formattedDate(date!);
            //       handleOnSave();
            //     });
            //   },
            // ),
            DateTextField2New(
              label: hivVisitationFormData.labInvestigationsDate.isNotEmpty
                  ? hivVisitationFormData.labInvestigationsDate
                  : 'Lab Investigations Date',
              enabled: true,
              updateDate: (String? newDate) {
                setState(() {
                  labInvestigationsDate = newDate!;
                });
                debugPrint('Lab Investigations Date: $labInvestigationsDate');
                // HIVManagementFormProvider provider =
                //     Provider.of<HIVManagementFormProvider>(context,
                //         listen: false);
                // HivManagementFormModel updatedModel = provider
                //     .hivManagementFormModel
                //     .copyWith(labInvestigationsDate: labInvestigationsDate);
                // provider.updateHIVVisitationModel(updatedModel);
                handleOnSave();
              },
              allowPastDates: true,
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
              option: hivVisitationFormData
                      .detectableViralLoadInterventions.isNotEmpty
                  ? hivVisitationFormData.detectableViralLoadInterventions
                  : null,
              optionSelected: (String? option) {
                detectableViralLoadInterventions = option!;
                debugPrint(
                    'Detectable Viral Load Interventions: $detectableViralLoadInterventions');
                handleOnSave();
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
              option: hivVisitationFormData.disclosure.isNotEmpty
                  ? hivVisitationFormData.disclosure
                  : null,
              optionSelected: (String? option) {
                disclosure = option!;
                debugPrint('Disclosure: $disclosure');
                handleOnSave();
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
              option: hivVisitationFormData.mUACScore.isNotEmpty
                  ? hivVisitationFormData.mUACScore
                  : null,
              optionSelected: (String? option) {
                mUACScore = option!;
                debugPrint('MUAC Score: $mUACScore');
                handleOnSave();
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
              initialValue: hivVisitationFormData.zScore,
              onChanged: (val) {
                zScore = val;
                debugPrint('Z Score: $zScore');
                handleOnSave();
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
              selectedOptions:
                  hivVisitationFormData.nutritionalSupport.isNotEmpty
                      ? hivVisitationFormData.nutritionalSupport.toSet()
                      : selectedOptions,
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
              option: hivVisitationFormData.supportGroupStatus.isNotEmpty
                  ? hivVisitationFormData.supportGroupStatus
                  : null,
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
                nhifEnrollment = convertingRadioButtonOptionsToString(options);
                handleOnSave();
              },
              option: hivVisitationFormData.nhifEnrollment.isNotEmpty
                  ? convertingStringToRadioButtonOptions(
                      hivVisitationFormData.nhifEnrollment)
                  : null,
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
              option: hivVisitationFormData.nhifEnrollmentStatus.isNotEmpty
                  ? hivVisitationFormData.nhifEnrollmentStatus
                  : null,
              optionSelected: (String? option) {
                nhifEnrollmentStatus = option!;
                handleOnSave();
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
              initialValue: hivVisitationFormData.referralServices,
              onChanged: (val) {
                referralServices = val;
                handleOnSave();
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
            // DateTextField(
            //   label: hivVisitationFormData.nextAppointmentDate.isNotEmpty
            //       ? hivVisitationFormData.nextAppointmentDate
            //       : 'Date',
            //   enabled: true,
            //   allowFutureDates: true,
            //   identifier: DateTextFieldIdentifier.nextAppointmentDate,
            //   onDateSelected: (DateTime? date) {
            //     setState(() {
            //       nextAppointmentDate = formattedDate(date!);
            //       handleOnSave();
            //     });
            //   },
            // ),
            DateTextField2New(
              label: hivVisitationFormData.nextAppointmentDate.isNotEmpty
                  ? hivVisitationFormData.nextAppointmentDate
                  : 'Date',
              enabled: true,
              updateDate: (String? newDate) {
                setState(() {
                  nextAppointmentDate = newDate!;
                });
                debugPrint('Next Appointment Date: $nextAppointmentDate');
                // HIVManagementFormProvider provider =
                //     Provider.of<HIVManagementFormProvider>(context,
                //         listen: false);
                // HivManagementFormModel updatedModel = provider
                //     .hivManagementFormModel
                //     .copyWith(nextAppointmentDate: nextAppointmentDate);
                // provider.updateHIVVisitationModel(updatedModel);
                handleOnSave();
              },
              allowPastDates: true,
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
              initialValue: hivVisitationFormData.peerEducatorName,
              onChanged: (val) {
                peerEducatorName = val;
                debugPrint('Peer Educator Name: $peerEducatorName');
                handleOnSave();
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
              initialValue: hivVisitationFormData.peerEducatorContact,
              onChanged: (val) {
                peerEducatorContact = val;
                debugPrint('Peer Educator Contact: $peerEducatorContact');
                handleOnSave();
              },
            ),
          ],
        ),
      ],
    );
  }
}

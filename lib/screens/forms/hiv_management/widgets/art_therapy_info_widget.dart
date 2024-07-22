import 'package:cpims_mobile/providers/hiv_management_form_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_stable_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/models/hiv_management_form_model.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/utils/hiv_management_form_status_provider.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/utils.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/form_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ARTTherapyInfoWidget extends StatefulWidget {
  const ARTTherapyInfoWidget({
    super.key,
  });

  @override
  State<ARTTherapyInfoWidget> createState() => _ARTTherapyInfoWidgetState();
}

class _ARTTherapyInfoWidgetState extends State<ARTTherapyInfoWidget> {
  late final HivManagementFormModel artTherapyInfoFormData;
  String dateHIVConfirmedPositive = '';
  String dateTreatmentInitiated = '';
  String baselineHEILoad = '';
  String dateStartedFirstLine = '';
  String arvsSubWithFirstLine = '';
  String arvsSubWithFirstLineDate = '';
  String switchToSecondLine = '';
  String switchToSecondLineDate = '';
  String switchToThirdLine = '';
  String switchToThirdLineDate = '';

  void handleOnSave() {
    final provider = Provider.of<HIVManagementFormProvider>(context, listen: false);

    provider.updateFormHivManagementModel(
      dateHIVConfirmedPositive: dateHIVConfirmedPositive,
      dateTreatmentInitiated: dateTreatmentInitiated,
      baselineHEILoad: baselineHEILoad,
      dateStartedFirstLine: dateStartedFirstLine,
      arvsSubWithFirstLine: arvsSubWithFirstLine,
      arvsSubWithFirstLineDate: arvsSubWithFirstLineDate,
      switchToSecondLine: switchToSecondLine,
      switchToSecondLineDate: switchToSecondLineDate,
      switchToThirdLine: switchToThirdLine,
      switchToThirdLineDate: switchToThirdLineDate,
    );
  }

  bool areAllFieldsFilled() {
    final requiredFields = [
      dateHIVConfirmedPositive,
      dateTreatmentInitiated,
      baselineHEILoad,
      dateStartedFirstLine,
      arvsSubWithFirstLine,
      switchToSecondLine,
      switchToThirdLine,
    ];

    return requiredFields.every((field) => field.isNotEmpty);
  }

  @override
  void initState() {
    super.initState();
    artTherapyInfoFormData = Provider.of<HIVManagementFormProvider>(context, listen: false).hivManagementFormModel;

    // handleOnSave();
  }

  @override
  Widget build(BuildContext context) {
    return StepsWrapper(
      title: '1. ARV Therapy Info',
      children: [
        FormSection(
          children: [
            const Text(
              '1) Date Confirmed HIV Positive',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            DateTextField2New(
              label: artTherapyInfoFormData.dateHIVConfirmedPositive.isNotEmpty
                  ? artTherapyInfoFormData.dateHIVConfirmedPositive
                  : 'Date',
              enabled: true,
              updateDate: (String? newDate) {
                setState(() {
                  dateHIVConfirmedPositive = newDate!;
                });
                debugPrint('dateHIVConfirmedPositive: $dateHIVConfirmedPositive');
                // HIVManagementFormProvider provider =
                //     Provider.of<HIVManagementFormProvider>(context,
                //         listen: false);
                // HivManagementFormModel updatedModel =
                //     provider.hivManagementFormModel.copyWith(
                //         dateHIVConfirmedPositive: dateHIVConfirmedPositive);
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
              '2a) Date Initiated on Treatment',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            DateTextField2New(
              label: artTherapyInfoFormData.dateTreatmentInitiated.isNotEmpty
                  ? artTherapyInfoFormData.dateTreatmentInitiated
                  : 'Date',
              enabled: true,
              updateDate: (String? newDate) {
                setState(() {
                  dateTreatmentInitiated = newDate!;
                });
                debugPrint('dateTreatmentInitiated: $dateTreatmentInitiated');
                // HIVManagementFormProvider provider =
                //     Provider.of<HIVManagementFormProvider>(context,
                //         listen: false);
                // HivManagementFormModel updatedModel = provider
                //     .hivManagementFormModel
                //     .copyWith(dateTreatmentInitiated: dateTreatmentInitiated);
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
              '2b) Baseline viral load for HEI',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              initialValue: artTherapyInfoFormData.baselineHEILoad,
              onChanged: (String val) {
                setState(() {
                  baselineHEILoad = val;
                  handleOnSave();
                });
                debugPrint('baselineHEILoad: $baselineHEILoad');
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
              '3) Date started on 1st Line',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            DateTextField2New(
              label: artTherapyInfoFormData.dateStartedFirstLine.isNotEmpty
                  ? artTherapyInfoFormData.dateStartedFirstLine
                  : 'Date',
              enabled: true,
              updateDate: (String? newDate) {
                setState(() {
                  dateStartedFirstLine = newDate!;
                });
                debugPrint('dateStartedFirstLine: $dateStartedFirstLine');
                // HIVManagementFormProvider provider =
                //     Provider.of<HIVManagementFormProvider>(context,
                //         listen: false);
                // HivManagementFormModel updatedModel = provider
                //     .hivManagementFormModel
                //     .copyWith(dateStartedFirstLine: dateStartedFirstLine);
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
              '4) Substitution of ARVs within 1st Line Regimen',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomRadioButton(
              isNaAvailable: false,
              option: artTherapyInfoFormData.arvsSubWithFirstLine.isNotEmpty
                  ? convertingStringToRadioButtonOptions(
                      artTherapyInfoFormData.arvsSubWithFirstLine)
                  : null,
              optionSelected: (options) {
                setState(() {
                  arvsSubWithFirstLine = convertingRadioButtonOptionsToString(options);
                  if (arvsSubWithFirstLine == 'No') {
                    arvsSubWithFirstLineDate = '';
                  }
                  debugPrint('arvsSubWithFirstLine: $arvsSubWithFirstLine');
                  handleOnSave();
                });
              },
            ),
            if (arvsSubWithFirstLine == 'Yes')
              DateTextField2New(
                label:
                    artTherapyInfoFormData.arvsSubWithFirstLineDate.isNotEmpty
                        ? artTherapyInfoFormData.arvsSubWithFirstLineDate
                        : 'If Yes, Date',
                enabled: true,
                updateDate: (String? newDate) {
                  setState(() {
                    arvsSubWithFirstLineDate = newDate!;
                  });
                  debugPrint('arvsSubWithFirstLineDate: $arvsSubWithFirstLineDate');
                  // HIVManagementFormProvider provider =
                  //     Provider.of<HIVManagementFormProvider>(context,
                  //         listen: false);
                  // HivManagementFormModel updatedModel =
                  //     provider.hivManagementFormModel.copyWith(
                  //         arvsSubWithFirstLineDate: arvsSubWithFirstLineDate);
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
              '5) Switch to 2nd Line (or Substitute within 2nd Line)',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomRadioButton(
              isNaAvailable: false,
              option: artTherapyInfoFormData.switchToSecondLine.isNotEmpty
                  ? convertingStringToRadioButtonOptions(
                      artTherapyInfoFormData.switchToSecondLine)
                  : null,
              optionSelected: (RadioButtonOptions? options) {
                setState(() {
                  switchToSecondLine =
                      convertingRadioButtonOptionsToString(options);
                  if (switchToSecondLine == 'No') {
                    switchToSecondLineDate = '';
                  }
                  debugPrint('switchToSecondLine: $switchToSecondLine');
                  handleOnSave();
                });
              },
            ),
            if (switchToSecondLine == 'Yes')
              DateTextField2New(
                label: artTherapyInfoFormData.switchToSecondLineDate.isNotEmpty
                    ? artTherapyInfoFormData.switchToSecondLineDate
                    : 'If Yes, Date',
                enabled: true,
                updateDate: (String? newDate) {
                  setState(() {
                    switchToSecondLineDate = newDate!;
                  });
                  debugPrint('switchToSecondLineDate: $switchToSecondLineDate');
                  // HIVManagementFormProvider provider =
                  //     Provider.of<HIVManagementFormProvider>(context,
                  //         listen: false);
                  // HivManagementFormModel updatedModel = provider
                  //     .hivManagementFormModel
                  //     .copyWith(switchToSecondLineDate: switchToSecondLineDate);
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
              '6) Switch to 3rd Line (or Substitute within 3nd Line)',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomRadioButton(
              isNaAvailable: false,
              option: artTherapyInfoFormData.switchToThirdLine.isNotEmpty
                  ? convertingStringToRadioButtonOptions(
                      artTherapyInfoFormData.switchToThirdLine)
                  : null,
              optionSelected: (RadioButtonOptions? options) {
                setState(() {
                  switchToThirdLine =
                      convertingRadioButtonOptionsToString(options);
                  if (switchToThirdLine == 'No') {
                    switchToThirdLineDate = '';
                  }
                  debugPrint('switchToThirdLine: $switchToThirdLine');
                  handleOnSave();
                });
              },
            ),
            if (switchToThirdLine == 'Yes')
              // DateTextField(
              //   label: artTherapyInfoFormData.switchToThirdLineDate.isNotEmpty
              //       ? artTherapyInfoFormData.switchToThirdLineDate
              //       : 'If Yes, Date',
              //   enabled: switchToThirdLine == "Yes",
              //   onDateSelected: (date) {
              //     setState(() {
              //       switchToThirdLineDate = formattedDate(date!);
              //       handleOnSave();
              //     });
              //   },
              //   identifier: DateTextFieldIdentifier.switchToThirdLineDate,
              // ),
              DateTextField2New(
                label: artTherapyInfoFormData.switchToThirdLineDate.isNotEmpty
                    ? artTherapyInfoFormData.switchToThirdLineDate
                    : 'If Yes, Date',
                enabled: true,
                updateDate: (String? newDate) {
                  setState(() {
                    switchToThirdLineDate = newDate!;
                  });
                  debugPrint('switchToThirdLineDate: $switchToThirdLineDate');
                  // HIVManagementFormProvider provider =
                  //     Provider.of<HIVManagementFormProvider>(context,
                  //         listen: false);
                  // HivManagementFormModel updatedModel = provider
                  //     .hivManagementFormModel
                  //     .copyWith(switchToThirdLineDate: switchToThirdLineDate);
                  // provider.updateHIVVisitationModel(updatedModel);
                  handleOnSave();
                },
                allowPastDates: true,
              ),
          ],
        ),
      ],
    );
  }
}

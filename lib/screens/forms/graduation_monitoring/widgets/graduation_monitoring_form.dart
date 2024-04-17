import 'package:cpims_mobile/providers/app_meta_data_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/forms/graduation_monitoring/provider/graduation_monitoring_provider.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../Models/case_load_model.dart';
import '../../../../constants.dart';
import '../../../../widgets/custom_dynamic_radio_button.dart';
import '../../../../widgets/drawer.dart';
import '../../../../widgets/footer.dart';
import '../../../cpara/widgets/cpara_details_widget.dart';
import '../../../cpara/widgets/cpara_stable_widget.dart';
import '../model/graduation_monitoring_form_model.dart';

class GraduationMonitoringFormScreen extends StatefulWidget {
  final CaseLoadModel caseLoad;

  const GraduationMonitoringFormScreen({
    super.key,
    required this.caseLoad,
  });

  @override
  State<GraduationMonitoringFormScreen> createState() =>
      _GraduationMonitoringFormScreenState();
}

class _GraduationMonitoringFormScreenState
    extends State<GraduationMonitoringFormScreen> {
  late final GraduationMonitoringFormModel graduationMonitoringFormModel;
  String formType = '';
  String dateOfMonitoring = '';
  String? benchmark1;
  String? benchmark2;
  String? benchmark3;
  String? benchmark4;
  String? benchmark5;
  String? benchmark6;
  String? benchmark7;
  String? benchmark8;
  String? benchmark9;
  String? householdReadyToExit;
  String? caseDeterminedReadyForClosure;

  bool isLoading = false;

  void handleOnFormSave() {
    final graduationModel =
        Provider.of<GraduationMonitoringProvider>(context, listen: false)
            .graduationMonitoringFormModel;

    graduationModel.formType = formType;
    graduationModel.dateOfMonitoring = dateOfMonitoring;
    graduationModel.benchmark1 = benchmark1;
    graduationModel.benchmark2 = benchmark2;
    graduationModel.benchmark3 = benchmark3;
    graduationModel.benchmark4 = benchmark4;
    graduationModel.benchmark5 = benchmark5;
    graduationModel.benchmark6 = benchmark6;
    graduationModel.benchmark7 = benchmark7;
    graduationModel.benchmark8 = benchmark8;
    graduationModel.benchmark9 = benchmark9;
    graduationModel.householdReadyToExit = householdReadyToExit;
    graduationModel.caseDeterminedReadyForClosure =
        caseDeterminedReadyForClosure;

    Provider.of<GraduationMonitoringProvider>(context, listen: false)
        .notifyListeners();

    if (kDebugMode) {
      print(graduationModel.toMap());
    }
  }

  bool _validateForm() {
    if (formType.isEmpty ||
        dateOfMonitoring.isEmpty ||
        benchmark1 == null ||
        benchmark2 == null ||
        benchmark3 == null ||
        benchmark4 == null ||
        benchmark5 == null ||
        benchmark6 == null ||
        benchmark7 == null ||
        benchmark8 == null ||
        benchmark9 == null ||
        householdReadyToExit == null ||
        caseDeterminedReadyForClosure == null) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    graduationMonitoringFormModel =
        Provider.of<GraduationMonitoringProvider>(context, listen: false)
            .graduationMonitoringFormModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(height: 20),
          const Text('GRADUATION MONITORING',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          const Text(
            'Monitoring tool for OVC Households reaching case plan achievement',
            style: TextStyle(color: kTextGrey),
          ),
          const SizedBox(height: 30),
          Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ]),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    color: Colors.black,
                    child: Text(
                      'GRADUATION MONITORING \n CARE GIVER: ${widget.caseLoad.caregiverNames} \n CPIMS ID: ${widget.caseLoad.cpimsId}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        DateTextField2New(
                          label: 'Date of Monitoring',
                          enabled: true,
                          updateDate: (String? newDate) {
                            setState(() {
                              dateOfMonitoring = newDate!;
                            });

                            GraduationMonitoringProvider provider =
                            Provider.of<GraduationMonitoringProvider>(context, listen: false);
                            provider.updateGraduationMonitoringModel(
                              GraduationMonitoringFormModel(dateOfMonitoring: dateOfMonitoring),
                            );
                          },
                          allowPastDates: true,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Form Type: *',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        CustomDynamicRadioButtonNew(
                          isNaAvailable: false,
                          option:
                              graduationMonitoringFormModel.formType != null &&
                                      graduationMonitoringFormModel
                                          .formType!.isNotEmpty
                                  ? graduationMonitoringFormModel.formType
                                  : null,
                          optionSelected: (String? option) {
                            formType = option!;
                            handleOnFormSave();
                          },
                          customOptions: const [
                            'Benchmark Monitoring',
                            'Households Reaching Case Plan Achievement',
                          ],
                          valueOptions: const [
                            'BM',
                            'HA',
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Benchmark 1: All children, adolescents, and caregivers in the household have known HIV status or a test is not required based on risk assessment *',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        CustomDynamicRadioButtonNew(
                          isNaAvailable: false,
                          option: graduationMonitoringFormModel.benchmark1,
                          optionSelected: (String? option) {
                            benchmark1 = option;
                            handleOnFormSave();
                          },
                          customOptions: const [
                            'Yes',
                            'No',
                          ],
                          valueOptions: const [
                            'AYES',
                            'ANNO',
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Benchmark 2: All HIV+ children, adolescents, and caregivers in the household with a viral load result documented in the medical record and/or laboratory information systems (LIS) have been virally suppressed for the last 12 months.*',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        CustomDynamicRadioButtonNew(
                          isNaAvailable: false,
                          option: graduationMonitoringFormModel.benchmark2,
                          optionSelected: (String? option) {
                            benchmark2 = option;
                            handleOnFormSave();
                          },
                          customOptions: const [
                            'Yes',
                            'No',
                          ],
                          valueOptions: const [
                            'AYES',
                            'ANNO',
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Benchmark 3: All adolescents 10-17 years of age in the household have key knowledge about preventing HIV infection *',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        CustomDynamicRadioButtonNew(
                          isNaAvailable: false,
                          option: graduationMonitoringFormModel.benchmark3,
                          optionSelected: (String? option) {
                            benchmark3 = option;
                            handleOnFormSave();
                          },
                          customOptions: const [
                            'Yes',
                            'No',
                          ],
                          valueOptions: const [
                            'AYES',
                            'ANNO',
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Benchmark 4: No children < 5 years in the household are undernourished *',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        CustomDynamicRadioButtonNew(
                          isNaAvailable: false,
                          option: graduationMonitoringFormModel.benchmark4,
                          optionSelected: (String? option) {
                            benchmark4 = option;
                            handleOnFormSave();
                          },
                          customOptions: const [
                            'Yes',
                            'No',
                          ],
                          valueOptions: const [
                            'AYES',
                            'ANNO',
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Benchmark 5: Caregivers are able to access money (without selling productive assets) to pay for school fees, medical costs (buy medicine, transport to facility etc), legal and other administrative fees (related to guardianship, civil registration, or inheritance) for children 0-17 years*',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        CustomDynamicRadioButtonNew(
                          isNaAvailable: false,
                          option: graduationMonitoringFormModel.benchmark5,
                          optionSelected: (String? option) {
                            benchmark5 = option;
                            handleOnFormSave();
                          },
                          customOptions: const [
                            'Yes',
                            'No',
                          ],
                          valueOptions: const [
                            'AYES',
                            'ANNO',
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Benchmark 6: No children, adolescents, and caregivers in the household report experiences of violence (including physical violence, emotional violence, sexual violence, gender-based violence, and neglect) in the last six months.*',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        CustomDynamicRadioButtonNew(
                          isNaAvailable: false,
                          option: graduationMonitoringFormModel.benchmark6,
                          optionSelected: (String? option) {
                            benchmark6 = option;
                            handleOnFormSave();
                          },
                          customOptions: const [
                            'Yes',
                            'No',
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Benchmark 7: All children and adolescents in the household are under the care of a stable adult caregiver*',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        CustomDynamicRadioButtonNew(
                          isNaAvailable: false,
                          option: graduationMonitoringFormModel.benchmark7,
                          optionSelected: (String? option) {
                            benchmark7 = option;
                            handleOnFormSave();
                          },
                          customOptions: const [
                            'Yes',
                            'No',
                          ],
                          valueOptions: const [
                            'AYES',
                            'ANNO',
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Benchmark 8: All children <18 years have legal proof of identity*',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        CustomDynamicRadioButtonNew(
                          isNaAvailable: false,
                          option: graduationMonitoringFormModel.benchmark8,
                          optionSelected: (String? option) {
                            benchmark8 = option;
                            handleOnFormSave();
                          },
                          customOptions: const [
                            'Yes',
                            'No',
                          ],
                          valueOptions: const [
                            'AYES',
                            'ANNO',
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Benchmark 9: All school-aged children (4-17) and adolescents aged 18-20 enrolled in secondary school in the household regularly attended school and progressed during the last year. *',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        CustomDynamicRadioButtonNew(
                          isNaAvailable: false,
                          option: graduationMonitoringFormModel.benchmark9,
                          optionSelected: (String? option) {
                            benchmark9 = option;
                            handleOnFormSave();
                          },
                          customOptions: const [
                            'Yes',
                            'No',
                          ],
                          valueOptions: const [
                            'AYES',
                            'ANNO',
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Household is still ready to successfully exit (Case plan achievement):*',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        CustomDynamicRadioButtonNew(
                          isNaAvailable: false,
                          option: graduationMonitoringFormModel
                              .householdReadyToExit,
                          optionSelected: (String? option) {
                            householdReadyToExit = option;
                            handleOnFormSave();
                          },
                          customOptions: const [
                            'Yes',
                            'No',
                          ],
                          valueOptions: const [
                            'AYES',
                            'ANNO',
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Case determined ready for closure:*',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        CustomDynamicRadioButtonNew(
                          isNaAvailable: false,
                          option: graduationMonitoringFormModel
                              .caseDeterminedReadyForClosure,
                          optionSelected: (String? option) {
                            caseDeterminedReadyForClosure = option;
                            handleOnFormSave();
                          },
                          customOptions: const [
                            'Yes',
                            'No',
                          ],
                          valueOptions: const [
                            'AYES',
                            'ANNO',
                          ],
                        ),
                        const SizedBox(height: 20),
                        //   submit button
                        CustomButton(
                          text: 'Submit',
                          onTap: () async {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              if (_validateForm()) {
                                AppMetaDataProvider appMetaDataProvider =
                                    Provider.of<AppMetaDataProvider>(context,
                                        listen: false);
                                String startInterviewTime =
                                    appMetaDataProvider.startTimeInterview ??
                                        DateTime.now().toIso8601String();
                                String formUuid = Uuid().v4();
                                await Provider.of<GraduationMonitoringProvider>(
                                        context,
                                        listen: false)
                                    .submitGraduationMonitoringForm(
                                  widget.caseLoad.cpimsId,
                                  widget.caseLoad.caregiverCpimsId,
                                  formUuid,
                                  startInterviewTime,
                                  formType,
                                );
                                setState(() {
                                  isLoading = true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Form submitted successfully'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pop(context);
                                //update stats
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Please fill all required fields'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } catch (e) {
                              setState(() {
                                isLoading = false;
                              });
                              rethrow;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          const Footer(),
        ],
      ),
    );
  }
}

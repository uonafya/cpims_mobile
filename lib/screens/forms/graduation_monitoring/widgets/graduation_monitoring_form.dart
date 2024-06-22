import 'package:cpims_mobile/providers/app_meta_data_provider.dart';
import 'package:cpims_mobile/screens/forms/graduation_monitoring/provider/graduation_monitoring_provider.dart';
import 'package:cpims_mobile/services/unapproved_data_service.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../../Models/case_load_model.dart';
import '../../../../constants.dart';
import '../../../../utils/unnapproved_delete_utils.dart';
import '../../../../widgets/custom_dynamic_radio_button.dart';
import '../../../../widgets/drawer.dart';
import '../../../../widgets/footer.dart';
import '../../../cpara/widgets/cpara_details_widget.dart';
import '../../../homepage/provider/stats_provider.dart';
import '../../../unapproved_records/unapproved_records_screen.dart';
import '../model/graduation_monitoring_form_model.dart';
import '../unapproved/unapproved_graduation_form.dart';

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

    graduationModel.form_type = formType;
    graduationModel.gm1d = dateOfMonitoring;
    graduationModel.cm2q = benchmark1;
    graduationModel.cm3q = benchmark2;
    graduationModel.cm4q = benchmark3;
    graduationModel.cm5q = benchmark4;
    graduationModel.cm6q = benchmark5;
    graduationModel.cm7q = benchmark6;
    graduationModel.cm8q = benchmark7;
    graduationModel.cm9q = benchmark8;
    graduationModel.cm10q = benchmark9;
    graduationModel.cm13q = householdReadyToExit;
    graduationModel.cm14q = caseDeterminedReadyForClosure;

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
                                Provider.of<GraduationMonitoringProvider>(
                                    context,
                                    listen: false);
                            GraduationMonitoringFormModel updatedModel =
                                provider.graduationMonitoringFormModel.copyWith(
                                    dateOfMonitoring: dateOfMonitoring);
                            provider
                                .updateGraduationMonitoringModel(updatedModel);
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
                              graduationMonitoringFormModel.form_type != null &&
                                      graduationMonitoringFormModel
                                          .form_type!.isNotEmpty
                                  ? graduationMonitoringFormModel.form_type
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
                            'bm',
                            'hhrcpa',
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
                          option: graduationMonitoringFormModel.cm2q,
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
                          option: graduationMonitoringFormModel.cm3q,
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
                          option: graduationMonitoringFormModel.cm4q,
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
                          option: graduationMonitoringFormModel.cm5q,
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
                          option: graduationMonitoringFormModel.cm6q,
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
                          option: graduationMonitoringFormModel.cm7q,
                          optionSelected: (String? option) {
                            benchmark6 = option;
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
                          'Benchmark 7: All children and adolescents in the household are under the care of a stable adult caregiver*',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        CustomDynamicRadioButtonNew(
                          isNaAvailable: false,
                          option: graduationMonitoringFormModel.cm8q,
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
                          option: graduationMonitoringFormModel.cm9q,
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
                          option: graduationMonitoringFormModel.cm10q,
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
                          option: graduationMonitoringFormModel.cm13q,
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
                          option: graduationMonitoringFormModel.cm14q,
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
                          isLoading: isLoading,
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
                                String previousFormUuid = Provider.of<GraduationMonitoringProvider>(context, listen: false).formUuid ?? "";
                                debugPrint("The previous FormUuid is $previousFormUuid");
                                if (previousFormUuid.isNotEmpty) {
                                  UnapprovedDataService.deleteUnapprovedGraduationMonitoringForm(previousFormUuid);
                                  final List<UnApprovedGraduationFormModel> unapprovedGraduationRecords = await UnapprovedDataService.fetchRejectedGraduationForms();
                                  void handleDelete(String id) {
                                    deleteUnapprovedGraduationForm(context, id, unapprovedGraduationRecords);
                                  }
                                  handleDelete(previousFormUuid);
                                  //clear context
                                  Provider.of<GraduationMonitoringProvider>(context, listen: false).clearForm();
                                }
                                bool isGraduationMonitoringSaved =
                                    await Provider.of<GraduationMonitoringProvider>(context, listen: false).submitGraduationMonitoringForm(
                                  widget.caseLoad.cpimsId,
                                  widget.caseLoad.caregiverCpimsId,
                                  formUuid,
                                  startInterviewTime,
                                  formType,
                                );
                                if (isGraduationMonitoringSaved) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Form submitted successfully'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  UnapprovedDataService.deleteUnapprovedGraduationMonitoringForm("");
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Provider.of<StatsProvider>(context,
                                          listen: false)
                                      .updateFormStats();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const UnapprovedRecordsScreens()),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Failed to submit form'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  //update stats
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
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

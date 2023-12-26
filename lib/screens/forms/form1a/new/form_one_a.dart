import 'package:cpims_mobile/Models/unapproved_form_1_model.dart';
import 'package:cpims_mobile/providers/app_meta_data_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/screens/forms/form1a/new/utils/form_one_a_provider.dart';
import 'package:cpims_mobile/screens/forms/form1a/new/widgets/fom_one_a_critical.dart';
import 'package:cpims_mobile/screens/forms/form1a/new/widgets/fom_one_a_safe.dart';
import 'package:cpims_mobile/screens/forms/form1a/new/widgets/fom_one_a_stable.dart';
import 'package:cpims_mobile/screens/forms/form1a/new/widgets/form_one_a_healthy.dart';
import 'package:cpims_mobile/screens/forms/form1a/new/widgets/form_one_a_schooled.dart';
import 'package:cpims_mobile/widgets/location_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../Models/case_load_model.dart';
import '../../../../constants.dart';
import '../../../../widgets/app_bar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_forms_date_picker.dart';
import '../../../../widgets/custom_stepper.dart';
import '../../../../widgets/drawer.dart';
import '../../../../widgets/footer.dart';
import '../../../homepage/provider/stats_provider.dart';
import '../../form1b/utils/form1bConstants.dart';

class FomOneA extends StatefulWidget {
  final CaseLoadModel caseLoadModel;
  final UnapprovedForm1DataModel? unapprovedForm1;

  const FomOneA({Key? key, required this.caseLoadModel, this.unapprovedForm1})
      : super(key: key);

  @override
  State<FomOneA> createState() => _FomOneAState();
}

class _FomOneAState extends State<FomOneA> {
  int selectedStep = 0;
  bool isLoading = false;
  String dateOfEvent = '';
  List<Widget> steps = [
    const FormOneAHealthy(),
    const FormOneASafe(),
    const FormOneAStable(),
    const FormOneASchooled(),
    const FormOneACritical(),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Form1AProviderNew form1AProvider =
          Provider.of<Form1AProviderNew>(context, listen: false);
      form1AProvider.setFinalFormDataOvcId(widget.caseLoadModel.cpimsId!);
      form1AProvider.setFinalFormDataCareGiverId(widget.caseLoadModel.caregiverCpimsId!);
      if (widget.unapprovedForm1 != null) {
        form1AProvider
            .setSelectedDateOfEvent(widget.unapprovedForm1!.dateOfEvent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Form1AProviderNew form1AProvider =
        Provider.of<Form1AProviderNew>(context, listen: false);
    bool isLastStep = selectedStep == steps.length - 1;

    bool isFormInvalid() {
      return (form1AProvider.formData.selectedDate == null ||
              form1AProvider.formData.selectedDate == '') &&
          (form1AProvider.formData.selectedServices.isBlank! &&
              form1AProvider.safeFormData.selectedServices.isBlank! &&
              form1AProvider.stableFormData.selectedServices.isBlank! &&
              form1AProvider.schooledFormData.selectedServices.isBlank! &&
              form1AProvider.criticalEventDataForm1b.selectedEvents.isBlank!);
    }

    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(height: 20),
          const Text('Form 1A',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          const Text(
            'OVC Service and Monitoring',
            style: TextStyle(color: kTextGrey),
          ),
          const SizedBox(height: 15),
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
                    ' FORM 1A DETAILS \n CARE GIVER: ${widget.caseLoadModel.caregiverNames} \n CPIMS ID: ${widget.caseLoadModel.cpimsId}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      CustomStepperWidget(
                        onTap: (index) {
                          setState(() {
                            selectedStep = index;
                          });
                        },
                        data: form1asStepper,
                        selectedIndex: selectedStep,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      steps[selectedStep],
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: isLastStep,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Date of Event',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              DateTextField(
                                  label: dateOfEvent,
                                  enabled: true,
                                  identifier:
                                      DateTextFieldIdentifier.dateOfAssessment,
                                  onDateSelected: (value) {
                                    setState(() {
                                      dateOfEvent = DateFormat("yyyy-MM-dd")
                                          .format(value!);
                                      debugPrint(
                                          "The selected date is $value and date of event is $dateOfEvent");
                                      if (dateOfEvent.isNotEmpty) {
                                        form1AProvider.setSelectedDateOfEvent(
                                            dateOfEvent);
                                      }
                                    });
                                  }),
                              const SizedBox(
                                height: 15,
                              ),
                            ]),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: selectedStep <= 0 ? 'Cancel' : 'Previous',
                              onTap: () {
                                if (selectedStep == 0) {
                                  Navigator.pop(context);
                                  form1AProvider.resetFormData();
                                } else {
                                  setState(() {
                                    if (selectedStep > 0) {
                                      selectedStep--;
                                    }
                                  });
                                }
                              },
                              color: kTextGrey,
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Expanded(
                            child: CustomButton(
                              isLoading: isLoading,
                              text: isLastStep ? 'Submit Form1A' : 'Next',
                              onTap: () async {
                                if (isLastStep) {
                                  if (isFormInvalid()) {
                                    Get.snackbar(
                                      'Error',
                                      'Please fill all the information',
                                      duration: const Duration(seconds: 2),
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                      margin: const EdgeInsets.all(16),
                                      borderRadius: 8,
                                    );
                                    setState(() {
                                      isLoading = false;
                                    });
                                    return;
                                  } else {
                                    try {
                                      String startInterviewTime = '';
                                      if (context.mounted) {
                                        startInterviewTime = context
                                                .read<AppMetaDataProvider>()
                                                .startTimeInterview ??
                                            '';
                                      }
                                      setState(() {
                                        isLoading = true;
                                      });

                                      //check if date of event is empty
                                      if (dateOfEvent.isEmpty &&
                                          form1AProvider
                                                  .formData.selectedDate ==
                                              "") {
                                        debugPrint("Missing date of event");
                                        // Get.snackbar(
                                        //   'Error',
                                        //   'Please select date of event',
                                        //   backgroundColor: Colors.red,
                                        //   colorText: Colors.white,
                                        // );
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                      bool isFormSaved =
                                          await form1AProvider.saveForm1AData(
                                              form1AProvider.formData,
                                              startInterviewTime,
                                              widget.unapprovedForm1);
                                      setState(() {
                                        if (isFormSaved == true) {
                                          isLoading = false;
                                          if (context.mounted) {
                                            context
                                                .read<StatsProvider>()
                                                .updateFormOneAStats();
                                            context
                                                .read<StatsProvider>()
                                                .updateFormOneADistinctStats();
                                            context
                                                .read<AppMetaDataProvider>()
                                                .clearFormMetaData();
                                          }
                                          Get.snackbar(
                                            'Success',
                                            'Form1A data saved successfully.',
                                            duration:
                                                const Duration(seconds: 2),
                                            snackPosition: SnackPosition.TOP,
                                            backgroundColor: Colors.green,
                                            colorText: Colors.white,
                                            margin: const EdgeInsets.all(16),
                                            borderRadius: 8,
                                          );
                                          Navigator.pop(context, true);
                                          selectedStep = 0;
                                        }
                                      });
                                    } catch (e) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      if (kDebugMode) {
                                        print(
                                          "Error getting user location: $e",
                                        );
                                      }
                                      if (e.toString() == locationDisabled ||
                                          e.toString() == locationDenied) {
                                        if (context.mounted) {
                                          locationMissingDialog(context);
                                        }
                                      }
                                    }
                                  }
                                } else {
                                  setState(() {
                                    if (selectedStep < steps.length - 1) {
                                      selectedStep++;
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      // ... your other widgets
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

Future<Position> getUserLocation(// {required BuildContext context}
    ) async {
  // try{
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw (locationDisabled);
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw (locationDenied);
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw (locationDenied);
  }
  return await Geolocator.getCurrentPosition();
  // }
  // catch(e){
  //   locationMissingDialog(context);
  //   // return Future.error('Error getting user location');
  // }
}

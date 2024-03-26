import 'package:cpims_mobile/screens/cpara/provider/hiv_assessment_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_stable_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_current_status_form.dart';
import 'package:cpims_mobile/widgets/form_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/case_load_model.dart';
import '../../ovc_care/ovc_care_screen.dart';

class HIVRiskAssessmentModel {
  final String biologicalFather;
  final String malnourished;
  final String sexualAbuse;
  final String sexualAbuseAdolescent;
  final String traditionalProcedures;
  final String persistentlySick;
  final String tb;
  final String sexualIntercourse;
  final String symptomsOfSTI;
  final String ivDrugUser;
  final String finalEvaluation;

  HIVRiskAssessmentModel({
    this.biologicalFather = "",
    this.malnourished = "",
    this.sexualAbuse = "",
    this.sexualAbuseAdolescent = "",
    this.traditionalProcedures = "",
    this.persistentlySick = "",
    this.tb = "",
    this.sexualIntercourse = "",
    this.symptomsOfSTI = "",
    this.ivDrugUser = "",
    String? finalEvaluation, // Allow for the initialization of finalEvaluation
  }) : finalEvaluation = _calculateFinalEvaluation(
          biologicalFather,
          malnourished,
          sexualAbuse,
          sexualAbuseAdolescent,
          traditionalProcedures,
          persistentlySick,
          tb,
          sexualIntercourse,
          symptomsOfSTI,
          ivDrugUser,
        );

  Map<String, dynamic> toJson() {
    return {
      'HIV_RS_04': biologicalFather,
      'HIV_RS_05': malnourished,
      'HIV_RS_06': sexualAbuse,
      'HIV_RS_09': sexualAbuseAdolescent,
      'HIV_RS_06A': traditionalProcedures,
      'HIV_RS_07': persistentlySick,
      'HIV_RS_08': tb,
      'HIV_RS_10': sexualIntercourse,
      'HIV_RS_10A': symptomsOfSTI,
      'HIV_RS_10B': ivDrugUser,
      'HIV_RS_11': finalEvaluation,
    };
  }

  static String _calculateFinalEvaluation(
    String biologicalFather,
    String malnourished,
    String sexualAbuse,
    String sexualAbuseAdolescent,
    String traditionalProcedures,
    String persistentlySick,
    String tb,
    String sexualIntercourse,
    String symptomsOfSTI,
    String ivDrugUser,
  ) {
    bool anyQuestionAnsweredYes = biologicalFather == "Yes" ||
        malnourished == "Yes" ||
        sexualAbuse == "Yes" ||
        sexualAbuseAdolescent == "Yes" ||
        traditionalProcedures == "Yes" ||
        persistentlySick == "Yes" ||
        tb == "Yes" ||
        sexualIntercourse == "Yes" ||
        symptomsOfSTI == "Yes" ||
        ivDrugUser == "Yes";

    return anyQuestionAnsweredYes ? "Yes" : "";
  }
}

class HIVRiskAssesmentForm extends StatefulWidget {
  const HIVRiskAssesmentForm({Key? key}) : super(key: key);

  @override
  State<HIVRiskAssesmentForm> createState() => _HIVRiskAssesmentFormState();
}

class _HIVRiskAssesmentFormState extends State<HIVRiskAssesmentForm> {
  String biologicalFather = "";
  String malnourished = "";
  String sexualAbuse = "";
  String traditionalProcedures = "";
  String persistentlySick = "";
  String tb = "";
  String sexualIntercourse = "";
  String symptomsOfSTI = "";
  String ivDrugUser = "";
  String finalEvaluation = "";
  String sexualAbuseAdolescent = "";
  String assessmentText = "";

  // bool anyQuestionAnsweredYes = false;

  HIVCurrentStatusModel currentStatus = HIVCurrentStatusModel();
  int age = 0;

  void handleOnFormSaved() {
    final val = HIVRiskAssessmentModel(
      biologicalFather: biologicalFather,
      malnourished: malnourished,
      sexualAbuse: sexualAbuse,
      sexualAbuseAdolescent: sexualAbuseAdolescent,
      traditionalProcedures: traditionalProcedures,
      persistentlySick: persistentlySick,
      tb: tb,
      sexualIntercourse: sexualIntercourse,
      symptomsOfSTI: symptomsOfSTI,
      ivDrugUser: ivDrugUser,
      finalEvaluation: finalEvaluation,
    );

    Provider.of<HIVAssessmentProvider>(context, listen: false)
        .updateHIVRiskAssessmentModel(val);
  }

  @override
  void initState() {
    super.initState();
    currentStatus = context.read<HIVAssessmentProvider>().hivCurrentStatusModel;
    final riskAssessment =
        context.read<HIVAssessmentProvider>().hivRiskAssessmentModel;
    biologicalFather = riskAssessment.biologicalFather;
    malnourished = riskAssessment.malnourished;
    sexualAbuse = riskAssessment.sexualAbuse;
    traditionalProcedures = riskAssessment.traditionalProcedures;
    persistentlySick = riskAssessment.persistentlySick;
    tb = riskAssessment.tb;
    sexualIntercourse = riskAssessment.sexualIntercourse;
    symptomsOfSTI = riskAssessment.symptomsOfSTI;
    ivDrugUser = riskAssessment.ivDrugUser;
    finalEvaluation = riskAssessment.finalEvaluation;
    sexualAbuseAdolescent = riskAssessment.sexualAbuseAdolescent;
    // anyQuestionAnsweredYes = false;

    age = context.read<HIVAssessmentProvider>().ovcAge;
    if (age >= 15) {
      assessmentText = "Child/Adolescent Assessment(> 15years)";
    } else {
      assessmentText = "";
    }
  }

  @override
  Widget build(BuildContext context) {
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
                "2. HIV RISK ASSESSMENT",
                style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Child assessment(<15 years)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              FormSection(
                isVisibleCondition: () {
                  return age < 15;
                },
                children: [
                  const Text(
                      "Q1. Is the biological father/mother/siblings of the child living/ lived with HIV?"),
                  CustomRadioButton(
                      isNaAvailable: false,
                      option: convertingStringToRadioButtonOptions(
                          biologicalFather),
                      optionSelected: (val) {
                        setState(() {
                          biologicalFather =
                              convertingRadioButtonOptionsToString(val);
                          handleOnFormSaved();
                          debugPrint("Final evaluation is $finalEvaluation");
                        });
                      }),
                ],
              ),
              const SizedBox(height: 10),
              FormSection(
                isVisibleCondition: () {
                  return age < 15;
                },
                children: [
                  const Text(
                      "Q2. Has the child been persistently sick/malnourished/Failure to trive in the past 3 months without improvement?"),
                  CustomRadioButton(
                      isNaAvailable: false,
                      option:
                          convertingStringToRadioButtonOptions(malnourished),
                      optionSelected: (val) {
                        setState(() {
                          malnourished =
                              convertingRadioButtonOptionsToString(val);
                          handleOnFormSaved();
                        });
                      }),
                ],
              ),
              const SizedBox(height: 10),
              FormSection(
                isVisibleCondition: () {
                  return age <= 15;
                },
                children: [
                  const Text(
                      "Q3. Is the child exposed to sexual abuse (defiled/raped) ?	"),
                  CustomRadioButton(
                      isNaAvailable: false,
                      option: convertingStringToRadioButtonOptions(sexualAbuse),
                      optionSelected: (val) {
                        setState(() {
                          sexualAbuse =
                              convertingRadioButtonOptionsToString(val);
                          handleOnFormSaved();
                        });
                      }),
                ],
              ),
              const SizedBox(height: 10),
              FormSection(
                isVisibleCondition: () {
                  return age < 15;
                },
                children: [
                  const Text(
                      "Q4. Has the child been subjected to traditional/non medical procedures (eg scarification/tattooing, traditional circumcision) ?	"),
                  CustomRadioButton(
                      isNaAvailable: false,
                      option: convertingStringToRadioButtonOptions(
                          traditionalProcedures),
                      optionSelected: (val) {
                        setState(() {
                          traditionalProcedures =
                              convertingRadioButtonOptionsToString(val);
                          handleOnFormSaved();
                        });
                      }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              Text(
                assessmentText,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              FormSection(
                isVisibleCondition: () {
                  return age >= 15;
                },
                children: [
                  const Text(
                      "Q5. Have you been persistently sick in the past 3 months without improvement?"),
                  CustomRadioButton(
                      isNaAvailable: false,
                      option: convertingStringToRadioButtonOptions(
                          persistentlySick),
                      optionSelected: (val) {
                        setState(() {
                          persistentlySick =
                              convertingRadioButtonOptionsToString(val);
                          handleOnFormSaved();
                        });
                      }),
                ],
              ),
              const SizedBox(height: 10),
              FormSection(
                isVisibleCondition: () {
                  return age >= 15;
                },
                children: [
                  const Text("Q6. Have you had TB in the last 12 months?"),
                  CustomRadioButton(
                      isNaAvailable: false,
                      option: convertingStringToRadioButtonOptions(tb),
                      optionSelected: (val) {
                        setState(() {
                          tb = convertingRadioButtonOptionsToString(val);
                          handleOnFormSaved();
                        });
                      }),
                ],
              ),
              const SizedBox(height: 10),
              FormSection(
                isVisibleCondition: () {
                  return age >= 15;
                },
                children: [
                  const Text(
                      "Q7. Have you been sexually abuse (defiled) or been physically forced to have sexual intercouse?"),
                  CustomRadioButton(
                      isNaAvailable: false,
                      option: convertingStringToRadioButtonOptions(
                          sexualAbuseAdolescent),
                      optionSelected: (val) {
                        setState(() {
                          sexualAbuseAdolescent =
                              convertingRadioButtonOptionsToString(val);
                          handleOnFormSaved();
                        });
                      }),
                ],
              ),
              const SizedBox(height: 10),
              FormSection(
                isVisibleCondition: () {
                  return age >= 15;
                },
                children: [
                  const Text(
                      "Q8. Have you had unprotected sexual intercourse in the past 6 months?"),
                  CustomRadioButton(
                      isNaAvailable: false,
                      option: convertingStringToRadioButtonOptions(
                          sexualIntercourse),
                      optionSelected: (val) {
                        setState(() {
                          sexualIntercourse =
                              convertingRadioButtonOptionsToString(val);
                          handleOnFormSaved();
                        });
                      }),
                ],
              ),
              const SizedBox(height: 10),
              FormSection(
                isVisibleCondition: () {
                  return age >= 15;
                },
                children: [
                  const Text(
                      "Q9. Do you have any Symptoms of sexually transmitted infections? {Penial/Vaginal sores, unusual discharge or Pain) ?"),
                  CustomRadioButton(
                      isNaAvailable: false,
                      option:
                          convertingStringToRadioButtonOptions(symptomsOfSTI),
                      optionSelected: (val) {
                        setState(() {
                          symptomsOfSTI =
                              convertingRadioButtonOptionsToString(val);
                          handleOnFormSaved();
                        });
                      }),
                ],
              ),
              const SizedBox(height: 10),
              FormSection(
                isVisibleCondition: () {
                  return age >= 15;
                },
                children: [
                  const Text("Q10. Are you an IV drug user sharing needles?"),
                  CustomRadioButton(
                      isNaAvailable: false,
                      option: convertingStringToRadioButtonOptions(ivDrugUser),
                      optionSelected: (val) {
                        setState(() {
                          ivDrugUser =
                              convertingRadioButtonOptionsToString(val);
                          handleOnFormSaved();
                          debugPrint("Final evaluation is $finalEvaluation");
                        });
                      }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const Text(
                "Final Evaluation",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              FormSection(children: [
                const Text(
                    "Q8. Did the child/Adolescent/youth have a YES to Question 2 to 10?"),
                CustomRadioButtonOverall(
                  option: convertingStringToRadioButtonOptions(
                      context.watch<HIVAssessmentProvider>().finalEvaluation),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:cpims_mobile/screens/cpara/provider/hiv_assessment_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_stable_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_current_status_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/unapproved/unapproved_hiv_risk_assessment.dart';
import 'package:cpims_mobile/widgets/form_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/case_load_model.dart';
import '../../ovc_care/ovc_care_screen.dart';



class HIVRiskAssesmentForm extends StatefulWidget {
  const HIVRiskAssesmentForm({Key? key}) : super(key: key);

  @override
  State<HIVRiskAssesmentForm> createState() => _HIVRiskAssesmentFormState();
}

class _HIVRiskAssesmentFormState extends State<HIVRiskAssesmentForm> {
  late final RiskAssessmentFormModel riskAssessmentFormModel;
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
  // HIVCurrentStatusModel currentStatus = HIVCurrentStatusModel();

  int age = 0;

  void handleOnFormSaved() {
    final formModel = Provider.of<HIVAssessmentProvider>(context, listen: false)
        .riskAssessmentFormModel;
    formModel.biologicalFather = biologicalFather;
    formModel.malnourished = malnourished;
    formModel.sexualAbuse = sexualAbuse;
    formModel.sexualAbuseAdolescent = sexualAbuseAdolescent;
    formModel.traditionalProcedures = traditionalProcedures;
    formModel.persistentlySick = persistentlySick;
    formModel.tb = tb;
    formModel.sexualIntercourse = sexualIntercourse;
    formModel.symptomsOfSTI = symptomsOfSTI;
    formModel.ivDrugUser = ivDrugUser;
    formModel.finalEvaluation = finalEvaluation;

    Provider.of<HIVAssessmentProvider>(context, listen: false)
        .notifyListeners();
  }

  @override
  void initState() {
    super.initState();
    riskAssessmentFormModel =
        context.read<HIVAssessmentProvider>().riskAssessmentFormModel;
    final riskAssessment =
        context.read<HIVAssessmentProvider>().riskAssessmentFormModel;
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
          return (riskAssessmentFormModel.statusOfChild == "Yes" &&
              riskAssessmentFormModel.hivStatus == "HIV_Negative" &&
              riskAssessmentFormModel.hivTestDone == "No");
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

import 'package:cpims_mobile/screens/cpara/provider/hiv_assessment_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_stable_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HIVRiskAssessmentModel {
  final String? biologicalFather;
  final String? malnourished;
  final String? sexualAbuse;
  final String? traditionalProcedures;
  final String? persistentlySick;
  final String? tb;
  final String? sexualIntercourse;
  final String? symptomsOfSTI;
  final String? ivDrugUser;
  final String? finalEvaluation;

  HIVRiskAssessmentModel(
      {this.biologicalFather,
      this.malnourished,
      this.sexualAbuse,
      this.traditionalProcedures,
      this.persistentlySick,
      this.tb,
      this.sexualIntercourse,
      this.symptomsOfSTI,
      this.ivDrugUser,
      this.finalEvaluation});

  Map<String, dynamic> toJson() {
    return {
      'biologicalFather': biologicalFather,
      'malnourished': malnourished,
      'sexualAbuse': sexualAbuse,
      'traditionalProcedures': traditionalProcedures,
      'persistentlySick': persistentlySick,
      'tb': tb,
      'sexualIntercourse': sexualIntercourse,
      'symptomsOfSTI': symptomsOfSTI,
      'ivDrugUser': ivDrugUser,
      'finalEvaluation': finalEvaluation,
    };
  }
}

class HIVRiskAssesmentForm extends StatefulWidget {
  const HIVRiskAssesmentForm({super.key});

  @override
  State<HIVRiskAssesmentForm> createState() => _HIVRiskAssesmentFormState();
}

class _HIVRiskAssesmentFormState extends State<HIVRiskAssesmentForm> {
  String? biologicalFather;
  String? malnourished;
  String? sexualAbuse;
  String? traditionalProcedures;
  String? persistentlySick;
  String? tb;
  String? sexualIntercourse;
  String? symptomsOfSTI;
  String? ivDrugUser;
  String? finalEvaluation;

  void handleOnFormSaved() {
    final val = HIVRiskAssessmentModel(
      biologicalFather: biologicalFather,
      malnourished: malnourished,
      sexualAbuse: sexualAbuse,
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
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
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
            const Text(
                "Q1. Is the biological father/mother/siblings of the child living/ lived with HIV?"),
            CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (val) {
                  setState(() {
                    biologicalFather =
                        convertingRadioButtonOptionsToString(val);
                    handleOnFormSaved();
                  });
                }),
            const SizedBox(height: 10),
            const Text(
                "Q2. Has the child been persistently sick/malnourished/Failure to trive in the past 3 months without improvement?"),
            CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (val) {
                  setState(() {
                    malnourished = convertingRadioButtonOptionsToString(val);
                    handleOnFormSaved();
                  });
                }),
            const SizedBox(height: 10),
            const Text(
                "Q3. Is the child exposed to sexual abuse (defiled/raped) ?	"),
            CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (val) {
                  setState(() {
                    sexualAbuse = convertingRadioButtonOptionsToString(val);
                    handleOnFormSaved();
                  });
                }),
            const SizedBox(height: 10),
            const Text(
                "Q4. Has the child been subjected to traditional/non medical procedures (eg scarification/tattooing, traditional circumcision) ?	"),
            CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (val) {
                  setState(() {
                    traditionalProcedures =
                        convertingRadioButtonOptionsToString(val);
                    handleOnFormSaved();
                  });
                }),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const Text(
              "Adolescent Assessment(> 15years)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
                "Q5. Have you been persistently sick in the past 3 months without improvement?"),
            CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (val) {
                  setState(() {
                    persistentlySick =
                        convertingRadioButtonOptionsToString(val);
                    handleOnFormSaved();
                  });
                }),
            const SizedBox(height: 10),
            const Text("Q6. Have you had TB in the last 12 months?"),
            CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (val) {
                  setState(() {
                    tb = convertingRadioButtonOptionsToString(val);
                    handleOnFormSaved();
                  });
                }),
            const SizedBox(height: 10),
            const Text(
                "Q7. Have you been sexually abuse (defiled) or been physically forced to have sexual intercouse?"),
            CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (val) {
                  setState(() {
                    sexualIntercourse =
                        convertingRadioButtonOptionsToString(val);
                    handleOnFormSaved();
                  });
                }),
            const SizedBox(height: 10),
            const Text(
                "Q8. Have you had unprotected sexual intercourse in the past 6 months?"),
            CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (val) {
                  setState(() {
                    symptomsOfSTI = convertingRadioButtonOptionsToString(val);
                    handleOnFormSaved();
                  });
                }),
            const SizedBox(height: 10),
            const Text(
                "Q9. Do you have any Symptoms of sexually transmitted infections? {Penial/Vaginal sores, unusual discharge or Pain) ?"),
            CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (val) {
                  setState(() {
                    ivDrugUser = convertingRadioButtonOptionsToString(val);
                    handleOnFormSaved();
                  });
                }),
            const SizedBox(height: 10),
            const Text("Q10. Are you an IV drug user sharing needles?"),
            CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (val) {
                  setState(() {
                    finalEvaluation = convertingRadioButtonOptionsToString(val);
                    handleOnFormSaved();
                  });
                }),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const Text(
              "Final Evaluation",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
                "Q8. Did the child/Adolescent/youth have a YES to Question 2 to 10?"),
            CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (val) {
                  setState(() {
                    finalEvaluation = convertingRadioButtonOptionsToString(val);
                    handleOnFormSaved();
                  });
                }),
          ],
        ));
  }
}

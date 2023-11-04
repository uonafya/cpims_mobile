import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HIVRiskAssesmentForm extends StatefulWidget {
  const HIVRiskAssesmentForm({super.key});

  @override
  State<HIVRiskAssesmentForm> createState() => _HIVRiskAssesmentFormState();
}

class _HIVRiskAssesmentFormState extends State<HIVRiskAssesmentForm> {
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
            CustomRadioButton(isNaAvailable: false, optionSelected: (val) {}),
            const SizedBox(height: 10),
            const Text(
                "Q2. Has the child been persistently sick/malnourished/Failure to trive in the past 3 months without improvement?"),
            CustomRadioButton(isNaAvailable: false, optionSelected: (val) {}),
            const SizedBox(height: 10),
            const Text(
                "Q3. Is the child exposed to sexual abuse (defiled/raped) ?	"),
            CustomRadioButton(isNaAvailable: false, optionSelected: (val) {}),
            const SizedBox(height: 10),
            const Text(
                "Q4. Has the child been subjected to traditional/non medical procedures (eg scarification/tattooing, traditional circumcision) ?	"),
            CustomRadioButton(isNaAvailable: false, optionSelected: (val) {}),
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
            CustomRadioButton(isNaAvailable: false, optionSelected: (val) {}),
            const SizedBox(height: 10),
            const Text("Q6. Have you had TB in the last 12 months?"),
            CustomRadioButton(isNaAvailable: false, optionSelected: (val) {}),
            const SizedBox(height: 10),
            const Text(
                "Q7. Have you been sexually abuse (defiled) or been physically forced to have sexual intercouse?"),
            CustomRadioButton(isNaAvailable: false, optionSelected: (val) {}),
            const SizedBox(height: 10),
            const Text(
                "Q8. Have you had unprotected sexual intercourse in the past 6 months?"),
            CustomRadioButton(isNaAvailable: false, optionSelected: (val) {}),
            const SizedBox(height: 10),
            const Text(
                "Q9. Do you have any Symptoms of sexually transmitted infections? {Penial/Vaginal sores, unusual discharge or Pain) ?"),
            CustomRadioButton(isNaAvailable: false, optionSelected: (val) {}),
            const SizedBox(height: 10),
            const Text("Q10. Are you an IV drug user sharing needles?"),
            CustomRadioButton(isNaAvailable: false, optionSelected: (val) {}),
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
            CustomRadioButton(isNaAvailable: false, optionSelected: (val) {}),
          ],
        ));
  }
}

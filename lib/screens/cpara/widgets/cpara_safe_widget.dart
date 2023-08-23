import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../registry/organisation_units/widgets/steps_wrapper.dart';

class CparaSafeWidget extends StatefulWidget {
  const CparaSafeWidget({super.key});

  @override
  State<CparaSafeWidget> createState() => _CparaSafeWidgetState();
}

class _CparaSafeWidgetState extends State<CparaSafeWidget> {

  // Radio button options
  RadioButtonOptions? selected;

  // Color codes
  static const lightBlue = Color.fromRGBO(217, 237, 247, 1);
  static const darkBlue = Color.fromRGBO(190, 226, 239, 1);
  static const green = Color.fromRGBO(0, 172, 172, 1);
  static const grey = Color.fromRGBO(219, 219, 219, 1);
  // static const greyBorder = Color.fromRGBO(59, 9, 9, 1);
  static const lightTextColor = Colors.white;
  // static const darkTextColor = Colors.black;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StepsWrapper(
        title: 'Safe',
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Column(
              children: [
                Text(
                  "Safe: Goal 6: Reduce Risk of Physical, Emotional and Psychological Injury Due to Exposure to Violence",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Benchmark 6: No children, adolescents, and caregivers in the household report experiences of violence (including physical violence, emotional violence, sexual violence, gender-based violence, and neglect) in the last six months. If there is no reported form of violence in the HH, skip all the questions and score N/A",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: green,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Row(
              children: [
                Text(
                  "Question for caregiver:",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: lightTextColor,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: darkBlue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Are there children, adolescents, and caregivers in the household who have experienced violence (including physical violence, emotional violence, sexual violence, gender-based violence, and neglect) in the last six months ? ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomRadioButton(
                      isNaAvailable: false,
                      optionSelected: (value) {
                        setState(() {
                          selected = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "6.1 Have you experienced violence, abuse (sexual, physical, or emotional) in the last six months?* ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (value) {
                  setState(() {
                    selected = value;
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "6.2 Is there a child below 12 years who has been exposed to violence or abuse (sexual, physical or emotional), neglect, or exploitation in the last six months?* ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (value) {
                  setState(() {
                    selected = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: darkBlue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Is there adolescents 12 years and above ?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomRadioButton(
                      isNaAvailable: false,
                      optionSelected: (value) {
                        setState(() {
                          selected = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        "CHILD NAME",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Text(
                        "OVC CPIMS ID",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [
                      Text(
                        "OMOLLO JAMES",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        "122726266262",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "6.3 Have you been exposed to violence, abuse (sexual, physical or emotional), neglect, or exploitation in the last six months?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomRadioButton(
                    isNaAvailable: false,
                    optionSelected: (value) {
                      setState(() {
                        selected = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 238, 204, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text("No siblings over 10 years found.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Tick Yes if YES for all children ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (value) {
                  setState(() {
                    selected = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Column(
            children: [
              const Text(
                "If yes to any of the three questions above, answer the questions below",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "6.4 Is there any evidence that the case has referred for services such as child protection?* ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (value) {
                  setState(() {
                    selected = value;
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "6.5 Is there documentation that they received services (e,g counseling, psycho-social, legal or health services)?* ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (value) {
                  setState(() {
                    selected = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: grey,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(children: [
              const Text(
                "Has the household achieved this benchmarks?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (value) {
                  setState(() {
                    selected = value;
                  });
                },
              ),
            ]),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Column(
              children: [
                Text(
                  "Safe: Benchmark 7: All children and adolescents in the household are under the care of a stable adult caregiver",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              const Text(
                "7.1 Is the primary caregiver 18yrs and above?* ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (value) {
                  setState(() {
                    selected = value;
                  });
                },
              ),
              const Text(
                " 7.2 Has the caregiver cared for and lived in the same home as the child/adolescents for at least the last 12 months?*  ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 25),
              CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (value) {
                  setState(() {
                    selected = value;
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(5),
                  // border:  const Border(
                  //   left: BorderSide(
                  //   color: greyBorder,
                  //   width: 2,
                  //   ),
                  // ),
                ),
                child: Column(children: [
                  const Text(
                    "Has the household achieved this benchmarks?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomRadioButton(
                    isNaAvailable: false,
                    optionSelected: (value) {
                      setState(() {
                        selected = value;
                      });
                    },
                  ),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Column(
              children: [
                Text(
                  "Safe: Goal 7: All children < 18 years have legal proof of identity",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              const Text(
                "8.1 Do all children under the age of 18 have legal documents (birth certificate)?* ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (value) {
                  setState(() {
                    selected = value;
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(children: [
                  const Text(
                    "Has the household achieved this benchmarks?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomRadioButton(
                    isNaAvailable: false,
                    optionSelected: (value) {
                      setState(() {
                        selected = value;
                      });
                    },
                  ),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomButton(text: "Cancel", onTap: () {}, color: grey),
          const SizedBox(height: 20),
          CustomButton(text: "Submit", onTap: () {}, color: green),          
        ],
      ),
    );
  }
}

import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:flutter/material.dart';

class CparaSchooledWidget extends StatefulWidget {
  const CparaSchooledWidget({super.key});

  @override
  State<CparaSchooledWidget> createState() => _CparaSchooledWidgetState();
}

class _CparaSchooledWidgetState extends State<CparaSchooledWidget> {
  // Radio button options
  // State of the questions
  RadioButtonOptions? school_going_children;
  RadioButtonOptions? q9_1;
  RadioButtonOptions? q9_2;
  RadioButtonOptions? ecde_4_5;
  RadioButtonOptions? q9_3;
  RadioButtonOptions? q9_4;
  RadioButtonOptions? benchmark_score;

  // Color codes
  static const lightBlue = Color.fromRGBO(217, 237, 247, 1);
  static const darkBlue = Color.fromRGBO(190, 226, 239, 1);
  static const green = Color.fromRGBO(0, 172, 172, 1);
  static const grey = Color.fromRGBO(219, 219, 219, 1);
  // static const greyBorder = Color.fromRGBO(59, 9, 9, 1);
  static const lightTextColor = Colors.white;
  // static const darkTextColor = Colors.black;

  // Update the state of the questions
  void updateQuestion(String question, RadioButtonOptions? value) {
    switch (question) {
      case "school_going_children":
        setState(() {
          school_going_children = value;
        });
        break;
      case "q9_1":
        setState(() {
          q9_1 = value;
        });
        break;
      case "q9_2":
        setState(() {
          q9_2 = value;
        });
        break;
      case "ecde_4_5":
        setState(() {
          ecde_4_5 = value;
        });
        break;
      case "q9_3":
        setState(() {
          q9_3 = value;
        });
        break;
      case "q9_4":
        setState(() {
          q9_4 = value;
        });
        break;
      case "benchmark_score":
        setState(() {
          benchmark_score = value;
        });
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StepsWrapper(
        title: 'CPARA schooled widget',
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
                  "Schooled: Goal 8: Increase School Attendance and Progression ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Benchmark 9: All school-aged children (4-17) and adolescents aged 18-20 enrolled in school in the household regularly attended school and progressed during the last year.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
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
                      "Are there school going children in this Household ? ",
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
                          school_going_children = value;
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
                "9.1 Are all school aged children (6-17) enrolled in school? (And out of school OVC aged 15-20 years engaged in approved economic intervention?* ",
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
                    q9_1 = value;
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "9.2 Are the enrolled children attending school regularly? (i.e. have not missed school for more than five school days in a month). Probe the trend of absence). Verify with the school attendance tracking tool where applicable)*  ",
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
                    q9_2 = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            "If there is a child between 4-5 years in the household and there is an ECDE center in the area, please ask the caregiver, otherwise skip and score the benchmark appropriately:",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 25,
          ),

          // Question ECDE
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                const Text(
                  "Is there a child between 4-5 years in the household and is there an ECDE center in the area ? ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                CustomRadioButton(
                  isNaAvailable: false,
                  optionSelected: (value) {
                    setState(() {
                      ecde_4_5 = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          // Question 9.3 - 9.4
          const Text(
            "9.3 Is your child (4–5-year-old) attending ECDE?* ",
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
                q9_2 = value;
              });
            },
          ),

          const Text(
            "9.4 Have all the enrolled children progressed/graduated from one level to the other in the last school calendar year? Note: if possible, please ask to see report card.*  ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomRadioButton(
            isNaAvailable: true,
            optionSelected: (value) {
              setState(() {
                q9_2 = value;
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
                    benchmark_score = value;
                  });
                },
              ),
            ]),
          ),
          const SizedBox(
            height: 25,
          ),
          const Column(
            children: [
              Text(
                "Form Score: 0/9",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

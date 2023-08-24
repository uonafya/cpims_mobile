import 'package:cpims_mobile/screens/cpara/widgets/cpara_safe_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:flutter/material.dart';

class CparaSchooledWidget extends StatefulWidget {
  const CparaSchooledWidget({super.key});

  @override
  State<CparaSchooledWidget> createState() => _CparaSchooledWidgetState();
}

class _CparaSchooledWidgetState extends State<CparaSchooledWidget> {
  // State of the questions
  RadioButtonOptions? school_going_children;
  RadioButtonOptions? q9_1_Children_enrooled_in_school;
  RadioButtonOptions? q9_2_Children_attending_school_regularly;
  RadioButtonOptions? ecde_4_5_children;
  RadioButtonOptions? q9_3_Children_attending_ecde;
  RadioButtonOptions? q9_4_Children_progressed_from_one_level_to_another;
  RadioButtonOptions? benchmark_score;

  // Update the state of the questions
  void updateQuestion(String question, RadioButtonOptions? value) {
    switch (question) {
      case "school_going_children":
        setState(() {
          school_going_children = value;
          if (value == RadioButtonOptions.no) {
            q9_1_Children_enrooled_in_school = RadioButtonOptions.yes;
            q9_2_Children_attending_school_regularly = RadioButtonOptions.yes;
          }
          if (value == RadioButtonOptions.yes) {
            q9_1_Children_enrooled_in_school = null;
            q9_2_Children_attending_school_regularly = null;
          }
        });
        break;
      case "q9_1_Children_enrooled_in_school":
        setState(() {
          q9_1_Children_enrooled_in_school = value;
        });
        break;
      case "q9_2_Children_attending_school_regularly":
        setState(() {
          q9_2_Children_attending_school_regularly = value;
        });
        break;
      case "ecde_4_5_children":
        setState(() {
          ecde_4_5_children = value;
          if (value == RadioButtonOptions.no) {
            q9_3_Children_attending_ecde = RadioButtonOptions.yes;
          }
          if (value == RadioButtonOptions.yes) {
            q9_3_Children_attending_ecde = null;
          }
        });
        break;
      case "q9_3_Children_attending_ecde":
        setState(() {
          q9_3_Children_attending_ecde = value;
        });
        break;
      case "q9_4_Children_progressed_from_one_level_to_another":
        setState(() {
          q9_4_Children_progressed_from_one_level_to_another = value;
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
        title: 'Schooled',
        children: [
          const GoalWidget(
            title:
                'Schooled: Goal 8: Increase School Attendance and Progression',
            description:
                'Benchmark 9: All school-aged children (4-17) and adolescents aged 18-20 enrolled in school in the household regularly attended school and progressed during the last year.',
          ),
          const SizedBox(height: small_height),

///////////////////////////////////////////
// First Main Question
          MainCardQuestion(
              card_question:
                  "Are there school going children in this Household ?",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("school_going_children", value);
              }),

// Question 9.1 - 9.2
// Question 9.1
          if (school_going_children == RadioButtonOptions.no)
            const SkipQuestion()
          else
            OtherQuestions(
              other_question:
                  "9.1 Are all school aged children (6-17) enrolled in school? (And out of school OVC aged 15-20 years engaged in approved economic intervention?*",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("q9_1_Children_enrooled_in_school", value);
              },
              NaAvailable: false,
              groupValue: q9_1_Children_enrooled_in_school,
            ),

// Question 9.2
          if (school_going_children == RadioButtonOptions.no)
            const SkipQuestion()
          else
            OtherQuestions(
              other_question:
                  "9.2 Are the enrolled children attending school regularly? (i.e. have not missed school for more than five school days in a month). Probe the trend of absence). Verify with the school attendance tracking tool where applicable)*",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion(
                    "q9_2_Children_attending_school_regularly", value);
              },
              NaAvailable: false,
              groupValue: q9_2_Children_attending_school_regularly,
            ),

// General Statement
          const Text(
            "If there is a child between 4-5 years in the household and there is an ECDE center in the area, please ask the caregiver, otherwise skip and score the benchmark appropriately:",
            style: TextStyle(
              fontSize: question_font_Size,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 25,
          ),

// Main Card Question
          MainCardQuestion(
              card_question:
                  "Is there a child between 4-5 years in the household and is there an ECDE center in the area ?",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("ecde_4_5_children", value);
              }),

          const SizedBox(
            height: 25,
          ),

// Question 9.3 - 9.4
// Question 9.3
          if (ecde_4_5_children == RadioButtonOptions.no)
            const SkipQuestion()
          else
            OtherQuestions(
              other_question:
                  "9.3 Is your child (4–5-year-old) attending ECDE?* ",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("q9_3_Children_attending_ecde", value);
              },
              NaAvailable: false,
              groupValue: q9_3_Children_attending_ecde,
            ),

// Question 9.4
          OtherQuestions(
            other_question:
                "9.4 Have all the enrolled children progressed/graduated from one level to the other in the last school calendar year? Note: if possible, please ask to see report card.*  ",
            selectedOption: (value) {
              // Update the state of the question
              updateQuestion(
                  "q9_4_Children_progressed_from_one_level_to_another", value);
            },
            NaAvailable: true,
            divider: true,
            groupValue: q9_4_Children_progressed_from_one_level_to_another,
          ),

// Benchmark score
          BenchMarkQuestion(
              groupValue: allShouldBeYes([
                q9_1_Children_enrooled_in_school,
                q9_2_Children_attending_school_regularly,
                q9_3_Children_attending_ecde,
                q9_4_Children_progressed_from_one_level_to_another
              ], "Last Benchmark school"),
              benchmark_question: "Has the household achieved this benchmarks?",
              selectedOption: (value) {}),

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

// Color codes
const lightBlue = Color.fromRGBO(217, 237, 247, 1);
const darkBlue = Color.fromRGBO(190, 226, 239, 1);
const green = Color.fromRGBO(0, 172, 172, 1);
const grey = Color.fromRGBO(219, 219, 219, 1);
// static const greyBorder = Color.fromRGBO(59, 9, 9, 1);
const lightTextColor = Colors.white;
// static const darkTextColor = Colors.black;

const goal_font = 20.0;
const goal_weight = FontWeight.w700;
const goaldesc_font = 14.0;
const goaldesc_weight = FontWeight.w300;

class GoalWidget extends StatelessWidget {
  final String title;
  final String description;
  const GoalWidget({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: const BoxDecoration(color: lightBlue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                const TextStyle(fontWeight: goal_weight, fontSize: goal_font),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: const TextStyle(
                fontWeight: goaldesc_weight,
                color: Colors.black54,
                fontSize: goaldesc_font,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

//Question for card 1
// Radio button options

class MainCardQuestion extends StatelessWidget {
  final String card_question;
  final Function(RadioButtonOptions?) selectedOption;
  const MainCardQuestion(
      {super.key, required this.card_question, required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: darkBlue,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Text(
                card_question,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomRadioButton(
                isNaAvailable: false,
                optionSelected: (value) => selectedOption(value),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SkipQuestion extends StatelessWidget {
  const SkipQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Skipped Question"),
      ],
    );
  }
}

// class OtherQuestions extends StatelessWidget {
//   final bool NaAvailable;
//   final String other_question;
//   final bool divider;
//   final Function(RadioButtonOptions?) selectedOption;

//   const OtherQuestions(
//       {super.key,
//       required this.other_question,
//       required this.selectedOption,
//       this.divider = false,
//       this.NaAvailable = false});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         if (divider == true) const Divider(),
//         const SizedBox(
//           height: large_height,
//         ),
//         Text(
//           other_question,
//           style: const TextStyle(
//             fontSize: question_font_Size,
//             fontWeight: question_font_weight,
//           ),
//         ),
//         const SizedBox(
//           height: small_height,
//         ),
//         CustomRadioButton(
//           isNaAvailable: NaAvailable,
//           optionSelected: (value) => selectedOption(value),
//         ),
//         const SizedBox(
//           height: large_height,
//         ),
//       ],
//     );
//   }
// }

// A function that computes whether the final result of a section is yes or no given the values of the members
RadioButtonOptions allShouldBeYes(
    List<RadioButtonOptions?> members, String message) {
  debugPrint(members.toString() + message);
  // If all the values are yes return RadioButtonOptions.yes, if not return RadioButtonOptions.no
  if (members.isEmpty) {
    return RadioButtonOptions.no;
  } else if (members
      .any((element) => element == RadioButtonOptions.no || element == null)) {
    return RadioButtonOptions.no;
  } else {
    return RadioButtonOptions.yes;
  }
}


// class BenchMarkQuestion extends StatelessWidget {
//   final String benchmark_question;
//   final Function(RadioButtonOptions?) selectedOption;
//   const BenchMarkQuestion(
//       {super.key,
//       required this.benchmark_question,
//       required this.selectedOption});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: grey,
//             borderRadius: BorderRadius.circular(5),
//             // border:  const Border(
//             //   left: BorderSide(
//             //   color: greyBorder,
//             //   width: 2,
//             //   ),
//             // ),
//           ),
//           child: Column(
//             children: [
//               Text(
//                 benchmark_question,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w300,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               CustomRadioButton(
//                 isNaAvailable: false,
//                 optionSelected: (value) => selectedOption(value),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

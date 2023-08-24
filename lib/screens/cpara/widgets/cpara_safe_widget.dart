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
  // State of the questions
  RadioButtonOptions? _children_adolecent_caregiver;
  RadioButtonOptions? _experienced_violence;
  RadioButtonOptions? _child_below_12;
  RadioButtonOptions? _adolescents_older_than_12;
  RadioButtonOptions? _exosed_to_violence;
  RadioButtonOptions? _no_siblings_over_10;
  RadioButtonOptions? _referred_for_services;
  RadioButtonOptions? _received_services;
  RadioButtonOptions? _benchmark_6;
  RadioButtonOptions? _primary_caregiver;
  RadioButtonOptions? _caregiver_lived_12_months;
  RadioButtonOptions? _benchmark_7;
  RadioButtonOptions? _legal_documents;
  RadioButtonOptions? _benchmark_8;

  // Update the state of the questions
  void updateQuestion(String question, RadioButtonOptions? value) {
    switch (question) {
      case "_children_adolecent_caregiver":
        setState(() {
          _children_adolecent_caregiver = value;
        });
        break;
      case "_experienced_violence":
        setState(() {
          _experienced_violence = value;
        });
        break;
      case "_child_below_12":
        setState(() {
          _child_below_12 = value;
        });
        break;
      case "_adolescents_older_than_12":
        setState(() {
          _adolescents_older_than_12 = value;
        });
        break;
      case "_exosed_to_violence":
        setState(() {
          _exosed_to_violence = value;
        });
        break;
      case "_no_siblings_over_10":
        setState(() {
          _no_siblings_over_10 = value;
        });
        break;
      case "_referred_for_services":
        setState(() {
          _referred_for_services = value;
        });
        break;
      case "_received_services":
        setState(() {
          _received_services = value;
        });
        break;
      case "_benchmark_6":
        setState(() {
          _benchmark_6 = value;
        });
        break;
      case "_primary_caregiver":
        setState(() {
          _primary_caregiver = value;
        });
        break;
      case "_caregiver_lived_12_months":
        setState(() {
          _caregiver_lived_12_months = value;
        });
        break;
      case "_benchmark_7":
        setState(() {
          _benchmark_7 = value;
        });
        break;
      case "_legal_documents":
        setState(() {
          _legal_documents = value;
        });
        break;
      case "_benchmark_8":
        setState(() {
          _benchmark_8 = value;
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
        title: 'Safe',
        children: [

// Safe Goal 6
          const SafeGoalWidget(
              title:
                  "Safe: Goal 6: Reduce Risk of Physical, Emotional and Psychological Injury Due to Exposure to Violence",
              sub_title:
                  "Benchmark 6: No children, adolescents, and caregivers in the household report experiences of violence (including physical violence, emotional violence, sexual violence, gender-based violence, and neglect) in the last six months. If there is no reported form of violence in the HH, skip all the questions and score N/A"),

          const SizedBox(
            height: 20,
          ),
          const QuestionForCard(
            text: "Question for caregiver:",
          ),
          const SizedBox(height: 20),

// Question 6.1 to 6.2
// Question Main Card
          MainCardQuestion(
              card_question:
                  "Are there children, adolescents, and caregivers in the household who have experienced violence (including physical violence, emotional violence, sexual violence, gender-based violence, and neglect) in the last six months ?",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("_children_adolecent_caregiver", value);
              }),

// Question 6.1
          OtherQuestions(
            other_question:
                "6.1 Have you experienced violence, abuse (sexual, physical, or emotional) in the last six months?*",
            selectedOption: (value) {
              // Update the state of the question
              updateQuestion("_experienced_violence", value);

            },
          ),

          // Question 6.2
          OtherQuestions(
            other_question:
                "6.2 Is there a child below 12 years who has been exposed to violence or abuse (sexual, physical or emotional), neglect, or exploitation in the last six months?*",
            selectedOption: (value) {
              // Update the state of the question
              updateQuestion("_child_below_12", value);
            },
          ),

// Question 6.3 to 6.2
// Question Main Card
          MainCardQuestion(
              card_question: " Is there adolescents 12 years and above ? ",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("_adolescents_older_than_12", value);
              }),

          const SizedBox(
            height: large_height,
          ),

// Load Child Cards - For the specific household
          const ChildCardWidget(),

          const SizedBox(
            height: large_height,
          ),

// Container showing sibling over 10 with a yellow bg
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

// Tick yes if yes for all children
          OtherQuestions(
              other_question: "Tick Yes if YES for all children",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("_exosed_to_violence", value);
              }),

// Label for question 6.4 to 6.5
          const Text(
            "If yes to any of the three questions above, answer the questions below",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

// Question 6.4
          OtherQuestions(
              other_question:
                  "6.4 Is there any evidence that the case has referred for services such as child protection?* ",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("_referred_for_services", value);
              }),

// Question 6.5
          OtherQuestions(
              other_question:
                  "6.5 Is there documentation that they received services (e,g counseling, psycho-social, legal or health services)?* ",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("_received_services", value);
              }),

// Benchmak 6 results
          BenchMarkQuestion(
              benchmark_question: "Has the household achieved this benchmarks?",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("_benchmark_6", value);
              }),

          const SizedBox(
            height: large_height,
          ),

// Safe Goal 7 questions 7.1 to 7.2
          const SafeGoalWidget(
              title:
                  "Safe: Goal 7: All children and adolescents in the household are under the care of a stable adult caregiver"),

// Question 7.1
          OtherQuestions(
              other_question: "7.1 Is the primary caregiver 18yrs and above?* ",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("_primary_caregiver", value);
              }),

// Question 7.2
          OtherQuestions(
              other_question:
                  "7.2 Has the caregiver cared for and lived in the same home as the child/adolescents for at least the last 12 months?*  ",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("_caregiver_lived_12_months", value);
              }),

// Benchmak 7 results
          BenchMarkQuestion(
              benchmark_question: "Has the household achieved this benchmarks?",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("_benchmark_7", value);
              }),

          const SizedBox(
            height: large_height,
          ),

// Safe Goal 7 questions 8.1 to 8.2

          const SafeGoalWidget(
              title:
                  "Safe: Goal 7: All children < 18 years have legal proof of identity"),

// Question 8.1
          OtherQuestions(
              other_question:
                  "8.1 Do all children under the age of 18 have legal documents (birth certificate)?* ",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("_legal_documents", value);
              }),

// Benchmak 7 results
          BenchMarkQuestion(
              benchmark_question: "Has the household achieved this benchmarks?",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("_benchmark_8", value);
              }),

          const SizedBox(
            height: large_height,
          ),
          CustomButton(
              text: "Cancel",
              onTap: () {},
              color: Colors.black.withOpacity(0.4)),
          const SizedBox(height: 20),
          CustomButton(text: "Submit", onTap: () {}, color: green),
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
//const greyBorder = Color.fromRGBO(59, 9, 9, 1);
const lightTextColor = Colors.white;
const darkTextColor = Colors.black;

class SafeGoalWidget extends StatelessWidget {
  final String title;
  final String sub_title;
  const SafeGoalWidget({super.key, required this.title, this.sub_title = ""});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: goal_font,
              fontWeight: goal_weight,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            sub_title,
            style: const TextStyle(
              fontSize: goaldesc_font,
              fontWeight: goaldesc_weight,
            ),
          ),
        ],
      ),
    );
  }
}

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

const goal_font = 20.0;
const goal_weight = FontWeight.w700;
const goaldesc_font = 14.0;
const goaldesc_weight = FontWeight.w300;
const question_font_Size = 18.0;
const question_font_weight = FontWeight.w500;
const small_height = 10.0;
const large_height = 25.0;

class QuestionForCard extends StatelessWidget {
  final String text;
  const QuestionForCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: green,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: lightTextColor,
            ),
          )
        ],
      ),
    );
  }
}

class OtherQuestions extends StatelessWidget {
  final bool NaAvailable;
  final String other_question;
  final bool divider;
  final Function(RadioButtonOptions?) selectedOption;

  const OtherQuestions(
      {super.key,
      required this.other_question,
      required this.selectedOption,
      this.divider = false,
      this.NaAvailable = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (divider == true) const Divider(),
        const SizedBox(
          height: large_height,
        ),
        Text(
          other_question,
          style: const TextStyle(
            fontSize: question_font_Size,
            fontWeight: question_font_weight,
          ),
        ),
        const SizedBox(
          height: small_height,
        ),
        CustomRadioButton(
          isNaAvailable: NaAvailable,
          optionSelected: (value) => selectedOption(value),
        ),
        const SizedBox(
          height: large_height,
        ),
      ],
    );
  }
}

class BenchMarkQuestion extends StatelessWidget {
  final String benchmark_question;
  final Function(RadioButtonOptions?) selectedOption;
  const BenchMarkQuestion(
      {super.key,
      required this.benchmark_question,
      required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          child: Column(
            children: [
              Text(
                benchmark_question,
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

class ChildCardWidget extends StatelessWidget {
  const ChildCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Child Name',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12.0),
                  ),
                  Text(
                    'JANE BOLO',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OVC CPIMS ID',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12.0),
                  ),
                  Text(
                    '1573288',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0),
                  ),
                ],
              ),
            ],
          ),
        ),
        OtherQuestions(
          other_question:
              "6.3 Have you been exposed to violence, abuse (sexual, physical or emotional), neglect, or exploitation in the last six months?",
          selectedOption: (value) {},
        ),
      ],
    ));
  }
}

import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:flutter/material.dart';

import '../../registry/organisation_units/widgets/steps_wrapper.dart';

class CparaHealthyWidget extends StatefulWidget {
  const CparaHealthyWidget({super.key});

  @override
  State<CparaHealthyWidget> createState() => _CparaHealthyWidgetState();
}

class _CparaHealthyWidgetState extends State<CparaHealthyWidget> {
  // State of the questions
  RadioButtonOptions? q1_1;
  RadioButtonOptions? q1_2;
  RadioButtonOptions? q1_3;
  RadioButtonOptions? q1_4;
  RadioButtonOptions? q1_5;
  RadioButtonOptions? q2_1;
  RadioButtonOptions? q2_2;
  RadioButtonOptions? q2_3;
  RadioButtonOptions? q2_4;
  RadioButtonOptions? q2_5;
  RadioButtonOptions? q2_6;
  RadioButtonOptions? q2_7;
  RadioButtonOptions? q2_8;
  RadioButtonOptions? q2_9;

  // Update the state of the questions
  void updateQuestion(String question, RadioButtonOptions? value) {
    switch (question) {
      case "q1_1":
        setState(() {
          q1_1 = value;
        });
        break;
      case "q1_2":
        setState(() {
          q1_2 = value;
        });
        break;
      case "q1_3":
        setState(() {
          q1_3 = value;
        });
        break;
      case "q1_4":
        setState(() {
          q1_4 = value;
        });
        break;
      case "q1_5":
        setState(() {
          q1_5 = value;
        });
        break;
      case "q2_1":
        setState(() {
          q2_1 = value;
        });
        break;
      case "q2_2":
        setState(() {
          q2_2 = value;
        });
        break;
      case "q2_3":
        setState(() {
          q2_3 = value;
        });
        break;
      case "q2_4":
        setState(() {
          q2_4 = value;
        });
        break;
      case "q2_5":
        setState(() {
          q2_5 = value;
        });
        break;
      case "q2_6":
        setState(() {
          q2_6 = value;
        });
        break;
      case "q2_7":
        setState(() {
          q2_7 = value;
        });
        break;
      case "q2_8":
        setState(() {
          q2_8 = value;
        });
        break;
      case "q2_9":
        setState(() {
          q2_9 = value;
        });
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StepsWrapper(
      title: 'CPARA healthy widget',
      children: [
        // Healthy Goal 1
        HealthyGoalBlock(
          descriptionHeading:
              "Healthy: Goal 1: Increase diagnosis of HIV infection",
          descriptionText:
              "Benchmark 1: All children, adolescents, and caregivers in the household have known HIV status or a test is not required based on risk assessment",
          descriptionSubText:
              "Caseworker is advised to refer to job aid about discussing sensitive topics for this section, if needed.",
          sections: [
            // Section 1.1 and 1.2
            QuestionsSection(
              isTopDividerThere: false,
              title: "HIV diagnosis for children",
              questions: [
                QuestionBlock(
                  isTopDividerThere: false,
                  groupValue: q1_1,
                  isOptional: false,
                  question:
                      "1.1 Have all your children been tested for HIV and their HIV status known (HIV negative, positive) ?",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q1_1", val),
                ),
                QuestionBlock(
                  isTopDividerThere: false,
                  isOptional: false,
                  groupValue: q1_2,
                  question:
                      "1.2 For those with unknown HIV status, have they been screened for HIV risk and results showed test not required ?",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q1_2", val),
                ),
              ],
            ),

            // Section 1.3
            QuestionsSection(
              isTopDividerThere: false,
              title: "Early Infant Diagnosis",
              questions: [
                QuestionBlock(
                  isTopDividerThere: false,
                  isOptional: false,
                  groupValue: q1_3,
                  question:
                      "1.3 If there is an infant Exposed to HIV (HEI), has the final HIV status been confirmed at 18 months or one week after cessation of breastfeeding, whichever comes later?",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q1_3", val),
                ),
              ],
            ),

            // Question 1.4 and 1.5
            QuestionsSection(
              isTopDividerThere: false,
              title: "HIV diagnosis for caregiver",
              questions: [
                QuestionBlock(
                  isTopDividerThere: false,
                  isOptional: false,
                  groupValue: q1_4,
                  question:
                      "1.4 Is the HIV status of the caregiver known (positive, negative)?",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q1_4", val),
                ),
                QuestionBlock(
                  isTopDividerThere: false,
                  groupValue: q1_5,
                  isOptional: false,
                  question:
                      "1.5 For caregiver with unknown HIV status have they been screened for HIV risk and the results showing test not required?",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q1_5", val),
                ),
              ],
            ),
          ],
          instructions:
              """(Adolescent must have tested HIV negative or screened for HIV risk and HIV test was not required in the last six months)""",
        ),

        // Healthy Goal 2
        HealthyGoalBlock(
          descriptionHeading:
              "Healthy: Goal 2: Increase HIV treatment adherence, continuity of treatment and viral suppression",
          descriptionText:
              "Benchmark 2: All HIV+ children, adolescents, and caregivers in the household with a viral load result documented in the medical record and/or laboratory information systems (LIS) have been virally suppressed for the last 12 months. All HIV+ children, adolescents, and caregivers in the household have adhered to treatment for 12 months after initiation of antiretroviral therapy",
          descriptionSubText:
              "Note: The questions below apply to HHs with child/adolescent living with HIV and HIV positive caregivers (If the child/caregiver has not sustained viral load suppression for the past 12 months the benchmark is achieved if they are adhering to treatment for the last 12 months)",
          sections: [
            // Section 2.1 - 2.3
            QuestionsSection(
              isTopDividerThere: false,
              title: "Children 0-12",
              questions: [
                QuestionBlock(
                  isTopDividerThere: false,
                  groupValue: q2_1,
                  isOptional: false,
                  question:
                      "2.1 Have all HIV positive children on treatment with documented viral load results been suppressed in the past 12 months? ",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q2_1", val),
                ),
                QuestionBlock(
                  isTopDividerThere: false,
                  isOptional: false,
                  groupValue: q2_2,
                  question:
                      "2.2 For those with no documented viral load results; Have all the children living with HIV been attending their appointments regularly for the past 12 months (check CCC card to confirm adherence to treatment)",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q2_2", val),
                ),
                QuestionBlock(
                  isTopDividerThere: true,
                  isOptional: false,
                  groupValue: q2_3,
                  question:
                      "2.3 Have all HIV+ children been regularly taking medication without missing doses for the past 12 months (reported by caregiver for the 0-12 years)?",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q2_3", val),
                ),
              ],
            ),

            // Section 2.4 - 2.6
            QuestionsSection(
              isTopDividerThere: false,
              title: "Adolescents and children above 12 years",
              questions: [
                QuestionBlock(
                  isTopDividerThere: false,
                  isOptional: false,
                  groupValue: q2_4,
                  question:
                      "2.4 Have all HIV positive children and adolescents (12years and above) on treatment with documented viral load results been suppressed in the past 12 months?",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q2_4", val),
                ),
                QuestionBlock(
                  isTopDividerThere: false,
                  isOptional: false,
                  groupValue: q2_5,
                  question:
                      "2.5 For those with no documented viral load results; Have all the children and adolescents (12years and above) living with HIV been attending their appointments regularly for the past 12 months (check CCC card to confirm adherence to treatment)",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q2_5", val),
                ),
                QuestionBlock(
                  isTopDividerThere: false,
                  isOptional: false,
                  groupValue: q2_6,
                  question:
                      "2.6 Have all HIV+ adolescent been regularly taking medication without missing doses for the past 12 months? (Adolescents self-reported).",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q2_6", val),
                ),
              ],
            ),

            // Question 2.7 to 2.9
            QuestionsSection(
              isTopDividerThere: false,
              title: "Caregiver",
              questions: [
                QuestionBlock(
                  isTopDividerThere: false,
                  isOptional: false,
                  groupValue: q2_7,
                  question:
                      "2.7 Have all HIV positive caregivers on treatment with documented viral load results been suppressed in the past 12 months?",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q1_4", val),
                ),
                QuestionBlock(
                  isTopDividerThere: false,
                  groupValue: q1_5,
                  isOptional: false,
                  question:
                      "2.8 For those with no documented viral load results; Have the caregiver living with HIV been attending their appointments regularly for the past 12 months (check CCC card to confirm adherence to treatment)",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q1_5", val),
                ),
              ],
            ),
          ],
          instructions: "",
        ),
      ],
    );
  }
}

const smallSpacingAmount = 10.0;
const headingPaddingAmount = 5.0;
const descriptionPadding = 5.0;
const headingSpacing = SizedBox(
  height: headingPaddingAmount,
);
const smallSpacing = SizedBox(
  height: smallSpacingAmount,
);

// An entire goal of the health section e.g health goal 1
class HealthyGoalBlock extends StatelessWidget {
  final String instructions; // Instructions after blue box
  final List<QuestionsSection> sections; // The questions
  final String descriptionHeading; // Heading in blue description
  final String descriptionText; // Description of blue box
  final String descriptionSubText; // Sub text of description in blue box

  const HealthyGoalBlock(
      {required this.sections,
      required this.instructions,
      required this.descriptionHeading,
      required this.descriptionText,
      required this.descriptionSubText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Description
        HealthDescription(
            heading: descriptionHeading,
            body: descriptionText,
            subBody: descriptionSubText),
        smallSpacing,
        // Instructions
        HealthInstructions(
          description: instructions,
          isTopDividerThere: true,
        ),
        // Questions
        for (var i in sections) i
      ],
    );
  }
}

// Wraps widget in between 2 dividers or only the bottom if top is not there
class SqueezedBetweenDivider extends StatelessWidget {
  final Widget widget;
  final bool isTopSpacingThere;

  const SqueezedBetweenDivider(
      {required this.widget, required this.isTopSpacingThere, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isTopSpacingThere == true) const Divider(),
        smallSpacing,
        widget,
        smallSpacing,
        const Divider()
      ],
    );
  }
}

const lightBlue = Color.fromRGBO(217, 237, 247, 1);

class HealthDescription extends StatelessWidget {
  final String heading; // The heading of the description
  final String body; // The body of the description
  final String subBody; // The smaller text below body

  const HealthDescription(
      {required this.heading,
      required this.body,
      required this.subBody,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(smallSpacingAmount),
      padding: const EdgeInsets.all(headingPaddingAmount),
      color: lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(headingPaddingAmount),
        child: Column(children: [
          Text(
            heading,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          headingSpacing, // Heading text
          Text(
            body,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          headingSpacing,
          Text(
            subBody,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
          ) // Body text
        ]),
      ),
    );
  }
}

// Instruction that are found before any section of questions
class HealthInstructions extends StatelessWidget {
  final bool isTopDividerThere;
  final String description;

  const HealthInstructions(
      {required this.description, required this.isTopDividerThere, super.key});

  @override
  Widget build(BuildContext context) {
    return SqueezedBetweenDivider(
        isTopSpacingThere: isTopDividerThere,
        widget:
            Text(description, style: Theme.of(context).textTheme.bodyLarge));
  }
}

const notOptionalStar = TextSpan(
  text: ' *',
  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
);

// The text of the question
// If the question is not optional a red star is shown
class QuestionText extends StatelessWidget {
  final String text;
  final bool isOptional; // Whether question is optional or not

  const QuestionText({required this.text, required this.isOptional, super.key});

  @override
  Widget build(BuildContext context) {
    // Bold text that shows the question
    return RichText(
      text: TextSpan(
          text: text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
          children: [if (isOptional == false) notOptionalStar]),
    );
  }
}

typedef UpdateRadioButton = void Function(RadioButtonOptions? value);

// This deals with the block that contains the question and its choices
class QuestionBlock extends StatelessWidget {
  final String question;
  final RadioButtonOptions? groupValue; // Current value of radio button
  final UpdateRadioButton
      updateRadioButton; // Function to update the radio button
  final bool isNAAvailable; // Whether to show the NA option or not
  final bool isOptional; // Whether or not the question is optional
  final bool isTopDividerThere;

  const QuestionBlock(
      {required this.groupValue,
      required this.isTopDividerThere,
      required this.isOptional,
      required this.question,
      required this.isNAAvailable,
      required this.updateRadioButton,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SqueezedBetweenDivider(
      widget: Column(
        children: [
          // Text For The Question
          QuestionText(
            text: question,
            isOptional: isOptional,
          ),
          smallSpacing,
          // The Options To Display
          CustomRadioButton(
              isNaAvailable: isNAAvailable, optionSelected: updateRadioButton)
        ],
      ),
      isTopSpacingThere: isTopDividerThere,
    );
  }
}

// The green heading box ontop of a specific section of questions
class QuestionSectionHeading extends StatelessWidget {
  final String title;
  final bool isTopDividerThere;

  const QuestionSectionHeading(
      {required this.title, required this.isTopDividerThere, super.key});

  @override
  Widget build(BuildContext context) {
    return SqueezedBetweenDivider(
        isTopSpacingThere: isTopDividerThere,
        widget: Padding(
          padding: const EdgeInsets.all(smallSpacingAmount),
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              width: constraints.maxHeight * 0.75,
              color: kPrimaryColor,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(headingPaddingAmount),
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              )),
            );
          }),
        ));
  }
}

// A specific section of questions
class QuestionsSection extends StatelessWidget {
  final String title;
  final List<QuestionBlock> questions;
  final bool isTopDividerThere;

  const QuestionsSection(
      {required this.title,
      required this.questions,
      required this.isTopDividerThere,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // The heading to display
        QuestionSectionHeading(
          title: title,
          isTopDividerThere: isTopDividerThere,
        ),
        // The questions to display
        for (var i in questions) i
      ],
    );
  }
}

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
  RadioButtonOptions? group1Final;
  RadioButtonOptions? group2Final;
  RadioButtonOptions? group3Final;
  RadioButtonOptions? group3Initial;
  RadioButtonOptions? group2Initial;
  RadioButtonOptions? initial2_1;
  RadioButtonOptions? initial2_4;
  RadioButtonOptions? initial2_7;

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
      case "initial_3":
        setState(() {
          group3Initial = value;
        });
        break;
      case "initial_2":
        setState(() {
          group2Initial = value;
        });
        break;
      case "initial2_1":
        setState(() {
          initial2_1 = value;
        });
        break;
      case "initial2_4":
        setState(() {
          initial2_4 = value;
        });
        break;
      case "initial2_7":
        setState(() {
          initial2_7 = value;
        });
        break;
      default:
        break;
    }
  }

  void noChangeToRadio(RadioButtonOptions? val) {}

  @override
  Widget build(BuildContext context) {
    return StepsWrapper(
      title: 'CPARA healthy widget',
      children: [
        // Healthy Goal 1
        HealthyGoalBlock(
          doesSectionDependOnInitialAnswer: false,
          updateFinalFormRadio: noChangeToRadio,
          showNAInFinalResult: false,
          finalBlockQuestion: "Has the household achieved this benchmark?",
          finalResult: group1Final,
          descriptionHeading:
              "Healthy: Goal 1: Increase diagnosis of HIV infection",
          descriptionText:
              "Benchmark 1: All children, adolescents, and caregivers in the household have known HIV status or a test is not required based on risk assessment",
          descriptionSubText:
              "Caseworker is advised to refer to job aid about discussing sensitive topics for this section, if needed.",
          sections: [
            // Section 1.1 and 1.2
            QuestionsSection(
              doesSectionDependOnInitialAnswer: false,
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
              doesSectionDependOnInitialAnswer: false,
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
              doesSectionDependOnInitialAnswer: false,
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
          doesSectionDependOnInitialAnswer: true,
          initalQuestion:
              "Is there anyone who is HIV positive in the Household ?",
          isNAInIntial: false,
          initalQuestionValue: group2Initial,
          updateInitialQuestion: (RadioButtonOptions? val) =>
              updateQuestion("initial_2", val),
          finalBlockQuestion: "Has the household achieved this benchmark?",
          showNAInFinalResult: false,
          finalResult: group2Final,
          updateFinalFormRadio: noChangeToRadio,
          descriptionHeading:
              "Healthy: Goal 2: Increase HIV treatment adherence, continuity of treatment and viral suppression",
          descriptionText:
              "Benchmark 2: All HIV+ children, adolescents, and caregivers in the household with a viral load result documented in the medical record and/or laboratory information systems (LIS) have been virally suppressed for the last 12 months. All HIV+ children, adolescents, and caregivers in the household have adhered to treatment for 12 months after initiation of antiretroviral therapy",
          descriptionSubText:
              "Note: The questions below apply to HHs with child/adolescent living with HIV and HIV positive caregivers (If the child/caregiver has not sustained viral load suppression for the past 12 months the benchmark is achieved if they are adhering to treatment for the last 12 months)",
          sections: [
            // Section 2.1 - 2.3
            QuestionsSection(
              doesSectionDependOnInitialAnswer: true,
              initalQuestion:
                  "Is there a child 0 - 12 years who is HIV positive ?",
              initalQuestionValue: initial2_1,
              updateInitialQuestion: (RadioButtonOptions? val) =>
                  updateQuestion("initial2_1", val),
              isNAInIntial: false,
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
                  isTopDividerThere: false,
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
              doesSectionDependOnInitialAnswer: true,
              updateInitialQuestion: (RadioButtonOptions? value) =>
                  updateQuestion("initial2_4", value),
              isNAInIntial: false,
              initalQuestion:
                  "Is there an adolescents or a child above 12 years who is HIV positive ? ",
              initalQuestionValue: initial2_4,
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
              doesSectionDependOnInitialAnswer: true,
              initalQuestion: "Is the caregiver HIV positive ? ",
              initalQuestionValue: initial2_7,
              updateInitialQuestion: (RadioButtonOptions? value) =>
                  updateQuestion("initial2_7", value),
              isNAInIntial: false,
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
                      updateQuestion("q2_7", val),
                ),
                QuestionBlock(
                  isTopDividerThere: false,
                  groupValue: q2_8,
                  isOptional: false,
                  question:
                      "2.8 For those with no documented viral load results; Have the caregiver living with HIV been attending their appointments regularly for the past 12 months (check CCC card to confirm adherence to treatment)",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q2_8", val),
                ),
                QuestionBlock(
                  isTopDividerThere: false,
                  groupValue: q2_9,
                  isOptional: false,
                  question:
                      "2.9 Have all HIV+ caregivers been regularly taking medication without missing doses for the past 12 months? (Caregiver self-reported).",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q2_9", val),
                ),
              ],
            ),
          ],
          instructions: "",
        ),

        // Healthy Block 3
        HealthyGoalBlock(
          doesSectionDependOnInitialAnswer: true,
          initalQuestionValue: group3Initial,
          updateInitialQuestion: (RadioButtonOptions? val) =>
              updateQuestion("initial_3", val),
          isNAInIntial: false,
          initalQuestion: "Healthy: Goal 3: Reduce Risk of HIV Infection",
          finalBlockQuestion: "",
          showNAInFinalResult: false,
          finalResult: group3Final,
          updateFinalFormRadio: noChangeToRadio,
          sections: [],
          descriptionHeading: "Healthy: Goal 3: Reduce Risk of HIV Infection",
          descriptionText:
              "Benchmark3: All adolescents 10-17 years of age in the household have key knowledge about preventing HIV infection Adolescents aged 10-17 can describe at least two HIV infection risks in their local community, can provide at least one example of how they can protect themselves against HIV risk, and can correctly describe the location of at least one place where HIV prevention support is available.",
          descriptionSubText:
              "Note: For HHs with no adolescent girls and boys, skip questions below and select “N/A” for “Achievement of this benchmark.”",
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

// The grey box that shows the final result of the section
class FinalResultBox extends StatelessWidget {
  final RadioButtonOptions? result; // The computed result
  final String question; // Question to show
  final bool isTopDividerThere;
  final bool isNAAvailable; // Whether to show NA as option
  final UpdateRadioButton updateRadioButton;

  const FinalResultBox(
      {required this.isTopDividerThere,
      required this.isNAAvailable,
      required this.result,
      required this.question,
      required this.updateRadioButton,
      super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        return Container(
          padding: const EdgeInsets.all(smallSpacingAmount),
          width: constraints.maxWidth * 0.75,
          decoration: const BoxDecoration(
              color: finalResultGrey,
              border: Border(
                  left: BorderSide(color: finalResultDarkGrey, width: 2.0))),
          child: Center(
            child: QuestionBlock(
              isBigAndBold: false,
              tempFix: true,
              groupValue: result,
              isTopDividerThere: isTopDividerThere,
              isOptional: false,
              question: question,
              isNAAvailable: isNAAvailable,
              updateRadioButton: updateRadioButton,
            ),
          ),
        );
      }),
    );
  }
}

// An entire goal of the health section e.g health goal 1
class HealthyGoalBlock extends StatelessWidget {
  final String instructions; // Instructions after blue box
  final List<QuestionsSection> sections; // The questions
  final String descriptionHeading; // Heading in blue description
  final String descriptionText; // Description of blue box
  final String descriptionSubText; // Sub text of description in blue box
  final bool showNAInFinalResult;
  final RadioButtonOptions? finalResult;
  final String
      finalBlockQuestion; // Question to show at grey box at bottom of group
  final UpdateRadioButton updateFinalFormRadio;
  final bool
      doesSectionDependOnInitialAnswer; // Whehter the section depends on initial answer
  final RadioButtonOptions? initalQuestionValue;
  final String initalQuestion; // Question to ask
  final UpdateRadioButton? updateInitialQuestion;
  final bool isNAInIntial;

  const HealthyGoalBlock(
      {required this.sections,
      this.instructions = "",
      required this.doesSectionDependOnInitialAnswer,
      required this.descriptionHeading,
      required this.descriptionText,
      required this.descriptionSubText,
      required this.showNAInFinalResult,
      required this.finalResult,
      required this.finalBlockQuestion,
      required this.updateFinalFormRadio,
      this.initalQuestionValue = RadioButtonOptions.yes,
      this.initalQuestion = "",
      this.updateInitialQuestion,
      this.isNAInIntial = false,
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
        // Initial Section
        if (doesSectionDependOnInitialAnswer == true)
          Padding(
            padding: const EdgeInsets.all(smallSpacingAmount),
            child: HealthInitialQuestion(
              groupVal: initalQuestionValue,
              isTopDividerThere: false,
              question: initalQuestion,
              updateRadioButton: updateInitialQuestion!,
              isNAAvailable: isNAInIntial,
            ),
          ),
        if (instructions.isNotEmpty)
          // Instructions
          HealthInstructions(
            description: instructions,
            isTopDividerThere: true,
          ),
        // Questions
        for (var i in sections) i,
        smallSpacing,

        // Final Result that is determined by all other results
        FinalResultBox(
          isTopDividerThere: false,
          isNAAvailable: showNAInFinalResult,
          result: finalResult,
          question: finalBlockQuestion,
          updateRadioButton: updateFinalFormRadio,
        ),
      ],
    );
  }
}

// The initial question that is asked that determines whether or not to display questions
class HealthInitialQuestion extends StatelessWidget {
  final RadioButtonOptions? groupVal;
  final bool isTopDividerThere;
  final String question;
  final bool isNAAvailable;
  final UpdateRadioButton updateRadioButton;

  const HealthInitialQuestion(
      {required this.groupVal,
      required this.isTopDividerThere,
      required this.question,
      required this.updateRadioButton,
      required this.isNAAvailable,
      super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        return Container(
          width: constraints.maxWidth * 0.9,
          color: darkBlue,
          child: QuestionBlock(
            isBigAndBold: true,
            groupValue: groupVal,
            isTopDividerThere: isTopDividerThere,
            isOptional: true,
            question: question,
            isNAAvailable: isNAAvailable,
            updateRadioButton: updateRadioButton,
          ),
        );
      }),
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
const finalResultGrey = Color.fromRGBO(219, 219, 219, 1);
const finalResultDarkGrey = Color.fromRGBO(59, 59, 59, 1);
const darkBlue = Color.fromRGBO(190, 226, 239, 1);

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
  final bool isBigAndBold;

  const QuestionText(
      {required this.text,
      required this.isOptional,
      required this.isBigAndBold,
      super.key});

  @override
  Widget build(BuildContext context) {
    var normalTheme = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(fontWeight: FontWeight.bold);
    var bigAndBold = const TextStyle(
        fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.black);
    // Bold text that shows the question
    return RichText(
      text: TextSpan(
          text: text,
          style: isBigAndBold == true ? bigAndBold : normalTheme,
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
  final bool tempFix; // To be removed
  final bool isBigAndBold; // Whether to make the question text big and bold

  const QuestionBlock(
      {required this.groupValue,
      required this.isTopDividerThere,
      required this.isOptional,
      required this.question,
      required this.isNAAvailable,
      this.isBigAndBold = false,
      required this.updateRadioButton,
      this.tempFix = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    if (tempFix == false) {
      return SqueezedBetweenDivider(
        widget: Column(
          children: [
            // Text For The Question
            QuestionText(
              isBigAndBold: isBigAndBold,
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
    } else {
      return SqueezedBetweenDivider(
        widget: Column(
          children: [
            // Text For The Question
            QuestionText(
              isBigAndBold: isBigAndBold,
              text: question,
              isOptional: isOptional,
            ),
            smallSpacing,
            // The Options To Display
            MyCustomRadioListTileColumn(
                isNaAvailable: isNAAvailable,
                updateRadioButton: updateRadioButton,
                groupValue: groupValue)
          ],
        ),
        isTopSpacingThere: isTopDividerThere,
      );
    }
  }
}

class MyCustomRadioListTileColumn extends StatelessWidget {
  final bool isNaAvailable;
  final UpdateRadioButton updateRadioButton;
  final RadioButtonOptions? groupValue;

  const MyCustomRadioListTileColumn(
      {required this.isNaAvailable,
      required this.updateRadioButton,
      required this.groupValue,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RadioListTile<RadioButtonOptions>(
            title: const Text('Yes'),
            value: RadioButtonOptions.yes,
            groupValue: groupValue,
            onChanged: updateRadioButton),
        RadioListTile<RadioButtonOptions>(
            title: const Text('No'),
            value: RadioButtonOptions.no,
            groupValue: groupValue,
            onChanged: updateRadioButton),
        isNaAvailable
            ? RadioListTile<RadioButtonOptions>(
                title: const Text('N/A'),
                value: RadioButtonOptions.na,
                groupValue: groupValue,
                onChanged: updateRadioButton)
            : const SizedBox.shrink(),
      ],
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
  final bool
      doesSectionDependOnInitialAnswer; // Whehter the section depends on initial answer
  final RadioButtonOptions? initalQuestionValue;
  final String initalQuestion; // Question to ask
  final UpdateRadioButton? updateInitialQuestion;
  final bool isNAInIntial;

  const QuestionsSection(
      {required this.title,
      required this.questions,
      required this.isTopDividerThere,
      required this.doesSectionDependOnInitialAnswer,
      this.initalQuestionValue = RadioButtonOptions.yes,
      this.initalQuestion = "",
      this.updateInitialQuestion,
      this.isNAInIntial = false,
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

        // Depend on intial question
        if (doesSectionDependOnInitialAnswer == true)
          Padding(
            padding: const EdgeInsets.all(smallSpacingAmount),
            child: HealthInitialQuestion(
                groupVal: initalQuestionValue,
                isTopDividerThere: false,
                question: initalQuestion,
                updateRadioButton: updateInitialQuestion!,
                isNAAvailable: isNAInIntial),
          ),

        // The questions to display
        for (var i in questions) i
      ],
    );
  }
}

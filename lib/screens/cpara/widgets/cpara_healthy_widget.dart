import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/cpara/provider/cpara_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_stable_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../registry/organisation_units/widgets/steps_wrapper.dart';
import '../model/health_model.dart';

class CparaHealthyWidget extends StatefulWidget {
  const CparaHealthyWidget({super.key});

  @override
  State<CparaHealthyWidget> createState() => _CparaHealthyWidgetState();
}

class _CparaHealthyWidgetState extends State<CparaHealthyWidget> {
  // State of the questions
  RadioButtonOptions? q1_1ChildrenHivTested;
  RadioButtonOptions? q1_2childrenUnknownStatus;
  RadioButtonOptions? q1_3InfantExposedHIV;
  RadioButtonOptions? q1_4HivCaregiverUnknown;
  RadioButtonOptions? q1_5CaregiverSceened;
  RadioButtonOptions? q2_1SuppresedPast12;
  RadioButtonOptions? q2_2ChildrenRegularAttendTreatment;
  RadioButtonOptions? q2_3ChildrenNotMissDose;
  RadioButtonOptions? q2_4DocumentedChildrenSuppressed;
  RadioButtonOptions? q2_5NoDocumentAttendTreatment;
  RadioButtonOptions? q2_6AdolocentRegularMedicate;
  RadioButtonOptions? q2_7HIVCaregiverSuppress;
  RadioButtonOptions? q2_8NoDocumentCaregiverAppointment;
  RadioButtonOptions? q2_9CaregiverRegularlyMedicate;
  RadioButtonOptions? goal2Summary;
  RadioButtonOptions? goal3Summary;
  RadioButtonOptions? goal4Summary;
  RadioButtonOptions? goal3InitialAnswer;
  RadioButtonOptions? goal2InitialAnswer;
  RadioButtonOptions? suppresedPast12Initial;
  RadioButtonOptions? childLessThan2Initial;
  RadioButtonOptions? documentedChildrenSuppressedInitial;
  RadioButtonOptions? noDocumentCaregiverAppointmentInitial;
  RadioButtonOptions? goal4Initial;
  RadioButtonOptions? q4_1BelowAge5MUAC;
  RadioButtonOptions? q4_2Below5BipedalEdema;
  RadioButtonOptions? q4_3MalnourishedTreated;
  RadioButtonOptions? q4_4Under2Immunized;
  RadioButtonOptions? set3_1final;
  RadioButtonOptions? set3_2final;
  RadioButtonOptions? set3_3final;

  // List of children
  late List<HealthChild> children;

  // Initiallized Data
  @override
  void initState() {
    super.initState();
    List<CaseLoadModel> models = context.read<CparaProvider>().children ?? [];
    // Get instance of model from provider
    HealthModel healthModel =
        context.read<CparaProvider>().healthModel ?? HealthModel();

    // Initialize children
    children = [];

    if (healthModel.childrenQuestions != null) {
      set3_1final = RadioButtonOptions.na;
      set3_2final = RadioButtonOptions.na;
      set3_3final = RadioButtonOptions.na;
      for (HealthChild child in healthModel.childrenQuestions!) {
        children.add(child);
      }
    } else {
      for (CaseLoadModel model in models) {
        DateTime birthDate = DateTime.parse(model.dateOfBirth!);
        DateTime currentDate = DateTime.now();
        int age = currentDate.year - birthDate.year;
        if (age >= 10 && age <= 17) {
          children.add(HealthChild(
              id: "${model.cpimsId}",
              question1: "",
              question2: "",
              question3: "",
              name: "${model.ovcFirstName} ${model.ovcSurname}"));
        }
      }
    }

    // for(int i = 0; i < children.length; i++){
    //   HealthChild child = children[i];
    //   children[i].question1 = child.question1;
    //   children[i].question2 = child.question2;
    //   children[i].question3 = child.question3;
    // }

    // Initialize Details
    // Overall questions

    goal2InitialAnswer = healthModel.overallQuestion1 == null
        ? goal2InitialAnswer
        : convertingStringToRadioButtonOptions(healthModel.overallQuestion1!);
    suppresedPast12Initial = healthModel.overallQuestion2 == null
        ? suppresedPast12Initial
        : convertingStringToRadioButtonOptions(healthModel.overallQuestion2!);
    documentedChildrenSuppressedInitial = healthModel.overallQuestion3 == null
        ? documentedChildrenSuppressedInitial
        : convertingStringToRadioButtonOptions(healthModel.overallQuestion3!);
    noDocumentCaregiverAppointmentInitial = healthModel.overallQuestion4 == null
        ? noDocumentCaregiverAppointmentInitial
        : convertingStringToRadioButtonOptions(healthModel.overallQuestion4!);
    goal3InitialAnswer = healthModel.overallQuestion5 == null
        ? goal3InitialAnswer
        : convertingStringToRadioButtonOptions(healthModel.overallQuestion5!);
    goal4Initial = healthModel.overallQuestion6 == null
        ? goal4Initial
        : convertingStringToRadioButtonOptions(healthModel.overallQuestion6!);
    childLessThan2Initial = healthModel.overallQuestion7 == null
        ? childLessThan2Initial
        : convertingStringToRadioButtonOptions(healthModel.overallQuestion7!);
    //specific questions
    q1_1ChildrenHivTested = healthModel.question1 == null
        ? q1_1ChildrenHivTested
        : convertingStringToRadioButtonOptions(healthModel.question1!);
    q1_2childrenUnknownStatus = healthModel.question2 == null
        ? q1_2childrenUnknownStatus
        : convertingStringToRadioButtonOptions(healthModel.question2!);
    q1_3InfantExposedHIV = healthModel.question3 == null
        ? q1_3InfantExposedHIV
        : convertingStringToRadioButtonOptions(healthModel.question3!);
    q1_4HivCaregiverUnknown = healthModel.question4 == null
        ? q1_4HivCaregiverUnknown
        : convertingStringToRadioButtonOptions(healthModel.question4!);
    q1_5CaregiverSceened = healthModel.question5 == null
        ? q1_5CaregiverSceened
        : convertingStringToRadioButtonOptions(healthModel.question5!);
    q2_1SuppresedPast12 = healthModel.question6 == null
        ? q2_1SuppresedPast12
        : convertingStringToRadioButtonOptions(healthModel.question6!);
    q2_2ChildrenRegularAttendTreatment = healthModel.question7 == null
        ? q2_2ChildrenRegularAttendTreatment
        : convertingStringToRadioButtonOptions(healthModel.question7!);
    q2_3ChildrenNotMissDose = healthModel.question8 == null
        ? q2_3ChildrenNotMissDose
        : convertingStringToRadioButtonOptions(healthModel.question8!);
    q2_4DocumentedChildrenSuppressed = healthModel.question9 == null
        ? q2_4DocumentedChildrenSuppressed
        : convertingStringToRadioButtonOptions(healthModel.question9!);
    q2_5NoDocumentAttendTreatment = healthModel.question10 == null
        ? q2_5NoDocumentAttendTreatment
        : convertingStringToRadioButtonOptions(healthModel.question10!);
    q2_6AdolocentRegularMedicate = healthModel.question11 == null
        ? q2_6AdolocentRegularMedicate
        : convertingStringToRadioButtonOptions(healthModel.question11!);
    q2_7HIVCaregiverSuppress = healthModel.question12 == null
        ? q2_7HIVCaregiverSuppress
        : convertingStringToRadioButtonOptions(healthModel.question12!);
    q2_8NoDocumentCaregiverAppointment = healthModel.question13 == null
        ? q2_8NoDocumentCaregiverAppointment
        : convertingStringToRadioButtonOptions(healthModel.question13!);
    q2_9CaregiverRegularlyMedicate = healthModel.question14 == null
        ? q2_9CaregiverRegularlyMedicate
        : convertingStringToRadioButtonOptions(healthModel.question14!);
    q4_1BelowAge5MUAC = healthModel.question15 == null
        ? q4_1BelowAge5MUAC
        : convertingStringToRadioButtonOptions(healthModel.question15!);
    q4_2Below5BipedalEdema = healthModel.question16 == null
        ? q4_2Below5BipedalEdema
        : convertingStringToRadioButtonOptions(healthModel.question16!);
    q4_3MalnourishedTreated = healthModel.question17 == null
        ? q4_3MalnourishedTreated
        : convertingStringToRadioButtonOptions(healthModel.question17!);
    q4_4Under2Immunized = healthModel.question18 == null
        ? q4_4Under2Immunized
        : convertingStringToRadioButtonOptions(healthModel.question18!);
  }

  void noChangeToRadio(RadioButtonOptions? val) {}

  // // A function that computes whether the final result of a section is yes or no given the values of the members
  RadioButtonOptions allShouldBeYes(
      List<RadioButtonOptions?> members, String message) {
    debugPrint(members.toString() + message);
    // If all the values are yes return RadioButtonOptions.yes, if not return RadioButtonOptions.no
    if (members.isEmpty) {
      return RadioButtonOptions.yes;
    } else if (members.any(
        (element) => element == RadioButtonOptions.no || element == null)) {
      return RadioButtonOptions.no;
    } else {
      return RadioButtonOptions.yes;
    }
  }

  RadioButtonOptions allShouldBeYesOrNA(
      List<RadioButtonOptions?> members, String message) {
    debugPrint(members.toString() + message);
    // If all the values are yes return RadioButtonOptions.yes, if not return RadioButtonOptions.no
    if (members.isEmpty) {
      return RadioButtonOptions.na;
    } else if (members.any(
        (element) => element == RadioButtonOptions.no || element == null)) {
      return RadioButtonOptions.no;
    } else {
      return RadioButtonOptions.yes;
    }
  }

  // // When you skip a section or goal the answers of the skipped questions should be set to NA
  // void updateAnswersOnSkip(List<String> answersToChange) {
  //   for (var i in answersToChange) {
  //     updateQuestion(i, RadioButtonOptions.na);
  //   }
  // }

  // // When you skip set all the values to yes
  // void setAnswersToYesOnSkip(List<String> answersToChange) {
  //   for (var i in answersToChange) {
  //     updateQuestion(i, RadioButtonOptions.yes);
  //   }
  // }

  // void setAllToASingleValue(
  //     List<String> answersToChange, RadioButtonOptions? val) {
  //   // Seta all the values to val
  //   for (var i in answersToChange) {
  //     updateQuestion(i, val);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<CparaProvider>(
      builder: (context, model, _) {
        return Text("All is good!");
      },
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

class HealthCardDetails extends StatelessWidget {
  final String childName;

  const HealthCardDetails({required this.childName, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Child Name",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12.0),
            ),
            Text(
              childName,
              style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0),
            )
          ],
        )
      ],
    );
  }
}

class HealthCard extends StatelessWidget {
  final String childName;
  final List<QuestionBlock> questions;
  final bool isTopDividerThere;

  const HealthCard(
      {required this.childName,
      required this.questions,
      required this.isTopDividerThere,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Children Details Row
        HealthCardDetails(childName: childName),

        // Question
        for (var i in questions) i
      ],
    );
  }
}

class FinalTableRow extends StatelessWidget {
  final String question; // The question to show at the top
  final List<QuestionBlock> questions; // The questions to show
  final bool isTopDividerThere;

  const FinalTableRow(
      {required this.question,
      required this.questions,
      required this.isTopDividerThere,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(question), smallSpacing, for (var i in questions) i],
    );
  }
}

class HealthTable extends StatelessWidget {
  final List<HealthCard> healthCards;
  final FinalTableRow finalTableRow;

  const HealthTable(
      {required this.healthCards, required this.finalTableRow, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [for (var i in healthCards) i, finalTableRow],
    ));
  }
}

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
  final HealthTable? table; // Table to show in the group

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
      this.table,
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

        // Table if it is provided
        if (table != null) table!,

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
  final bool skipQuestion;

  const HealthInitialQuestion(
      {required this.groupVal,
      required this.isTopDividerThere,
      required this.question,
      required this.updateRadioButton,
      required this.isNAAvailable,
      this.skipQuestion = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        if (skipQuestion == false) {
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
        } else {
          return Container(
              width: constraints.maxWidth * 0.9,
              color: darkBlue,
              child: const SkippedText(text: skippedQuestionText));
        }
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

// The text to show when a question is skipped
class SkippedText extends StatelessWidget {
  final String text; // Text to show

  const SkippedText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 17.0, fontStyle: FontStyle.italic, color: Colors.grey[600]),
    );
  }
}

class WarningText extends StatelessWidget {
  final String text; // Text to show
  const WarningText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.red,
          fontStyle: FontStyle.italic),
    );
  }
}

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
  final String
      warningText; // Text that is in red and used as a warning or a caution

  const QuestionBlock(
      {required this.groupValue,
      required this.isTopDividerThere,
      required this.isOptional,
      required this.question,
      required this.isNAAvailable,
      this.isBigAndBold = false,
      required this.updateRadioButton,
      this.tempFix = false,
      this.warningText = "",
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
            // Show warning text if it is provided
            if (warningText.isNotEmpty) WarningText(text: warningText),
            // The Options To Display
            CustomRadioButton(
              isNaAvailable: isNAAvailable,
              optionSelected: updateRadioButton,
              option: groupValue,
            )
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
    if (title.isEmpty) {
      return const SizedBox.shrink();
    } else {
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
}

const skippedQuestionText = "Skipped Question";

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
  final bool skipSection; // Whether or not to skip the questions in the section
  final bool
      skipSectionButShowInitial; // Whether or not to skip the question but you still show the initial

  const QuestionsSection(
      {required this.title,
      required this.questions,
      required this.isTopDividerThere,
      required this.doesSectionDependOnInitialAnswer,
      this.initalQuestionValue = RadioButtonOptions.yes,
      this.initalQuestion = "",
      this.updateInitialQuestion,
      this.isNAInIntial = false,
      this.skipSection = false,
      this.skipSectionButShowInitial = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // The heading to display, should only be shown when the question is not skipped
        if (skipSection == false)
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
                skipQuestion:
                    skipSectionButShowInitial == false && skipSection == true,
                isNAAvailable: isNAInIntial),
          ),

        // The questions to display
        for (var i in questions)
          if (skipSection == true)
            const SkippedText(text: skippedQuestionText)
          else
            i
      ],
    );
  }
}

class HealthModelCollected extends StatelessWidget {
  const HealthModelCollected({super.key});

  @override
  Widget build(BuildContext context) {
    var healthModel =
        Provider.of<CparaProvider>(context, listen: false).healthModel;
    return Column(
      children: [
        const Text("Health Model:"),
        Row(
          children: [
            const Text("Question: 1"),
            Text("Answer: ${healthModel?.question1}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 2"),
            Text(" || Answer: ${healthModel?.question2}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 3"),
            Text(" || Answer: ${healthModel?.question3}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 4"),
            Text(" || Answer: ${healthModel?.question4}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 5"),
            Text(" || Answer: ${healthModel?.question5}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 6"),
            Text(" || Answer: ${healthModel?.question6}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 7"),
            Text(" || Answer: ${healthModel?.question7}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 8"),
            Text(" || Answer: ${healthModel?.question8}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 9"),
            Text(" || Answer: ${healthModel?.question9}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 10"),
            Text(" || Answer: ${healthModel?.question10}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 11"),
            Text(" || Answer: ${healthModel?.question11}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 12"),
            Text(" || Answer: ${healthModel?.question12}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 13"),
            Text(" || Answer: ${healthModel?.question13}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 14"),
            Text(" || Answer: ${healthModel?.question14}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 15"),
            Text(" || Answer: ${healthModel?.question15}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 16"),
            Text(" || Answer: ${healthModel?.question16}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 17"),
            Text(" || Answer: ${healthModel?.question17}"),
          ],
        ),
        Row(
          children: [
            const Text("Question: 18"),
            Text(" || Answer: ${healthModel?.question18}"),
          ],
        ),
      ],
    );
  }
}

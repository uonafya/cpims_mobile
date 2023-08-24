import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:flutter/material.dart';

import '../../registry/organisation_units/widgets/steps_wrapper.dart';

class CparaHealthyWidget extends StatefulWidget {
  const CparaHealthyWidget({super.key});

  @override
  State<CparaHealthyWidget> createState() => _CparaHealthyWidgetState();
}

class Children {
  final String name;
  final UpdateRadioButton updateRadioButton;
  final RadioButtonOptions? groupValue;

  const Children(
      {required this.updateRadioButton,
      required this.groupValue,
      required this.name});
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

  // Children state
  final children = [
    Children(
        name: "FELIX OUMA",
        groupValue: RadioButtonOptions.no,
        updateRadioButton: (RadioButtonOptions? value) {}),
    Children(
        name: "EDWINE OUMA",
        groupValue: RadioButtonOptions.no,
        updateRadioButton: (RadioButtonOptions? value) {})
  ];

  // Update the state of the questions
  void updateQuestion(String question, RadioButtonOptions? value) {
    switch (question) {
      case "q1_1":
        setState(() {
          q1_1ChildrenHivTested = value;
        });
        break;
      case "q1_2":
        setState(() {
          q1_2childrenUnknownStatus = value;
        });
        break;
      case "q1_3":
        setState(() {
          q1_3InfantExposedHIV = value;
        });
        break;
      case "q1_4":
        setState(() {
          q1_4HivCaregiverUnknown = value;
        });
        break;
      case "q1_5":
        setState(() {
          q1_5CaregiverSceened = value;
        });
        break;
      case "q2_1":
        setState(() {
          q2_1SuppresedPast12 = value;
        });
        break;
      case "q2_2":
        setState(() {
          q2_2ChildrenRegularAttendTreatment = value;
        });
        break;
      case "q2_3":
        setState(() {
          q2_3ChildrenNotMissDose = value;
        });
        break;
      case "q2_4":
        setState(() {
          q2_4DocumentedChildrenSuppressed = value;
        });
        break;
      case "q2_5":
        setState(() {
          q2_5NoDocumentAttendTreatment = value;
        });
        break;
      case "q2_6":
        setState(() {
          q2_6AdolocentRegularMedicate = value;
        });
        break;
      case "q2_7":
        setState(() {
          q2_7HIVCaregiverSuppress = value;
        });
        break;
      case "q2_8":
        setState(() {
          q2_8NoDocumentCaregiverAppointment = value;
        });
        break;
      case "q2_9":
        setState(() {
          q2_9CaregiverRegularlyMedicate = value;
        });
        break;
      case "q4_1":
        setState(() {
          q4_1BelowAge5MUAC = value;
        });
        break;
      case "q4_2":
        setState(() {
          q4_2Below5BipedalEdema = value;
        });
        break;
      case "q4_3":
        setState(() {
          q4_3MalnourishedTreated = value;
        });
        break;
      case "q4_4":
        setState(() {
          q4_4Under2Immunized = value;
        });
        break;
      case "initial_3":
        setState(() {
          goal3InitialAnswer = value;
        });
        break;
      case "initial_4":
        setState(() {
          goal4Initial = value;
        });
        break;
      case "initial_2":
        setState(() {
          goal2InitialAnswer = value;
        });
        break;
      case "initial2_1":
        setState(() {
          suppresedPast12Initial = value;
        });
        break;
      case "initial2_4":
        setState(() {
          documentedChildrenSuppressedInitial = value;
        });
        break;
      case "initial2_7":
        setState(() {
          noDocumentCaregiverAppointmentInitial = value;
        });
        break;
      case "initial4_4":
        setState(() {
          childLessThan2Initial = value;
        });
        break;
      default:
        break;
    }
  }

  void noChangeToRadio(RadioButtonOptions? val) {}

  // A function that computes whether the final result of a section is yes or no given the values of the members
  RadioButtonOptions allShouldBeYes(List<RadioButtonOptions?> members) {
    // If all the values are yes return RadioButtonOptions.yes, if not return RadioButtonOptions.no
    if (members.isEmpty) {
      return RadioButtonOptions.no;
    } else if (members.any((element) => element != RadioButtonOptions.yes)) {
      return RadioButtonOptions.no;
    } else {
      return RadioButtonOptions.yes;
    }
  }

  // When you skip a section or goal the answers of the skipped questions should be set to NA
  void updateAnswersOnSkip(List<String> answersToChange) {
    for (var i in answersToChange) {
      updateQuestion(i, RadioButtonOptions.na);
    }
  }

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
          finalResult: allShouldBeYes([
            q1_1ChildrenHivTested,
            q1_2childrenUnknownStatus,
            q1_3InfantExposedHIV,
            q1_4HivCaregiverUnknown,
            q1_5CaregiverSceened
          ]), // final result is yes if the values of question 1 to 4 is yes
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
                  groupValue: q1_1ChildrenHivTested,
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
                  groupValue: q1_2childrenUnknownStatus,
                  question:
                      "1.2 For those with unknown HIV status, have they been screened for HIV risk and results showed test not required ?",
                  isNAAvailable: true,
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
                  groupValue: q1_3InfantExposedHIV,
                  question:
                      "1.3 If there is an infant Exposed to HIV (HEI), has the final HIV status been confirmed at 18 months or one week after cessation of breastfeeding, whichever comes later?",
                  isNAAvailable: true,
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
                  groupValue: q1_4HivCaregiverUnknown,
                  question:
                      "1.4 Is the HIV status of the caregiver known (positive, negative)?",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q1_4", val),
                ),
                QuestionBlock(
                  isTopDividerThere: false,
                  groupValue: q1_5CaregiverSceened,
                  isOptional: false,
                  question:
                      "1.5 For caregiver with unknown HIV status have they been screened for HIV risk and the results showing test not required?",
                  isNAAvailable: true,
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
          initalQuestionValue: goal2InitialAnswer,
          updateInitialQuestion: (RadioButtonOptions? val) {
            updateQuestion(
                "initial_2", val); // update the state of the question
            if (val == RadioButtonOptions.no) {
              updateAnswersOnSkip([
                "q2_1",
                "q2_2",
                "q2_3",
                "q2_4",
                "q2_5",
                "q2_6",
                "q2_7",
                "q2_8",
                "q2_9",
              ]); // update the other questions
            }
          },
          finalBlockQuestion: "Has the household achieved this benchmark?",
          showNAInFinalResult: false,
          finalResult: allShouldBeYes([
            q2_1SuppresedPast12,
            q2_2ChildrenRegularAttendTreatment,
            q2_3ChildrenNotMissDose,
            q2_4DocumentedChildrenSuppressed,
            q2_5NoDocumentAttendTreatment,
            q2_6AdolocentRegularMedicate,
            q2_7HIVCaregiverSuppress,
            q2_8NoDocumentCaregiverAppointment,
            q2_9CaregiverRegularlyMedicate
          ]), // The final value is yes if all the answers are yes for questions 2.1 to 2.9
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
              skipSection: goal2InitialAnswer ==
                  RadioButtonOptions
                      .no, // skip questions when the answer to is anyone HIV postivie no
              doesSectionDependOnInitialAnswer: true,
              initalQuestion:
                  "Is there a child 0 - 12 years who is HIV positive ?",
              initalQuestionValue: suppresedPast12Initial,
              updateInitialQuestion: (RadioButtonOptions? val) =>
                  updateQuestion("initial2_1", val),
              isNAInIntial: false,
              isTopDividerThere: false,
              title: "Children 0-12",
              questions: [
                QuestionBlock(
                  isTopDividerThere: false,
                  groupValue: q2_1SuppresedPast12,
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
                  groupValue: q2_2ChildrenRegularAttendTreatment,
                  question:
                      "2.2 For those with no documented viral load results; Have all the children living with HIV been attending their appointments regularly for the past 12 months (check CCC card to confirm adherence to treatment)",
                  isNAAvailable: true,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q2_2", val),
                ),
                QuestionBlock(
                  isTopDividerThere: false,
                  isOptional: false,
                  groupValue: q2_3ChildrenNotMissDose,
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
              skipSection: goal2InitialAnswer ==
                  RadioButtonOptions
                      .no, // skip questions when the answer to is anyone HIV postivie no
              doesSectionDependOnInitialAnswer: true,
              updateInitialQuestion: (RadioButtonOptions? value) =>
                  updateQuestion("initial2_4", value),
              isNAInIntial: false,
              initalQuestion:
                  "Is there an adolescents or a child above 12 years who is HIV positive ? ",
              initalQuestionValue: documentedChildrenSuppressedInitial,
              isTopDividerThere: false,
              title: "Adolescents and children above 12 years",
              questions: [
                QuestionBlock(
                  isTopDividerThere: false,
                  isOptional: false,
                  groupValue: q2_4DocumentedChildrenSuppressed,
                  question:
                      "2.4 Have all HIV positive children and adolescents (12years and above) on treatment with documented viral load results been suppressed in the past 12 months?",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q2_4", val),
                ),
                QuestionBlock(
                  isTopDividerThere: false,
                  isOptional: false,
                  groupValue: q2_5NoDocumentAttendTreatment,
                  question:
                      "2.5 For those with no documented viral load results; Have all the children and adolescents (12years and above) living with HIV been attending their appointments regularly for the past 12 months (check CCC card to confirm adherence to treatment)",
                  isNAAvailable: true,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q2_5", val),
                ),
                QuestionBlock(
                  isTopDividerThere: false,
                  isOptional: false,
                  groupValue: q2_6AdolocentRegularMedicate,
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
              skipSection: goal2InitialAnswer ==
                  RadioButtonOptions
                      .no, // skip questions when the answer to is anyone HIV postivie no
              doesSectionDependOnInitialAnswer: true,
              initalQuestion: "Is the caregiver HIV positive ? ",
              initalQuestionValue: noDocumentCaregiverAppointmentInitial,
              updateInitialQuestion: (RadioButtonOptions? value) =>
                  updateQuestion("initial2_7", value),
              isNAInIntial: false,
              isTopDividerThere: false,
              title: "Caregiver",
              questions: [
                QuestionBlock(
                  isTopDividerThere: false,
                  isOptional: false,
                  groupValue: q2_7HIVCaregiverSuppress,
                  question:
                      "2.7 Have all HIV positive caregivers on treatment with documented viral load results been suppressed in the past 12 months?",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q2_7", val),
                ),
                QuestionBlock(
                  isTopDividerThere: false,
                  groupValue: q2_8NoDocumentCaregiverAppointment,
                  isOptional: false,
                  question:
                      "2.8 For those with no documented viral load results; Have the caregiver living with HIV been attending their appointments regularly for the past 12 months (check CCC card to confirm adherence to treatment)",
                  isNAAvailable: true,
                  updateRadioButton: (RadioButtonOptions? val) =>
                      updateQuestion("q2_8", val),
                ),
                QuestionBlock(
                  isTopDividerThere: false,
                  groupValue: q2_9CaregiverRegularlyMedicate,
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
          initalQuestionValue: goal3InitialAnswer,
          updateInitialQuestion: (RadioButtonOptions? val) =>
              updateQuestion("initial_3", val),
          isNAInIntial: false,
          initalQuestion: "Does the household have adolescent girls and boys ?",
          finalBlockQuestion: "Has the household achieved this benchmarks?",
          showNAInFinalResult: false,
          finalResult: goal3Summary,
          updateFinalFormRadio: noChangeToRadio,
          sections: [],
          descriptionHeading: "Healthy: Goal 3: Reduce Risk of HIV Infection",
          descriptionText:
              "Benchmark3: All adolescents 10-17 years of age in the household have key knowledge about preventing HIV infection Adolescents aged 10-17 can describe at least two HIV infection risks in their local community, can provide at least one example of how they can protect themselves against HIV risk, and can correctly describe the location of at least one place where HIV prevention support is available.",
          descriptionSubText:
              "Note: For HHs with no adolescent girls and boys, skip questions below and select “N/A” for “Achievement of this benchmark.”",
          table: HealthTable(
            healthCards: [
              for (var i in children)
                HealthCard(
                  childName: i.name,
                  questions: [
                    QuestionBlock(
                      groupValue: i.groupValue,
                      isTopDividerThere: false,
                      isOptional: true,
                      question:
                          "3.1 Can you tell me two behaviors that increase risk of HIV infection?",
                      isNAAvailable: false,
                      updateRadioButton: i.updateRadioButton,
                    ),
                    QuestionBlock(
                      groupValue: i.groupValue,
                      isTopDividerThere: false,
                      isOptional: true,
                      question:
                          "3.2 Can you tell me two ways you can protect yourself/ others against HIV?",
                      isNAAvailable: false,
                      updateRadioButton: i.updateRadioButton,
                    ),
                    QuestionBlock(
                      groupValue: i.groupValue,
                      isTopDividerThere: false,
                      isOptional: true,
                      question:
                          "3.3 Can you name two places in the community where you can access HIV prevention services?",
                      isNAAvailable: false,
                      updateRadioButton: i.updateRadioButton,
                    ),
                  ],
                  isTopDividerThere: false,
                ),
            ],
          ),
        ),

        // Healthy Block 4
        HealthyGoalBlock(
          doesSectionDependOnInitialAnswer: true,
          initalQuestionValue: goal4Initial,
          updateInitialQuestion: (RadioButtonOptions? value) {
            updateQuestion("initial_4", value);

            if (value == RadioButtonOptions.no) {
              updateAnswersOnSkip(["q4_1", "q4_2", "q4_3", "q4_4"]);
            }
          },
          isNAInIntial: false,
          initalQuestion: "Is there child < 5 years in the household ?",
          finalBlockQuestion: "Has the household achieved this benchmarks?",
          showNAInFinalResult: true,
          finalResult: allShouldBeYes([
            q4_1BelowAge5MUAC,
            q4_2Below5BipedalEdema,
            q4_3MalnourishedTreated,
            q4_4Under2Immunized
          ]), // final answer should be yes if all questions from 4.1 to 4.4 are yes
          updateFinalFormRadio: noChangeToRadio,
          sections: [
            // Question 4.1 to 4.3
            QuestionsSection(
              doesSectionDependOnInitialAnswer: false,
              isTopDividerThere: false,
              skipSection: goal4Initial ==
                  RadioButtonOptions
                      .no, // skip the section when there are no children < 5 years
              title: "",
              questions: [
                QuestionBlock(
                  isTopDividerThere: false,
                  isOptional: false,
                  groupValue: q4_1BelowAge5MUAC,
                  question:
                      "4.1 Have all children below the age of five been assessed using MUAC and scored green?",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? value) =>
                      updateQuestion("q4_1", value),
                ),
                QuestionBlock(
                  isTopDividerThere: true,
                  groupValue: q4_2Below5BipedalEdema,
                  isOptional: false,
                  question:
                      "4.2 Have all the children below five years showed no signs of bipedal edema (e.g. Pressure applied on top of both feet for three seconds and did not leave a pit)?",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? value) =>
                      updateQuestion("q4_2", value),
                ),
                QuestionBlock(
                  isTopDividerThere: false,
                  groupValue: q4_3MalnourishedTreated,
                  warningText:
                      "NB: Score YES if none in the HH has ever been previously malnourished NB-Score YES if none in the HH has ever been previously malnourished *",
                  isOptional: false,
                  question:
                      "4.3 Have all the children previously identified as malnourished been treated and has a Z score of >-2? (Confirm with clinical as appropriate)",
                  isNAAvailable: true,
                  updateRadioButton: (RadioButtonOptions? value) =>
                      updateQuestion("q4_3", value),
                ),
              ],
            ),

            // Question 4.4
            QuestionsSection(
              skipSection: goal4Initial == RadioButtonOptions.no ||
                  childLessThan2Initial == RadioButtonOptions.no,
              skipSectionButShowInitial:
                  childLessThan2Initial == RadioButtonOptions.no,
              doesSectionDependOnInitialAnswer: true,
              updateInitialQuestion: (RadioButtonOptions? value) =>
                  updateQuestion("initial4_4", value),
              initalQuestion: "Is there child < 2 years in the household ? ",
              isNAInIntial: false,
              initalQuestionValue: childLessThan2Initial,
              isTopDividerThere: false,
              title: "",
              questions: [
                QuestionBlock(
                  isTopDividerThere: false,
                  isOptional: false,
                  groupValue: q4_4Under2Immunized,
                  question:
                      "4.4 If there is a child under 2 years in the household, Is the infant’s immunization on schedule? (Check mother baby booklet pages 33-35) ",
                  isNAAvailable: false,
                  updateRadioButton: (RadioButtonOptions? value) =>
                      updateQuestion("q4_4", value),
                ),
              ],
            ),
          ],
          descriptionHeading:
              "Healthy: Goal 4: Improve Development for Children <5 Years (Particularly HIV Exposed and Infected Infants/Young Children)",
          descriptionText:
              "Benchmark 4: No children < 5 years in the household are undernourished",
          descriptionSubText:
              "Note: If none of the children in the household is <5 years) select “N/A” and move to the stale domain",
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
    return Card(
        child: Column(
      children: [
        // Children Details Row
        HealthCardDetails(childName: childName),

        // Question
        for (var i in questions) i
      ],
    ));
  }
}

class HealthTable extends StatelessWidget {
  final List<HealthCard> healthCards;

  const HealthTable({required this.healthCards, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [for (var i in healthCards) i],
    );
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
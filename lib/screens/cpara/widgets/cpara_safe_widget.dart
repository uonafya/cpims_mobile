import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/screens/cpara/model/safe_model.dart';
import 'package:cpims_mobile/screens/cpara/provider/cpara_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_stable_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../registry/organisation_units/widgets/steps_wrapper.dart';

class CparaSafeWidget extends StatefulWidget {
  final bool isRejected;
  const CparaSafeWidget({
    required this.isRejected,
    super.key});

  @override
  State<CparaSafeWidget> createState() => _CparaSafeWidgetState();
}

class _CparaSafeWidgetState extends State<CparaSafeWidget> {
  // State of the questions
  RadioButtonOptions? childrenAdolecentCaregiver;
  RadioButtonOptions? experiencedViolence;
  RadioButtonOptions? childBelow12;
  RadioButtonOptions? adolescentsOlderThan12;
  RadioButtonOptions? exposedToViolence;

  // RadioButtonOptions? _no_siblings_over_10;
  RadioButtonOptions? referredForServices;
  RadioButtonOptions? tickYes;
  RadioButtonOptions? receivedServices;
  RadioButtonOptions? benchmark6;
  RadioButtonOptions? primaryCaregiver;
  RadioButtonOptions? caregiverLived12months;
  RadioButtonOptions? benchmark7;
  RadioButtonOptions? legalDocuments;
  RadioButtonOptions? benchmark8;

// List of children
  late List<SafeChild> children;

  // question 3 is for child
  RadioButtonOptions? question1Option,
      question2Option,
      question3Option,
      question4Option,
      question5Option,
      question6Option,
      question7Option,
      question8Option,
      overallQuestion1Option,
      overallQuestion2Option;

  List<RadioButtonOptions?> childrenQuestionsOptions = [];

  // Update the state of the questions
  void updateQuestion(String question, RadioButtonOptions? value) {
    switch (question) {
      case "_children_adolecent_caregiver":
        setState(() {
          childrenAdolecentCaregiver = value;
          if (value == RadioButtonOptions.no) {
            // Set values of radio buttons for questions 6.1 and 6.5 to yes
            experiencedViolence = RadioButtonOptions.yes;
            childBelow12 = RadioButtonOptions.yes;
            adolescentsOlderThan12 = RadioButtonOptions.yes;
            exposedToViolence = RadioButtonOptions.yes;
            // _no_siblings_over_10 = RadioButtonOptions.yes;
            referredForServices = RadioButtonOptions.yes;
            receivedServices = RadioButtonOptions.yes;

            // Set all children to yes
            var newChildren = children.map((e) {
              e.question1 =
                  convertingRadioButtonOptionsToString(RadioButtonOptions.yes);
              return e;
            }).toList();

            setState(() {
              children = newChildren;
            });

            // Save state of overall question 1
          }
          if (value == RadioButtonOptions.yes) {
            // Set values of radio buttons for questions 6.1 and 6.5 to null
            experiencedViolence = null;
            childBelow12 = null;
            adolescentsOlderThan12 = null;
            exposedToViolence = null;
            // _no_siblings_over_10 = null;
            referredForServices = null;
            receivedServices = null;

            // Set all children to null
            var newChildren = children.map((e) {
              e.question1 = null;
              return e;
            }).toList();

            setState(() {
              children = newChildren;
            });
          }
        });
        break;
      case "_experienced_violence":
        setState(() {
          experiencedViolence = value;
        });
        break;
      case "_child_below_12":
        setState(() {
          childBelow12 = value;
        });
        break;
      case "_adolescents_older_than_12":
        setState(() {
          adolescentsOlderThan12 = value;

          if (value == RadioButtonOptions.no) {
            // Set values of radio buttons for questions 6.3 and 6.5 to yes
            exposedToViolence = RadioButtonOptions.yes;
            // _no_siblings_over_10 = RadioButtonOptions.yes;
          }
          if (value == RadioButtonOptions.yes) {
            // Set values of radio buttons for questions 6.3 and 6.5 to null
            exposedToViolence = null;
            // _no_siblings_over_10 = null;
          }
        });
        break;
      case "_exposed_to_violence":
        setState(() {
          exposedToViolence = value;
        });
        break;
      // case "_no_siblings_over_10":
      //   setState(() {
      //     _no_siblings_over_10 = value;
      //   });
      //   break;
      case "_referred_for_services":
        setState(() {
          referredForServices = value;
        });
        break;
      case "_received_services":
        setState(() {
          receivedServices = value;
        });
        break;
      case "_benchmark_6":
        setState(() {
          benchmark6 = value;
        });
        break;
      case "_primary_caregiver":
        setState(() {
          primaryCaregiver = value;
        });
        break;
      case "_caregiver_lived_12_months":
        setState(() {
          caregiverLived12months = value;
        });
        break;
      case "_benchmark_7":
        setState(() {
          benchmark7 = value;
        });
        break;
      case "_legal_documents":
        setState(() {
          legalDocuments = value;
        });
        break;
      case "_benchmark_8":
        setState(() {
          benchmark8 = value;
        });
        break;
      default:
        break;
    }
  }

  void noChangeToRadio(RadioButtonOptions? val) {}

  int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    final age = now.year -
        birthDate.year -
        (now.month > birthDate.month ||
                (now.month == birthDate.month && now.day >= birthDate.day)
            ? 0
            : 1);
    return age;
  }

  @override
  void initState() {
    children = [];
    SafeModel safeModel =
        context.read<CparaProvider>().safeModel ?? SafeModel();
    List<CaseLoadModel> models = context.read<CparaProvider>().children;
    question1Option = safeModel.question1 == null
        ? question1Option
        : convertingStringToRadioButtonOptions(safeModel.question1!);
    experiencedViolence = question1Option;
    question2Option = safeModel.question2 == null
        ? question2Option
        : convertingStringToRadioButtonOptions(safeModel.question2!);
    childBelow12 = question2Option;
    // question3Option = safeModel.question3 == null
    //     ? question3Option
    //     : convertingStringToRadioButtonOptions(safeModel.question3!);
    // _exposed_to_violence = question3Option;

    question4Option = safeModel.question3 == null
        ? question4Option
        : convertingStringToRadioButtonOptions(safeModel.question3!);
    referredForServices = question4Option;
    question5Option = safeModel.question4 == null
        ? question5Option
        : convertingStringToRadioButtonOptions(safeModel.question4!);
    receivedServices = question5Option;

    question6Option = safeModel.question5 == null
        ? question6Option
        : convertingStringToRadioButtonOptions(safeModel.question5!);
    primaryCaregiver = question6Option;

    question7Option = safeModel.question6 == null
        ? question7Option
        : convertingStringToRadioButtonOptions(safeModel.question6!);
    caregiverLived12months = question7Option;

    question8Option = safeModel.question7 == null
        ? question8Option
        : convertingStringToRadioButtonOptions(safeModel.question7!);
    legalDocuments = question8Option;

    // Overall questions
    overallQuestion1Option = safeModel.overallQuestion1 == null
        ? overallQuestion1Option
        : convertingStringToRadioButtonOptions(safeModel.overallQuestion1!);
    childrenAdolecentCaregiver = overallQuestion1Option;

    overallQuestion2Option = safeModel.overallQuestion2 == null
        ? overallQuestion2Option
        : convertingStringToRadioButtonOptions(safeModel.overallQuestion2!);
    adolescentsOlderThan12 = overallQuestion2Option;

    // Initialize children--------------------------
    // children = safeModel.childrenQuestions ??
    //     [
    //      SafeChild(id: "45", question1: "question1"),
    //       SafeChild(id: "76", question1: "question1")
    //     ];
    int calculateAge(DateTime birthDate) {
      final now = DateTime.now();
      final age = now.year -
          birthDate.year -
          (now.month > birthDate.month ||
                  (now.month == birthDate.month && now.day >= birthDate.day)
              ? 0
              : 1);
      return age;
    }

    if (widget.isRejected == true) {
      for (SafeChild child in safeModel.childrenQuestions ?? []) {
        children.add(child);
      }
    } else {
      for (CaseLoadModel model in models) {
        final DateTime? birthDate = DateTime.tryParse(model.dateOfBirth ?? "");
        if (birthDate != null) {
          final age = calculateAge(birthDate);
          if (age > 11) {
            // Only add children with age less than 12
            children.add(
              SafeChild(
                ovcId: model.cpimsId ?? "",
                question1: "",
                name: "${model.ovcFirstName} ${model.ovcSurname}",
              ),
            );
          }
        }
      }
    }
    // children = safeModel.childrenQuestions ??
    //     [
    //       // SafeChild(id: "45", question1: "question1"),
    //       // SafeChild(id: "76", question1: "question1")
    //     ];

    if (safeModel.childrenQuestions != null &&
        safeModel.childrenQuestions!.isNotEmpty) {
      for (var i = 0; i < (safeModel.childrenQuestions?.length ?? 0); i++) {
        childrenQuestionsOptions.add(safeModel.childrenQuestions![i] == null
            ? null
            : convertingStringToRadioButtonOptions(
                safeModel.childrenQuestions![i].question1!));
      }
    } else {
      childrenQuestionsOptions = [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StepsWrapper(
      title: 'Safe',
      children: [
/////////////////////////////////////////////
// Safe Goal 6
        const SafeGoalWidget(
            title:
                "Safe: Goal 6: Reduce Risk of Physical, Emotional and Psychological Injury Due to Exposure to Violence",
            subTitle:
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
            option: childrenAdolecentCaregiver,
            cardQuestion:
                "Are there children, adolescents, and caregivers in the household who have experienced violence (including physical violence, emotional violence, sexual violence, gender-based violence, and neglect) in the last six months ?",
            selectedOption: (value) {
              debugPrint("Overall Question 1 Safe, value is $value");
              overallQuestion1Option = value;
              SafeModel safeModel =
                  context.read<CparaProvider>().safeModel ?? SafeModel();
              String selectedOption =
                  convertingRadioButtonOptionsToString(value);

              var updatedSafeModel =
                  safeModel.copyWith(overallQuestion1: selectedOption);

              // Update the state of the question
              updateQuestion("_children_adolecent_caregiver", value);
              if (value == RadioButtonOptions.no) {
                debugPrint("Safe Branch 1 entered");
                adolescentsOlderThan12 = RadioButtonOptions.no;
                exposedToViolence = RadioButtonOptions.yes;

                // Set 6.4 and 6.5 to yes
                // context.read<CparaProvider>().updateSafeModel(
                //     safeModel.copyWith(question3: selectedOption));
                // context.read<CparaProvider>().updateSafeModel(
                //     safeModel.copyWith(question4: selectedOption));
                updatedSafeModel = updatedSafeModel.copyWith(
                    question3: convertingRadioButtonOptionsToString(
                        RadioButtonOptions.yes));
                updatedSafeModel = updatedSafeModel.copyWith(
                    question4: convertingRadioButtonOptionsToString(
                        RadioButtonOptions.yes));
                debugPrint("Updating Old Safe Model with $updatedSafeModel");
                context.read<CparaProvider>().updateSafeModel(updatedSafeModel);
              } else if (value == RadioButtonOptions.yes) {
                // Set 6.4 and 6.5 to null
                // context
                //     .read<CparaProvider>()
                //     .updateSafeModel(safeModel.copyWith(question3: null));
                // context
                //     .read<CparaProvider>()
                //     .updateSafeModel(safeModel.copyWith(question4: null));
                debugPrint("Safe Branch 2 entered");
                updatedSafeModel = updatedSafeModel.copyWith(question3: "");
                updatedSafeModel = updatedSafeModel.copyWith(question4: "");
                debugPrint("Updating Old Safe Model with $updatedSafeModel");
                context.read<CparaProvider>().updateSafeModel(updatedSafeModel);
              }
            }),

// Question 6.1

        if (childrenAdolecentCaregiver == RadioButtonOptions.no)
          const SkipQuestion()
        else
          OtherQuestions(
            groupValue: experiencedViolence,
            otherQuestion:
                "6.1 Have you experienced violence, abuse (sexual, physical, or emotional) in the last six months?*",
            selectedOption: (value) {
              question1Option = value;
              SafeModel safeModel =
                  context.read<CparaProvider>().safeModel ?? SafeModel();
              String selectedOption =
                  convertingRadioButtonOptionsToString(value);
              context.read<CparaProvider>().updateSafeModel(
                  safeModel.copyWith(question1: selectedOption));
              // Update the state of the question
              updateQuestion("_experienced_violence", value);
            },
          ),

        // Question 6.2
        if (childrenAdolecentCaregiver == RadioButtonOptions.no)
          const SkipQuestion()
        else
          OtherQuestions(
            groupValue: childBelow12,
            otherQuestion:
                "6.2 Is there a child below 12 years who has been exposed to violence or abuse (sexual, physical or emotional), neglect, or exploitation in the last six months?*",
            selectedOption: (value) {
              question2Option = value;
              SafeModel safeModel =
                  context.read<CparaProvider>().safeModel ?? SafeModel();
              String selectedOption =
                  convertingRadioButtonOptionsToString(value);
              context.read<CparaProvider>().updateSafeModel(
                  safeModel.copyWith(question2: selectedOption));
              // Update the state of the question
              updateQuestion("_child_below_12", value);
            },
          ),

// Question 6.3 to 6.2
// Question Main Card
        if (childrenAdolecentCaregiver == RadioButtonOptions.no)
          const SkipQuestion()
        else
          MainCardQuestion(
              cardQuestion: " Is there adolescents 12 years and above ? ",
              option: adolescentsOlderThan12,
              selectedOption: (value) {
                overallQuestion2Option = value;
                SafeModel safeModel =
                    context.read<CparaProvider>().safeModel ?? SafeModel();
                String selectedOption =
                    convertingRadioButtonOptionsToString(value);
                context.read<CparaProvider>().updateSafeModel(
                    safeModel.copyWith(overallQuestion2: selectedOption));
                // Update the state of the question
                updateQuestion("_adolescents_older_than_12", value);
                if (value == RadioButtonOptions.no) {
                  tickYes = RadioButtonOptions.yes;
                }
              }),

        const SizedBox(
          height: largeHeight,
        ),

// Load Children - For the specific household
        for (int i = 0; i < children.length; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Child Name',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 12.0),
                        ),
                        Text(
                          children[i].name,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'OVC CPIMS ID',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 12.0),
                        ),
                        Text(
                          children[i].ovcId,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (childrenAdolecentCaregiver == RadioButtonOptions.no ||
                  adolescentsOlderThan12 == RadioButtonOptions.no)
                const SkipQuestion()
              else
                OtherQuestions(
                  groupValue: childrenQuestionsOptions[i],
                  otherQuestion:
                      "6.3 Have you been exposed to violence, abuse (sexual, physical or emotional), neglect, or exploitation in the last six months?",
                  selectedOption: (value) {
                    question3Option = value;
                    childrenQuestionsOptions[i] = value;
                    SafeModel safeModel =
                        context.read<CparaProvider>().safeModel ?? SafeModel();
                    String selectedOption =
                        convertingRadioButtonOptionsToString(value);
                    //todo: update the children questions
                    List<SafeChild> childrenQuestions = children;
                    // safeModel.childrenQuestions ??
                    //     [SafeChild(question1: "")];

                    try {
                      childrenQuestions[i] = SafeChild(
                          question1: selectedOption,
                          ovcId: children[i].ovcId,
                          name: children[i].name);
                    } catch (e) {
                      if (e is RangeError) {
                        childrenQuestions.add(SafeChild(
                            question1: "",
                            ovcId: children[i].ovcId,
                            name: children[i].name));
                        childrenQuestions[i] = SafeChild(
                            question1: selectedOption,
                            ovcId: children[i].ovcId,
                            name: children[i].name);
                      }
                    }

// todo: update the children questions
                    context.read<CparaProvider>().updateSafeModel(safeModel
                        .copyWith(childrenQuestions: childrenQuestions));
//                     context.read<CparaProvider>().updateSafeModel(safeModel
//                         .copyWith(childrenQuestions: [SafeChild(question1: selectedOption, ovcId: "35273283", name: "Okello Enos"),
//                       SafeChild(question1: "No", ovcId: "0716229563", name: "Nakato Sarah"),
//                       ...childrenQuestions]));

                    // // Update the state of the question
                    updateQuestion("_exposed_to_violence", value);
                    if (value == RadioButtonOptions.yes) {
                      tickYes = RadioButtonOptions.yes;
                    }
                  },
                )
            ],
          ),

        const SizedBox(
          height: largeHeight,
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
          otherQuestion: "Tick Yes if YES for all children",
          selectedOption: (value) {},
          groupValue: allShouldBeOnlyYes(
              children.map((e) {
                return convertingStringToRadioButtonOptions(e.question1 ?? "");
              }).toList(),
              "All Safe Children Are Yes"), // should be yes if all children are yes
        ),

// Label for question 6.4 to 6.5
        const Text(
          "If yes to any of the three questions above, answer the questions below",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),

// Question 6.4
        if (childrenAdolecentCaregiver == RadioButtonOptions.no)
          const SkipQuestion()
        else
          OtherQuestions(
              groupValue: referredForServices,
              otherQuestion:
                  "6.4 Is there any evidence that the case has referred for services such as child protection?* ",
              selectedOption: (value) {
                question4Option = value;
                SafeModel safeModel =
                    context.read<CparaProvider>().safeModel ?? SafeModel();
                String selectedOption =
                    convertingRadioButtonOptionsToString(value);
                context.read<CparaProvider>().updateSafeModel(
                    safeModel.copyWith(question3: selectedOption));
                // Update the state of the question
                updateQuestion("_referred_for_services", value);
              }),

// Question 6.5
        if (childrenAdolecentCaregiver == RadioButtonOptions.no)
          const SkipQuestion()
        else
          OtherQuestions(
              groupValue: receivedServices,
              otherQuestion:
                  "6.5 Is there documentation that they received services (e,g counseling, psycho-social, legal or health services)?* ",
              selectedOption: (value) {
                question5Option = value;
                SafeModel safeModel =
                    context.read<CparaProvider>().safeModel ?? SafeModel();
                String selectedOption =
                    convertingRadioButtonOptionsToString(value);
                context.read<CparaProvider>().updateSafeModel(
                    safeModel.copyWith(question4: selectedOption));
                // Update the state of the question
                updateQuestion("_received_services", value);
              }),

// Benchmak 6 results
        BenchMarkQuestion(
            groupValue: allShouldBeOnlyYes([
              convertingStringToRadioButtonOptions(
                  context.read<CparaProvider>().safeModel?.question3 ?? ""),
              convertingStringToRadioButtonOptions(
                  context.read<CparaProvider>().safeModel?.question4 ?? ""),
            ], "message"),
            benchmarkQuestion: "Has the household achieved this benchmarks?",
            selectedOption: (value) {}),
        const SizedBox(
          height: largeHeight,
        ),

// Safe Goal 6 end

////////////////////////////////// todo: proceed from
// Safe Goal 7 questions 7.1 to 7.2
        const SafeGoalWidget(
            title:
                "Safe: Goal 7: All children and adolescents in the household are under the care of a stable adult caregiver"),

// Question 7.1
        OtherQuestions(
            groupValue: primaryCaregiver,
            otherQuestion: "7.1 Is the primary caregiver 18yrs and above?* ",
            selectedOption: (value) {
              question6Option = value;
              SafeModel safeModel =
                  context.read<CparaProvider>().safeModel ?? SafeModel();
              String selectedOption =
                  convertingRadioButtonOptionsToString(value);
              context.read<CparaProvider>().updateSafeModel(
                  safeModel.copyWith(question5: selectedOption));
              // Update the state of the question
              updateQuestion("_primary_caregiver", value);
            }),

// Question 7.2
        OtherQuestions(
            groupValue: caregiverLived12months,
            otherQuestion:
                "7.2 Has the caregiver cared for and lived in the same home as the child/adolescents for at least the last 12 months?*  ",
            selectedOption: (value) {
              question7Option = value;
              SafeModel safeModel =
                  context.read<CparaProvider>().safeModel ?? SafeModel();
              String selectedOption =
                  convertingRadioButtonOptionsToString(value);
              context.read<CparaProvider>().updateSafeModel(
                  safeModel.copyWith(question6: selectedOption));
              // Update the state of the question
              updateQuestion("_caregiver_lived_12_months", value);
            }),

// Benchmak 7 results
        BenchMarkQuestion(
            groupValue: allShouldBeOnlyYes(
                [caregiverLived12months, primaryCaregiver], "Benchmark 7"),
            benchmarkQuestion: "Has the household achieved this benchmarks?",
            selectedOption: (value) {}),

        const SizedBox(
          height: largeHeight,
        ),

///////////////////////////////////////////

// Safe Goal 7 questions 8.1 to 8.2

        const SafeGoalWidget(
            title:
                "Safe: Goal 7: All children < 18 years have legal proof of identity"),

// Question 8.1
        OtherQuestions(
            groupValue: legalDocuments,
            otherQuestion:
                "8.1 Do all children under the age of 18 have legal documents (birth certificate)?* ",
            selectedOption: (value) {
              question8Option = value;
              SafeModel safeModel =
                  context.read<CparaProvider>().safeModel ?? SafeModel();
              String selectedOption =
                  convertingRadioButtonOptionsToString(value);
              context.read<CparaProvider>().updateSafeModel(
                  safeModel.copyWith(question7: selectedOption));
              // Update the state of the question
              updateQuestion("_legal_documents", value);
            }),

// Benchmak 7 results
        BenchMarkQuestion(
          groupValue: allShouldBeOnlyYes([legalDocuments], "Benchmark mark 8"),
          benchmarkQuestion: "Has the household achieved this benchmarks?",
          selectedOption: (value) {},
        ),

/////////////////////////////////////////

        const SizedBox(
          height: largeHeight,
        ),
        // CustomButton(
        //     text: "Cancel", onTap: () {}, color: Colors.black.withOpacity(0.4)),
        // const SizedBox(height: 20),
        // CustomButton(text: "Submit", onTap: () {}, color: green),
      ],
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
  final String subTitle;

  const SafeGoalWidget({
    super.key,
    required this.title,
    this.subTitle = "",
  });

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
              fontSize: goalFont,
              fontWeight: goalWeight,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subTitle,
            style: const TextStyle(
              fontSize: goaldescFont,
              fontWeight: goaldescWeight,
            ),
          ),
        ],
      ),
    );
  }
}

class MainCardQuestion extends StatelessWidget {
  final String cardQuestion;
  final RadioButtonOptions? option;
  final Function(RadioButtonOptions?) selectedOption;

  const MainCardQuestion(
      {super.key,
      required this.cardQuestion,
      required this.selectedOption,
      required this.option});

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
                cardQuestion,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomRadioButton(
                option: option,
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

const goalFont = 20.0;
const goalWeight = FontWeight.w700;
const goaldescFont = 14.0;
const goaldescWeight = FontWeight.w300;
const questionFontSize = 18.0;
const questionFontWeight = FontWeight.w500;
const smallHeight = 10.0;
const largeHeight = 25.0;

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
  final bool naAvailable;
  final String otherQuestion;
  final bool divider;
  final Function(RadioButtonOptions?) selectedOption;
  final RadioButtonOptions? groupValue;

  const OtherQuestions({
    super.key,
    required this.otherQuestion,
    required this.selectedOption,
    this.divider = false,
    this.naAvailable = false,
    required this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    final parts = otherQuestion.split('*'); // Split text by "*"
    final List<InlineSpan> spans = [];

    for (int i = 0; i < parts.length; i++) {
      spans.add(
        TextSpan(
          text: parts[i],
          style: const TextStyle(
            fontSize: questionFontSize,
            fontWeight: questionFontWeight,
            color: Colors.black, // Default text color
          ),
        ),
      );

      if (i < parts.length - 1) {
        spans.add(
          const TextSpan(
            text: '*', // Add back the "*" character
            style: TextStyle(
              fontSize: questionFontSize,
              fontWeight: questionFontWeight,
              color: Colors.red, // Change color to red
            ),
          ),
        );
      }
    }

    return Column(
      children: [
        if (divider) const Divider(),
        const SizedBox(
          height: largeHeight,
        ),
        RichText(
          text: TextSpan(
            children: spans,
          ),
        ),
        const SizedBox(
          height: smallHeight,
        ),
        MyCustomRadioListTileColumn(
          isNaAvailable: naAvailable,
          updateRadioButton: (value) => selectedOption(value),
          groupValue: groupValue,
        ),
        const SizedBox(
          height: largeHeight,
        ),
      ],
    );
  }
}

class BenchMarkQuestion extends StatelessWidget {
  final String benchmarkQuestion;
  final RadioButtonOptions? groupValue;
  final Function(RadioButtonOptions?) selectedOption;

  const BenchMarkQuestion(
      {super.key,
      required this.groupValue,
      required this.benchmarkQuestion,
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
                benchmarkQuestion,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyCustomRadioListTileColumn(
                groupValue: groupValue,
                isNaAvailable: false,
                updateRadioButton: (value) => selectedOption(value),
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

typedef UpdateRadioButton = void Function(RadioButtonOptions? value);

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

// Function returns yes if all the members are just yes
RadioButtonOptions allShouldBeOnlyYes(
    List<RadioButtonOptions?> members, String message) {
  debugPrint(members.toString() + message);
  // If all the values are yes return RadioButtonOptions.yes, if not return RadioButtonOptions.no
  if (members == null) {
    return RadioButtonOptions.no;
  }
  else if (members == []) {
    return RadioButtonOptions.yes;
  }
  else if (members.any((element) => element != RadioButtonOptions.yes)) {
    return RadioButtonOptions.no;
  } else {
    return RadioButtonOptions.yes;
  }
}

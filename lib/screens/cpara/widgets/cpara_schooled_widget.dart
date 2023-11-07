import 'package:cpims_mobile/screens/cpara/model/schooled_model.dart';
import 'package:cpims_mobile/screens/cpara/provider/cpara_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_safe_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CparaSchooledWidget extends StatefulWidget {
  const CparaSchooledWidget({super.key});

  @override
  State<CparaSchooledWidget> createState() => _CparaSchooledWidgetState();
}

class _CparaSchooledWidgetState extends State<CparaSchooledWidget> {
  // State of the questions
  RadioButtonOptions? schoolGoingChildren;
  RadioButtonOptions? q91ChildrenEnrolledInSchool;
  RadioButtonOptions? q92ChildrenAttendingSchoolRegularly;
  RadioButtonOptions? ecde45Children;
  RadioButtonOptions? q93ChildrenAttendingEcde;
  RadioButtonOptions? q94ChildrenProgressedFromOneLevelToAnother;
  RadioButtonOptions? benchmarkScore;

  // Update the state of the questions
  void updateQuestion(String question, RadioButtonOptions? value) {
    switch (question) {
      case "school_going_children":
        setState(() {
          schoolGoingChildren = value;

          if (value == RadioButtonOptions.no) {
            q91ChildrenEnrolledInSchool = RadioButtonOptions.yes;

            SchooledModel schooledModel =
                context.read<CparaProvider>().schooledModel ?? SchooledModel();

            String selectedOption = convertingRadioButtonOptionsToString(
                q91ChildrenEnrolledInSchool);
            context.read<CparaProvider>().updateSchooledModel(
                schooledModel.copyWith(question1: selectedOption));
          }

          if (value == RadioButtonOptions.no) {
            q92ChildrenAttendingSchoolRegularly = RadioButtonOptions.yes;

            SchooledModel schooledModel =
                context.read<CparaProvider>().schooledModel ?? SchooledModel();

            String selectedOption = convertingRadioButtonOptionsToString(
                q92ChildrenAttendingSchoolRegularly);
            context.read<CparaProvider>().updateSchooledModel(
                schooledModel.copyWith(question2: selectedOption));
          }
          if (value == RadioButtonOptions.yes) {
            q91ChildrenEnrolledInSchool = null;
            q92ChildrenAttendingSchoolRegularly = null;

            SchooledModel schooledModel =
                context.read<CparaProvider>().schooledModel ?? SchooledModel();

            String selectedOption = convertingRadioButtonOptionsToString(
                q92ChildrenAttendingSchoolRegularly);
            context.read<CparaProvider>().updateSchooledModel(
                schooledModel.copyWith(question2: selectedOption));

            selectedOption = convertingRadioButtonOptionsToString(
                q91ChildrenEnrolledInSchool);
            context.read<CparaProvider>().updateSchooledModel(
                schooledModel.copyWith(question1: selectedOption));
          }

          SchooledModel schooledModel =
              context.read<CparaProvider>().schooledModel ?? SchooledModel();
          String selectedOption = convertingRadioButtonOptionsToString(value);
          context.read<CparaProvider>().updateSchooledModel(
              schooledModel.copyWith(mainquestion1: selectedOption));
        });
        break;
      case "q9_1_Children_enrooled_in_school":
        setState(() {
          q91ChildrenEnrolledInSchool = value;
          SchooledModel schooledModel =
              context.read<CparaProvider>().schooledModel ?? SchooledModel();
          String selectedOption = convertingRadioButtonOptionsToString(value);
          context.read<CparaProvider>().updateSchooledModel(
              schooledModel.copyWith(question1: selectedOption));
        });
        break;
      case "q9_2_Children_attending_school_regularly":
        setState(() {
          q92ChildrenAttendingSchoolRegularly = value;
          SchooledModel schooledModel =
              context.read<CparaProvider>().schooledModel ?? SchooledModel();
          String selectedOption = convertingRadioButtonOptionsToString(value);
          context.read<CparaProvider>().updateSchooledModel(
              schooledModel.copyWith(question2: selectedOption));
        });
        break;
      case "ecde_4_5_children":
        setState(() {
          ecde45Children = value;

          if (value == RadioButtonOptions.no) {
            q93ChildrenAttendingEcde = RadioButtonOptions.yes;
            SchooledModel schooledModel =
                context.read<CparaProvider>().schooledModel ?? SchooledModel();
            String selectedOption = convertingRadioButtonOptionsToString(
                q93ChildrenAttendingEcde);
            context.read<CparaProvider>().updateSchooledModel(
                schooledModel.copyWith(question3: selectedOption));
          }

          if (value == RadioButtonOptions.yes) {
            q93ChildrenAttendingEcde = null;
          }
          SchooledModel schooledModel =
              context.read<CparaProvider>().schooledModel ?? SchooledModel();
          String selectedOption = convertingRadioButtonOptionsToString(value);
          context.read<CparaProvider>().updateSchooledModel(
              schooledModel.copyWith(mainquestion2: selectedOption));
        });
        break;
      case "q9_3_Children_attending_ecde":
        setState(() {
          q93ChildrenAttendingEcde = value;
          SchooledModel schooledModel =
              context.read<CparaProvider>().schooledModel ?? SchooledModel();
          String selectedOption = convertingRadioButtonOptionsToString(value);
          context.read<CparaProvider>().updateSchooledModel(
              schooledModel.copyWith(question3: selectedOption));
        });
        break;
      case "q9_4_Children_progressed_from_one_level_to_another":
        setState(() {
          q94ChildrenProgressedFromOneLevelToAnother = value;
          SchooledModel schooledModel =
              context.read<CparaProvider>().schooledModel ?? SchooledModel();
          String selectedOption = convertingRadioButtonOptionsToString(value);
          context.read<CparaProvider>().updateSchooledModel(
              schooledModel.copyWith(question4: selectedOption));
        });
        break;
      case "benchmark_score":
        setState(() {
          benchmarkScore = value;
        });
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    SchooledModel schooledModel =
        context.read<CparaProvider>().schooledModel ?? SchooledModel();

    schoolGoingChildren = schooledModel.mainquestion1 == null
        ? schoolGoingChildren
        : convertingStringToRadioButtonOptions(schooledModel.mainquestion1!);

    q91ChildrenEnrolledInSchool = schooledModel.question1 == null
        ? q91ChildrenEnrolledInSchool
        : convertingStringToRadioButtonOptions(schooledModel.question1!);

    q92ChildrenAttendingSchoolRegularly = schooledModel.question2 == null
        ? q92ChildrenAttendingSchoolRegularly
        : convertingStringToRadioButtonOptions(schooledModel.question2!);

    ecde45Children = schooledModel.mainquestion2 == null
        ? ecde45Children
        : convertingStringToRadioButtonOptions(schooledModel.mainquestion2!);

    q93ChildrenAttendingEcde = schooledModel.question3 == null
        ? q93ChildrenAttendingEcde
        : convertingStringToRadioButtonOptions(schooledModel.question3!);

    q94ChildrenProgressedFromOneLevelToAnother =
        schooledModel.question4 == null
            ? q94ChildrenProgressedFromOneLevelToAnother
            : convertingStringToRadioButtonOptions(schooledModel.question4!);

    super.initState();
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
          const SizedBox(height: smallHeight),

///////////////////////////////////////////
// First Main Question
          MainCardQuestion(
              option: schoolGoingChildren,
              cardQuestion:
                  "Are there school going children in this Household ?",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("school_going_children", value);
              }),

// Question 9.1 - 9.2
// Question 9.1
          if (schoolGoingChildren == RadioButtonOptions.no)
            const SkipQuestion()
          else
            OtherQuestions(
              otherQuestion:
                  "9.1 Are all school aged children (6-17) enrolled in school? (And out of school OVC aged 15-20 years engaged in approved economic intervention?*",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("q9_1_Children_enrooled_in_school", value);
              },
              naAvailable: false,
              groupValue: q91ChildrenEnrolledInSchool,
            ),

// Question 9.2
          if (schoolGoingChildren == RadioButtonOptions.no)
            const SkipQuestion()
          else
            OtherQuestions(
              otherQuestion:
                  "9.2 Are the enrolled children attending school regularly? (i.e. have not missed school for more than five school days in a month). Probe the trend of absence). Verify with the school attendance tracking tool where applicable)*",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion(
                    "q9_2_Children_attending_school_regularly", value);
              },
              naAvailable: false,
              groupValue: q92ChildrenAttendingSchoolRegularly,
            ),

// General Statement
          const Text(
            "If there is a child between 4-5 years in the household and there is an ECDE center in the area, please ask the caregiver, otherwise skip and score the benchmark appropriately:",
            style: TextStyle(
              fontSize: questionFontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 25,
          ),

// Main Card Question
          MainCardQuestion(
              option: ecde45Children,
              cardQuestion:
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
          if (ecde45Children == RadioButtonOptions.no)
            const SkipQuestion()
          else
            OtherQuestions(
              otherQuestion:
                  "9.3 Is your child (4–5-year-old) attending ECDE?* ",
              selectedOption: (value) {
                // Update the state of the question
                updateQuestion("q9_3_Children_attending_ecde", value);
              },
              naAvailable: false,
              groupValue: q93ChildrenAttendingEcde,
            ),

// Question 9.4
          OtherQuestions(
            otherQuestion:
                "9.4 Have all the enrolled children progressed/graduated from one level to the other in the last school calendar year? Note: if possible, please ask to see report card.*  ",
            selectedOption: (value) {
              // Update the state of the question
              updateQuestion(
                  "q9_4_Children_progressed_from_one_level_to_another", value);
            },
            naAvailable: true,
            divider: true,
            groupValue: q94ChildrenProgressedFromOneLevelToAnother,
          ),

// Benchmark score
          BenchMarkQuestion(
            groupValue: allShouldBeYes(
              [
                q91ChildrenEnrolledInSchool,
                q92ChildrenAttendingSchoolRegularly,
                q93ChildrenAttendingEcde,
                q94ChildrenProgressedFromOneLevelToAnother
              ],
              "Last Benchmark school",
            ),
            benchmarkQuestion: "Has the household achieved this benchmarks?",
            selectedOption: (value) {},
          ),

////////////////////////////////////

          const SizedBox(
            height: 50,
          ),

          // CparaResultBenchmarks(),
          const FinalBenchMark(),
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

const goalFont = 20.0;
const goalWeight = FontWeight.w700;
const goaldescFont = 14.0;
const goaldescWeight = FontWeight.w300;

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
                const TextStyle(fontWeight: goalWeight, fontSize: goalFont),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: const TextStyle(
                fontWeight: goaldescWeight,
                color: Colors.black54,
                fontSize: goaldescFont,
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
  final String cardQuestion;
  final Function(RadioButtonOptions?) selectedOption;
  final RadioButtonOptions? option;

  const MainCardQuestion({
    super.key,
    required this.cardQuestion,
    required this.selectedOption,
    this.option,
  });

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
                isNaAvailable: false,
                optionSelected: (value) => selectedOption(value),
                option: option,
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

String convertingRadioButtonOptionsToString(
    RadioButtonOptions? radioButtonOptions) {
  switch (radioButtonOptions) {
    case RadioButtonOptions.yes:
      return 'Yes';
    case RadioButtonOptions.na:
      return 'N/A';
    case RadioButtonOptions.no:
    default:
      return 'No';
  }
}

RadioButtonOptions convertingStringToRadioButtonOptions(
    String savedRadioButtonOptions) {
  switch (savedRadioButtonOptions.toLowerCase()) {
    case "yes":
      return RadioButtonOptions.yes;
    case "n/a":
      return RadioButtonOptions.na;
    case "no":
    default:
      return RadioButtonOptions.no;
  }
}

// if (_children_adolecent_caregiver == RadioButtonOptions.no || _adolescents_older_than_12 == RadioButtonOptions.no)

class FinalBenchMark extends StatefulWidget {
  const FinalBenchMark({super.key});

  @override
  State<FinalBenchMark> createState() => _FinalBenchMarkState();
}

class _FinalBenchMarkState extends State<FinalBenchMark> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Center(
        child: Text(
          'Overall number of points from all DOMAINS:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      Text(
        "Score: ${Provider.of<CparaProvider>(context).finalScore()} / (9 points)",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      DataTable(
        dataRowMaxHeight: 60.0,
        dataRowMinHeight: 40.0,
        horizontalMargin: 10.0,
        columns: const [
          DataColumn(
              label: Expanded(
            child: FittedBox(
              child: Text('Domain',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          )),
          DataColumn(
              label: Expanded(
            child: FittedBox(
              child: Text('Max Score',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          )),
          DataColumn(
              label: Expanded(
            child: FittedBox(
              child: Text('HH Score',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          )),
        ],
        rows: [
          DataRow(cells: [
            const DataCell(Text('Healthy')),
            const DataCell(Text('4')),
            DataCell(Text(
                '${Provider.of<CparaProvider>(context).healthyBenchmark()}')),
          ]),
          DataRow(cells: [
            const DataCell(Text('Stable')),
            const DataCell(Text('1')),
            DataCell(Text(
                '${Provider.of<CparaProvider>(context).stableBenchMark()}')),
          ]),
          DataRow(cells: [
            const DataCell(Text('Safe')),
            const DataCell(Text('3')),
            DataCell(
                Text('${Provider.of<CparaProvider>(context).safeBenchMark()}')),
          ]),
          DataRow(cells: [
            const DataCell(Text('Schooled')),
            const DataCell(Text('1')),
            DataCell(Text(
                '${Provider.of<CparaProvider>(context).schooledBenchmark()}')),
          ]),
          DataRow(cells: [
            const DataCell(Text('Total')),
            const DataCell(Text('9')),
            DataCell(
                Text('${Provider.of<CparaProvider>(context).finalScore()}')),
          ]),
        ],
      ),
      const SizedBox(
        height: 25,
      ),
      DataTable(
        dataRowColor: MaterialStateColor.resolveWith((states) => lightBlue),
        dataRowMaxHeight: 60.0,
        dataRowMinHeight: 40.0,
        horizontalMargin: 10.0,
        columns: const [
          DataColumn(
            label: Text(
              'KEY',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ),
        ],
        rows: [
          DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  // Return the color for selected state.
                  return Colors.grey;
                } else {
                  final score =
                      Provider.of<CparaProvider>(context).finalScore();
                  if (score < 5) {
                    return Colors.blue;
                  }
                  // Return the default color for other states.
                  return null; // You can use null to apply the default color.
                }
              },
            ),
            cells: const [
              DataCell(Text('Highly Vulnerable 0-4 ')),
            ],
          ),
          DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  // Return the color for selected state.
                  return Colors.grey;
                } else {
                  final score =
                      Provider.of<CparaProvider>(context).finalScore();
                  if (score >= 5 && score < 8) {
                    return Colors.blue;
                  }
                  // Return the default color for other states.
                  return null; // You can use null to apply the default color.
                }
              },
            ),
            cells: const [
              DataCell(Text('Medium vulnerability 5-7')),
            ],
          ),
          DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  // Return the color for selected state.
                  return Colors.grey;
                } else {
                  final score =
                      Provider.of<CparaProvider>(context).finalScore();
                  if (score == 8) {
                    return Colors.blue;
                  }
                  // Return the default color for other states.
                  return null; // You can use null to apply the default color.
                }
              },
            ),
            cells: const [
              DataCell(Text(' Low vulnerability 8 ')),
            ],
          ),
          DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  // Return the color for selected state.
                  return Colors.grey;
                } else {
                  final score =
                      Provider.of<CparaProvider>(context).finalScore();
                  if (score == 9) {
                    return Colors.blue;
                  }
                  // Return the default color for other states.
                  return null; // You can use null to apply the default color.
                }
              },
            ),
            cells: const [
              DataCell(Text(' Ready to graduate 9 ')),
            ],
          ),
        ],
      ),
    ]);
  }
}

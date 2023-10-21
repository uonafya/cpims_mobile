import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/screens/cpara/model/cpara_question_ids.dart';
import 'package:cpims_mobile/screens/cpara/model/db_model.dart';
import 'package:cpims_mobile/screens/cpara/model/stable_model.dart';
import 'package:cpims_mobile/screens/cpara/provider/cpara_provider.dart';
import 'package:cpims_mobile/screens/cpara/provider/db_util.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/cpara/widgets/stable_widget_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class CparaStableWidget extends StatefulWidget {
  const CparaStableWidget({super.key});

  @override
  State<CparaStableWidget> createState() => _CparaStableWidgetState();
}

class _CparaStableWidgetState extends State<CparaStableWidget> {
  RadioButtonOptions? question1Option, question2Option, question3Option;

  RadioButtonOptions? getOverallOption({RadioButtonOptions? question1Option, RadioButtonOptions? question2Option, RadioButtonOptions? question3Option}){

    if(question1Option == null && question2Option == null && question3Option == null){
      return null;
    }
    else{
      List<RadioButtonOptions?> options = [question1Option, question2Option, question3Option];
      for(var option in options){
        if(option == null || option == RadioButtonOptions.no){
          return RadioButtonOptions.no;
        }
      }
    }

    return RadioButtonOptions.yes;
  }

  @override
  void initState() {
    StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
    question1Option = stableModel.question1 == null ? question1Option : convertingStringToRadioButtonOptions(stableModel.question1!);
    question2Option = stableModel.question2 == null ? question2Option : convertingStringToRadioButtonOptions(stableModel.question2!);
    question3Option = stableModel.question3 == null ? question3Option : convertingStringToRadioButtonOptions(stableModel.question3!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return StableWidgetWrapper(
      children: [
const GoalWidget(
    title: 'Stable: Goal 5: Increase Caregiver’s Ability to Meet Important Family Need',
    description: 'Benchmark 5: Caregivers are able to access money (without selling productive assets) to pay for school fees,'
        ' medical costs (buy medicine, transport to facility etc), legal and other administrative fees (related to guardianship, civil registration, or inheritance) for children 0-17 years The HH meets the benchmark if a primary caregiver has confirmed that the HH has the ability to pay for education and medical care without distress selling of HH assets /productive assets and or using a PEPFAR cash transfer. (Unplanned sale of HH items/emergency sale of productive assets to address emergency needs)',),
        const SizedBox(height: 10,),
        const QuestionForCard(text: "Question for caregiver:",),
        const SizedBox(height: 30,),
        QuestionWidget(
          question: "5.1 Were you able to pay school fees for the last two terms for all school going children in your household without PEPFAR support? (Confirm availability of school fees receipt, government supported cash transfer/scholarships, confirm school going children are retained in school)",
          selectedOption: (value){
            setState(() {
              question1Option = value;
              StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
              String selectedOption = convertingRadioButtonOptionsToString(value);
              context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question1: selectedOption));
            });
          },
          isNaAvailable: true,
          option: question1Option,
        ),
        const SizedBox(height: 30,),
        QuestionWidget(
          question: "5.2 Was anyone sick in the past six months, were you able to pay all medical costs in the past 6 months for all children in your household under the age of 18 without PEPFAR support? Medical costs include medicine and transport to medical appointments",
          selectedOption: (value){
            setState(() {
              question2Option = value;
              StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
              String selectedOption = convertingRadioButtonOptionsToString(value);
              context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
            });
          },
          isNaAvailable: true,
          option: question2Option,
        ),
        const SizedBox(height: 30,),
        QuestionWidget(
          question: "5.3 In case you find yourself in a situation, are you currently able to pay for legal and other administrative fees related to guardianship, civil registration or inheritance?",
          selectedOption: (value){
            setState(() {
              question3Option = value;
              StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
              String selectedOption = convertingRadioButtonOptionsToString(value);
              context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question3: selectedOption));
            });
          },
          isNaAvailable: false,
          option: question3Option,
        ),
        const SizedBox(height: 30,),
        BenchMarkAchievementWidget(text: "Has the household achieved this benchmarks?", benchmarkOption: getOverallOption(question1Option: question1Option, question2Option: question2Option, question3Option: question3Option),),
      ],
    );
  }
}

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
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black54,
                fontSize: 14.0,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

class QuestionForCard extends StatelessWidget {
  final String text;
  const QuestionForCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(color: kPrimaryColor),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
      ),
    );
  }
}

class OverallQuestionWidget extends StatelessWidget {
  final String question;
  final Function(RadioButtonOptions?) selectedOption;
  const OverallQuestionWidget(
      {super.key, required this.question, required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(color: overallQuestionBlueColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomRadioButton(
              isNaAvailable: false,
              optionSelected: (value) => selectedOption(value))
        ],
      ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  final bool isNaAvailable;
  final String question;
  final RadioButtonOptions? option;
  final Function(RadioButtonOptions?) selectedOption;
  const QuestionWidget({super.key, required this.question, required this.selectedOption, required this.isNaAvailable, this.option});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: const BoxDecoration(
          color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                text: question,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black),
                children: const [
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.red),
                  )
                ]),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomRadioButton(
              option: option,
              isNaAvailable: isNaAvailable,
              optionSelected: (value) => selectedOption(value))
        ],
      ),
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
        QuestionWidget(
          question: "6.3 Have you been exposed to violence, abuse (sexual, physical or emotional), neglect, or exploitation in the last six months?",
          selectedOption: (value){}, isNaAvailable: false,
        ),
      ],
    ));
  }
}

class NotFoundWidget extends StatelessWidget {
  final String text;
  const NotFoundWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.orange[50],
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.orange),
        ),
      ),
    );
  }
}

class BenchMarkAchievementWidget extends StatelessWidget {
  final String text;
  final RadioButtonOptions? benchmarkOption;
  const BenchMarkAchievementWidget({super.key, required this.text, required this.benchmarkOption});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4.0,
            height: 200.0,
            decoration: const BoxDecoration(
                color: Colors.grey
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: 2.0,
              height: 80.0,
              decoration: const BoxDecoration(
                  color: Colors.white
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 4.0,
              // height: 100.0,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300
              ),
              child: Column(
                children: [
                  Text(text, style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16
                  ),),
                  BenchmarkCustomRadioButtons(benchmarkOption: benchmarkOption)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PastCPARAWidget extends StatelessWidget {
  const PastCPARAWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Past CPARA", style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18
        ),),
        SizedBox(height: 10,),
        PastCPARAListWidget(),
      ],
    );
  }
}

class PastCPARAListWidget extends StatefulWidget {
  const PastCPARAListWidget({super.key});

  @override
  State<PastCPARAListWidget> createState() => _PastCPARAListWidgetState();
}

class _PastCPARAListWidgetState extends State<PastCPARAListWidget> {
  Database? database;
  List<CPARADatabase> pastCparaList = [];
  @override
  void initState() {
    initializeDbInstance();
      super.initState();
  }

  Future<void> initializeDbInstance() async {
    database = await LocalDb.instance.database;
   if(mounted) setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200
        ),
        child: FutureBuilder<List<CPARADatabase>>(
          future: database != null ? getUnsyncedForms(database!) : Future.value([]),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData){
                pastCparaList = snapshot.data!;
              }
              return
                pastCparaList.isEmpty ? const NotFoundWidget(text: 'No past CPARA found',) :
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: pastCparaList.length,
                  itemBuilder: (context, index){
                    CPARADatabase cparaDatabase = pastCparaList[index];
                    return PastCPARACardWidget(cparaDatabase: cparaDatabase,);
                  });
            }
            else {
    return const Center(child: Text('Unable to load data'));
    }
    },
    ),
    );
  }
}

class PastCPARACardWidget extends StatelessWidget {
  final CPARADatabase cparaDatabase;
  const PastCPARACardWidget({super.key, required this.cparaDatabase});

  @override
  Widget build(BuildContext context) {

    Map<String, List<CPARAChildQuestions>> separatedChildren = {};

    for (var child in cparaDatabase.childQuestions) {
      if (!separatedChildren.containsKey(child.ovc_cpims_id)) {
        separatedChildren[child.ovc_cpims_id] = [];
      }
      separatedChildren[child.ovc_cpims_id]!.add(child);
    }

    // Printing the separated children
    separatedChildren.forEach((id, childrenList) {
      print("Children with ID $id:");
      for (var child in childrenList) {
        print("  ${child.question_code} - ${child.answer_id}");
      }
    });

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(cparaDatabase.date_of_event, style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue
                ),),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     GestureDetector(
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 2.0),
            //         child: Container(
            //             decoration: BoxDecoration(
            //                 color: kPrimaryColor.withOpacity(0.1), shape: BoxShape.circle),
            //             child: const Padding(
            //               padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0, right: 8.0),
            //               child: Center(
            //                   child: Icon(
            //                     CupertinoIcons.pen,
            //                     color: kPrimaryColor,
            //                   )),
            //             )),
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 20,
            //     ),
            //     GestureDetector(
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 2.0),
            //         child: Container(
            //             decoration: BoxDecoration(
            //                 color: kPrimaryColor.withOpacity(0.1), shape: BoxShape.circle),
            //             child: const Padding(
            //               padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0, right: 8.0),
            //               child: Center(
            //                   child: Icon(
            //                     CupertinoIcons.delete,
            //                     color: kPrimaryColor,
            //                   )),
            //             )),
            //       ),
            //     ),
            //   ],
            // ),
              ],
            ),
            const SizedBox(height: 20,),
            // const Text("Household questions", style: TextStyle(
            //     fontWeight: FontWeight.bold, fontSize: 16
            // ),),
            // const SizedBox(height: 10,),
            // for(int i = 0; i < cparaDatabase.questions.length; i++)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(cparaDatabase.questions[i].question_code, style: const TextStyle(
            //           fontWeight: FontWeight.normal, fontSize: 14
            //       ),),
            //       Text(cparaDatabase.questions[i].answer_id, style: const TextStyle(
            //           fontWeight: FontWeight.normal, fontSize: 14
            //       ),),
            //     ],
            //   ),
            // const SizedBox(height: 20,),
            // const Text("Child questions", style: TextStyle(
            //     fontWeight: FontWeight.bold, fontSize: 16
            // ),),
            // const SizedBox(height: 10,),
            // for(int i = 0; i < cparaDatabase.childQuestions.length; i++)
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(cparaDatabase.childQuestions[i].question_code, style: const TextStyle(
            //         fontWeight: FontWeight.normal, fontSize: 14
            //     ),),
            //     Text(cparaDatabase.childQuestions[i].answer_id, style: const TextStyle(
            //         fontWeight: FontWeight.normal, fontSize: 14
            //     ),),
            //   ],
            // ),
            // const SizedBox(height: 10,),
            // const Text("Child questions v2", style: TextStyle(
            //     fontWeight: FontWeight.bold, fontSize: 16
            // ),),
            // const SizedBox(height: 10,),
            // ListView.builder(itemBuilder: (
            //     context, index){
            //   String childId = separatedChildren.keys.elementAt(index);
            //   List<CPARAChildQuestions> data = separatedChildren[childId]!;
            //   for(int i = 0; i < data.length; i++) {
            //     return Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Text("Child ID ${data.length}: $childId", style: const TextStyle(
            //             fontWeight: FontWeight.bold, fontSize: 16 , color: Colors.blue
            //         ),),
            //         ListView.builder(
            //             shrinkWrap: true,
            //             physics: const NeverScrollableScrollPhysics(),
            //             itemCount: data.length,
            //             itemBuilder: (context, index){
            //           return Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(data[index].question_code, style: const TextStyle(
            //                   fontWeight: FontWeight.normal, fontSize: 14
            //               ),),
            //               Text(data[index].answer_id, style: const TextStyle(
            //                   fontWeight: FontWeight.normal, fontSize: 14
            //               ),),
            //             ],
            //           );
            //         }),
            //       ],
            //     );
            //   }
            // },
            //   itemCount: separatedChildren.length,
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            // ),
            // const SizedBox(height: 10,),
            GridView.builder(
              shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:8/1,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 20.0),
                itemBuilder: (context, index) {
                  return BenchmarkScoreWidget(index: index, cparaDatabase: cparaDatabase,);
                }),
            const SizedBox(height: 10,),
             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Benchmark score : ", style: TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 18, color: Colors.grey
                ),),
                Text(overallBenchMarkScoreValueFromDb(cparaDatabase: cparaDatabase), style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue
                ),),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

class BenchmarkScoreWidget extends StatelessWidget {
  final int index;
  final CPARADatabase cparaDatabase;
  const BenchmarkScoreWidget({super.key, required this.index, required this.cparaDatabase});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Benchmark ${index + 1} ', style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14.0),),
        Text('(${overallBenchMarkScoreFromDb(index: index + 1, cparaDatabase: cparaDatabase)})', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),),
      ],
    );
  }
}

class BenchmarkCustomRadioButtons  extends StatelessWidget {
  final RadioButtonOptions? benchmarkOption;

  const BenchmarkCustomRadioButtons(
      {required this.benchmarkOption,
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
            groupValue: benchmarkOption,
            onChanged: null),
        RadioListTile<RadioButtonOptions>(
            title: const Text('No'),
            value: RadioButtonOptions.no,
            groupValue: benchmarkOption,
            onChanged: null),
      ],
    );
  }
}

const lightBlue = Color.fromRGBO(217, 237, 247, 1);

const overallQuestionBlueColor = Color.fromRGBO(190, 226, 239, 1);

String convertingRadioButtonOptionsToString(RadioButtonOptions? radioButtonOptions) {
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

RadioButtonOptions convertingStringToRadioButtonOptions(String savedRadioButtonOptions) {
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

// for health and is benchmark 1
String benchMarkOneScoreFromDb({required CPARADatabase cparaDatabase}){
  // there are 5 questions 1.1 to 1.5 no overall questions
  String question1Answer = "Yes"; // 1.1
  String question2Answer = "Yes"; // 1.2
  String question3Answer = "Yes"; // 1.3
  String question4Answer = "Yes"; // 1.4
  String question5Answer = "Yes"; // 1.5


  for(CPARADatabaseQuestions question in cparaDatabase.questions){
    if(question.question_code == CparaQuestionIds.healthQuestion1){
      question1Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.healthQuestion2){
      question2Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.healthQuestion3){
      question3Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.healthQuestion4){
      question4Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.healthQuestion5){
      question5Answer = question.answer_id;
    }

  }


  List<String> answers = [question1Answer, question2Answer, question3Answer, question4Answer, question5Answer];

  for(String answer in answers){
    if("no" == answer.toLowerCase()){
      return "No";
    }
  }

  return "Yes";
}

// for health and is benchmark 2
String benchMarkTwoScoreFromDb({required CPARADatabase cparaDatabase}){
  // there are 13 questions 2.1 to 2.9 with 4 overall questions
  String question1Answer = "Yes"; // 2.1
  String question2Answer = "Yes"; // 2.2
  String question3Answer = "Yes"; // 2.3
  String question4Answer = "Yes"; // 2.4
  String question5Answer = "Yes"; // 2.5
  String question6Answer = "Yes"; // 2.6
  String question7Answer = "Yes"; // 2.7
  String question8Answer = "Yes"; // 2.8
  String question9Answer = "Yes"; // 2.9
  String overallQuestion1Answer = "Yes"; // Is there anyone who is HIV positive in the Household ?
  String overallQuestion2Answer = "Yes"; // Is there a child 0 - 12 years who is HIV positive ?
  String overallQuestion3Answer = "Yes"; // Is there an adolescents or a child above 12 years who is HIV positive ?
  String overallQuestion4Answer = "Yes"; // Is the caregiver HIV positive ?

  for(CPARADatabaseQuestions question in cparaDatabase.questions){
    if(question.question_code == CparaQuestionIds.healthGoal2Question1){
      question1Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.healthGoal2Question2){
      question2Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.healthGoal2Question3){
      question3Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.healthGoal2Question4){
      question4Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.healthGoal2Question5){
      question5Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.healthGoal2Question6){
      question6Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.healthGoal2Question7){
      question7Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.healthGoal2Question8){
      question8Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.healthGoal2Question9){
      question9Answer = question.answer_id;
    }

  }

  List<String> answers = [question1Answer, question2Answer, question3Answer, question4Answer, question5Answer, question6Answer, question7Answer, question8Answer, question9Answer];

  for(String answer in answers){
    if("no" == answer.toLowerCase()){
      return "No";
    }
  }

  return "Yes";
}

// for health and is benchmark 3
String benchMarkThreeScoreFromDb({required CPARADatabase cparaDatabase}){
  // there are 3 child questions 3.1 to 3.3 with 1 overall questions
  String childQuestion1Answer = "Yes"; // loops through all the children 3.1
  String childQuestion2Answer = "Yes"; // loops through all the children 3.2
  String childQuestion3Answer = "Yes"; // loops through all the children 3.3
  String overallQuestion1Answer = "Yes"; // Does the household have adolescent girls and boys ?

  // // grouping the children by their ids
  // Map<String, List<CPARAChildQuestions>> separatedChildren = {};
  //
  // for (var child in cparaDatabase.childQuestions) {
  //   if (!separatedChildren.containsKey(child.ovc_cpims_id)) {
  //     separatedChildren[child.ovc_cpims_id] = [];
  //   }
  //   separatedChildren[child.ovc_cpims_id]!.add(child);
  // }
  //
  // // Printing the separated children
  // separatedChildren.forEach((id, childrenList) {
  //   print("Children with ID $id:");
  //   for (var child in childrenList) {
  //     print("  ${child.question_code} - ${child.answer_id}");
  //   }
  // });
  List<String> answers = [];
  for(CPARADatabaseQuestions question in cparaDatabase.questions){
    if(question.question_code == CparaQuestionIds.healthGoal3ChildQuestion1){
      childQuestion1Answer = question.answer_id;
      answers.add(childQuestion1Answer);
    }
    else if(question.question_code == CparaQuestionIds.healthGoal3ChildQuestion2){
      childQuestion2Answer = question.answer_id;
      answers.add(childQuestion2Answer);
    }
    else if(question.question_code == CparaQuestionIds.healthGoal3ChildQuestion3){
      childQuestion3Answer = question.answer_id;
      answers.add(childQuestion3Answer);
    }


  }

  // List<String> answers = [childQuestion1Answer, childQuestion2Answer, childQuestion3Answer];

  for(String answer in answers){
    if("no" == answer.toLowerCase()){
      return "No";
    }
  }

  return "Yes";
}

// for health and is benchmark 4
String benchMarkFourScoreFromDb({required CPARADatabase cparaDatabase}){
  // there are 6 questions 4.1 to 4.4 with 2 overall questions
  String question1Answer = "Yes"; // 4.1
  String question2Answer = "Yes"; // 4.2
  String question3Answer = "Yes"; // 4.3
  String question4Answer = "Yes"; // 4.4
  String overallQuestion1Answer = "Yes"; // Is there child < 5 years in the household ?
  String overallQuestion2Answer = "Yes"; // Is there child < 2 years in the household ?

  for(CPARADatabaseQuestions question in cparaDatabase.questions){
    if(question.question_code == CparaQuestionIds.healthGoal4Question1){
      question1Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.healthGoal4Question2){
      question2Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.healthGoal4Question3){
      question3Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.healthGoal4Question4){
      question4Answer = question.answer_id;
    }

  }

  List<String> answers = [question1Answer, question2Answer, question3Answer, question4Answer];

  for(String answer in answers){
    if("no" == answer.toLowerCase()){
      return "No";
    }
  }

  return "Yes";
}

// for stable
String benchMarkFiveScoreFromDb({required CPARADatabase cparaDatabase}){
  // there are 3 questions 5.1 to 5.3 no overall questions
  String question1Answer = "Yes"; // 5.1
  String question2Answer = "Yes"; // 5.2
  String question3Answer = "Yes"; // 5.3

  for(CPARADatabaseQuestions question in cparaDatabase.questions){
    if(question.question_code == CparaQuestionIds.stableQuestion1){
      question1Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.stableQuestion2){
      question2Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.stableQuestion3){
      question3Answer = question.answer_id;
    }

  }

  List<String> answers = [question1Answer, question2Answer, question3Answer];

  for(String answer in answers){
    if("no" == answer.toLowerCase()){
      return "No";
    }
  }

  return "Yes";
}

// for safe and is benchmark 1
String benchMarkSixScoreFromDb({required CPARADatabase cparaDatabase}){
  // there are 7 questions 6.1 to 6.5 with 2 overall questions and one child question
  String question1Answer = "Yes"; // 6.1
  String question2Answer = "Yes"; // 6.2
  String question3Answer = "Yes"; // 6.4
  String question4Answer = "Yes"; // 6.5
  String overallQuestion1Answer = "Yes"; // Are there children, adolescents, and caregivers in the household who have experienced violence
  String overallQuestion2Answer = "Yes"; // Is there adolescents 12 years and above ?
  String childQuestion1Answer = "Yes"; // depends on number of children 6.3 Have you been exposed to violence, abuse (sexual, physical or emotional), neglect, or exploitation in the last six months?
List<String> childAnswers = [];
  for(CPARADatabaseQuestions question in cparaDatabase.questions){
    if(question.question_code == CparaQuestionIds.safeQuestion1){
      question1Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.safeQuestion2){
      question2Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.safeQuestion3){
      question3Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.safeQuestion4){
      question4Answer = question.answer_id;
    }

  }

  for(CPARAChildQuestions question in cparaDatabase.childQuestions){
    if(question.question_code == CparaQuestionIds.safeChildQuestion1){
      childAnswers.add(question.answer_id);
    }

  }

  // for child answers
  for(String answer in childAnswers){
    if("no" == answer.toLowerCase()){
      childQuestion1Answer = "No";
    }
  }

  List<String> answers = [question1Answer, question2Answer, question3Answer, question4Answer, childQuestion1Answer];

  for(String answer in answers){
    if("no" == answer.toLowerCase()){
      return "No";
    }
  }

  return "Yes";
}

// for safe and is benchmark 2
String benchMarkSevenScoreFromDb({required CPARADatabase cparaDatabase}){
  // there are 2 questions 7.1 to 7.2 with no overall questions
  String question1Answer = "Yes"; // 7.1
  String question2Answer = "Yes"; // 7.2

for(CPARADatabaseQuestions question in cparaDatabase.questions){
    if(question.question_code == CparaQuestionIds.safeQuestion5){
      question1Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.safeQuestion6){
      question2Answer = question.answer_id;
    }
  }

  List<String> answers = [question1Answer, question2Answer];

  for(String answer in answers){
    if("no" == answer.toLowerCase()){
      return "No";
    }
  }

  return "Yes";
}

// for safe and is benchmark 3
String benchMarkEightScoreFromDb({required CPARADatabase cparaDatabase}){
  // there are 1 questions 8.1 with no overall questions
  String question1Answer = "Yes"; // 8.1

  for(CPARADatabaseQuestions question in cparaDatabase.questions){
    if(question.question_code == CparaQuestionIds.safeQuestion7){
      question1Answer = question.answer_id;
    }
  }
  List<String> answers = [question1Answer];

  for(String answer in answers){
    if("no" == answer.toLowerCase()){
      return "No";
    }
  }

  return "Yes";
}

// for schooled
String benchMarkNineScoreFromDb({required CPARADatabase cparaDatabase}){
  // there are 6 questions 9.1 to 9.4 with 2 overall questions
  String question1Answer = "Yes"; // 9.1
  String question2Answer = "Yes"; // 9.2
  String question3Answer = "Yes"; // 9.3
  String question4Answer = "Yes"; // 9.4
  String overallQuestion1Answer = "Yes"; // are there school going children
  String overallQuestion2Answer = "Yes"; // is there a child btw 4-5 years and ECDE in the area

  for(CPARADatabaseQuestions question in cparaDatabase.questions){
    if(question.question_code == CparaQuestionIds.schooledQuestion1){
      question1Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.schooledQuestion2){
      question2Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.schooledQuestion3){
      question3Answer = question.answer_id;
    }
    else if(question.question_code == CparaQuestionIds.schooledQuestion4){
      question4Answer = question.answer_id;
    }

  }

//   if(overallQuestion1Answer.toLowerCase() ==  "no"){
//     // skip question 9.1 and 9.2
// question1Answer = "No";
// question2Answer = "No";
//   }
//
//   if(overallQuestion2Answer.toLowerCase() ==  "no"){
//     // skip question 9.3
// question3Answer = "No";
//
//   }

  List<String> answers = [question1Answer, question2Answer, question3Answer, question4Answer,];

  for(String answer in answers){
    if("no" == answer.toLowerCase()){
      return "No";
    }
  }

  return "Yes";
}

String overallBenchMarkScoreFromDb({required int index, required CPARADatabase cparaDatabase}){
  switch(index){
    case 1:
      return benchMarkOneScoreFromDb(cparaDatabase: cparaDatabase);
    case 2:
      return benchMarkTwoScoreFromDb(cparaDatabase: cparaDatabase);
    case 3:
      return benchMarkThreeScoreFromDb(cparaDatabase: cparaDatabase);
    case 4:
      return benchMarkFourScoreFromDb(cparaDatabase: cparaDatabase);
    case 5:
      return benchMarkFiveScoreFromDb(cparaDatabase: cparaDatabase);
    case 6:
      return benchMarkSixScoreFromDb(cparaDatabase: cparaDatabase);
    case 7:
      return benchMarkSevenScoreFromDb(cparaDatabase: cparaDatabase);
    case 8:
      return benchMarkEightScoreFromDb(cparaDatabase: cparaDatabase);
    case 9:
      return benchMarkNineScoreFromDb(cparaDatabase: cparaDatabase);
    default:
      return "No";
  }
}

String overallBenchMarkScoreValueFromDb({required CPARADatabase cparaDatabase}){
  int score = 0;

  List<String> answers = [benchMarkOneScoreFromDb(cparaDatabase: cparaDatabase),
    benchMarkTwoScoreFromDb(cparaDatabase: cparaDatabase),
    benchMarkThreeScoreFromDb(cparaDatabase: cparaDatabase),
    benchMarkFourScoreFromDb(cparaDatabase: cparaDatabase),
    benchMarkFiveScoreFromDb(cparaDatabase: cparaDatabase),
    benchMarkSixScoreFromDb(cparaDatabase: cparaDatabase),
    benchMarkSevenScoreFromDb(cparaDatabase: cparaDatabase),
    benchMarkEightScoreFromDb(cparaDatabase: cparaDatabase),
    benchMarkNineScoreFromDb(cparaDatabase: cparaDatabase)];


  for(String answer in answers){
    if("yes" == answer.toLowerCase()){
      score++;
    }
  }

      return score.toString();
}

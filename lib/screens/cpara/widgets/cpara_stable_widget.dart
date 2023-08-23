import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/cpara/widgets/stable_widget_wrapper.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:flutter/material.dart';

class CparaStableWidget extends StatefulWidget {
  const CparaStableWidget({super.key});

  @override
  State<CparaStableWidget> createState() => _CparaStableWidgetState();
}

class _CparaStableWidgetState extends State<CparaStableWidget> {
  RadioButtonOptions? selected;
  @override
  Widget build(BuildContext context) {
    return StableWidgetWrapper(
      children: [
const GoalWidget(
    title: 'Safe: Goal 6: Reduced Risk of Physical, Emotional and Psychological Injury Due to Exposure to Violence',
    description: 'Benchmark 6: No children, adolescents, and caregivers in the household report experiences of violence (including physical violence, emotional violence'
        ', sexual violence, gender-based violence, and neglect) in the last six months. If there is no reported form of violence in the HH, skip all the questions and score N/A',),

        const SizedBox(height: 10,),
        const QuestionForCard(text: "Question for caregiver:",),
        const SizedBox(height: 10,),
        OverallQuestionWidget(question: "Are there children, adolescents, and caregivers in the household who have experienced violence(including physical violence,"
            " emotional violence, sexual violence, gender-based violence, and neglect) in the last six months ?",
        selectedOption: (value){},
        ),
        const SizedBox(height: 30,),
        QuestionWidget(
          question: "6.1 Have you experienced violence, abuse (sexual, physical, emotional) in the last six months?",
          selectedOption: (value){},
        ),
        const SizedBox(height: 30,),
        QuestionWidget(
          question: "6.2 Is there a child below 12 years who has been exposed to violence or abuse (sexual, physical or emotional), neglect, or exploitation in the last six months?",
          selectedOption: (value){},
        ),
        const SizedBox(height: 30,),
        OverallQuestionWidget(question: "Is there adolescents 12 years and above ?",
          selectedOption: (value){},
        ),
        const SizedBox(height: 10,),
        for(int i = 0; i < 3; i++)
          const ChildCardWidget(),
        const SizedBox(height: 10,),
        const SizedBox(height: 10,),
        const NotFoundWidget(text: "No siblings over 10 years found")
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
      decoration: const BoxDecoration(
        color: lightBlue
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Text(title, style: const TextStyle(
fontWeight: FontWeight.w400, fontSize: 18
          ),),
          const SizedBox(height: 10,),
          Text(description, style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black54, fontSize: 14.0, fontStyle: FontStyle.italic),),
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
      decoration: const BoxDecoration(
        color: kPrimaryColor
      ),
      child: Text(text, style: const TextStyle(
        fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white
      ),),
    );
  }
}

class OverallQuestionWidget extends StatelessWidget {
  final String question;
  final Function(RadioButtonOptions?) selectedOption;
  const OverallQuestionWidget({super.key, required this.question, required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(
        color: overallQuestionBlueColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 18
          ),),
          const SizedBox(height: 10,),
          CustomRadioButton(isNaAvailable: false, optionSelected: (value) => selectedOption(value))
        ],
      ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  final String question;
  final Function(RadioButtonOptions?) selectedOption;
  const QuestionWidget({super.key, required this.question, required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      decoration: const BoxDecoration(
          color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(text: TextSpan(text: question, style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black
          ),
              children: const [
                TextSpan(text: '*', style: TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 16, color: Colors.red
                ),)
              ]
          ),),
          const SizedBox(height: 10,),
          CustomRadioButton(isNaAvailable: false, optionSelected: (value) => selectedOption(value))
        ],
      ),
    );
  }
}
class ChildCardWidget extends StatelessWidget {
  const ChildCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(child: Column(
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
                 Text('Child Name', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 12.0),),
                 Text('JANE BOLO', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 16.0),),
               ],
             ),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text('OVC CPIMS ID', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 12.0),),
                 Text('1573288', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 16.0),),
               ],
             ),
           ],
         ),
       ),
        QuestionWidget(
          question: "6.3 Have you been exposed to violence, abuse (sexual, physical or emotional), neglect, or exploitation in the last six months?",
          selectedOption: (value){},
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
        borderRadius: const BorderRadius.all(Radius.circular(5))
      ),
      child: Center(
        child: Text(text, style: const TextStyle(
        fontWeight: FontWeight.bold, fontSize: 16, color: Colors.orange
    ),),
      ),);
  }
}

const lightBlue = Color.fromRGBO(217, 237, 247, 1);

const overallQuestionBlueColor = Color.fromRGBO(190, 226, 239, 1);
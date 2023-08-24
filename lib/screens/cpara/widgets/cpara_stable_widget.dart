import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:cpims_mobile/screens/cpara/widgets/stable_widget_wrapper.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:flutter/cupertino.dart';
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
    title: 'Stable: Goal 5: Increase Caregiver’s Ability to Meet Important Family Need',
    description: 'Benchmark 5: Caregivers are able to access money (without selling productive assets) to pay for school fees,'
        ' medical costs (buy medicine, transport to facility etc), legal and other administrative fees (related to guardianship, civil registration, or inheritance) for children 0-17 years The HH meets the benchmark if a primary caregiver has confirmed that the HH has the ability to pay for education and medical care without distress selling of HH assets /productive assets and or using a PEPFAR cash transfer. (Unplanned sale of HH items/emergency sale of productive assets to address emergency needs)',),
        const SizedBox(height: 10,),
        const QuestionForCard(text: "Question for caregiver:",),
        const SizedBox(height: 30,),
        QuestionWidget(
          question: "5.1 Were you able to pay school fees for the last two terms for all school going children in your household without PEPFAR support? (Confirm availability of school fees receipt, government supported cash transfer/scholarships, confirm school going children are retained in school)",
          selectedOption: (value){},
          isNaAvailable: true,
        ),
        const SizedBox(height: 30,),
        QuestionWidget(
          question: "5.2 Was anyone sick in the past six months, were you able to pay all medical costs in the past 6 months for all children in your household under the age of 18 without PEPFAR support? Medical costs include medicine and transport to medical appointments",
          selectedOption: (value){},
          isNaAvailable: true,
        ),
        const SizedBox(height: 30,),
        QuestionWidget(
          question: "5.3 In case you find yourself in a situation, are you currently able to pay for legal and other administrative fees related to guardianship, civil registration or inheritance?",
          selectedOption: (value){},
          isNaAvailable: false,
        ),
        const SizedBox(height: 30,),
        BenchMarkAchievementWidget(text: "Has the household achieved this benchmarks?", selectedOption: (value){},),
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
  final Function(RadioButtonOptions?) selectedOption;
  const QuestionWidget({super.key, required this.question, required this.selectedOption, required this.isNaAvailable});


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
              isNaAvailable: false,
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
  final Function(RadioButtonOptions?) selectedOption;
  const BenchMarkAchievementWidget({super.key, required this.text, required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      // height: 100.0,
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
                  CustomRadioButton(isNaAvailable: false, optionSelected: (value){})
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

class PastCPARAListWidget extends StatelessWidget {
  const PastCPARAListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200
        ),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index){
          return const PastCPARACardWidget();
        }));
  }
}

class PastCPARACardWidget extends StatelessWidget {
  const PastCPARACardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Feb 11, 2023", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue
                ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.1), shape: BoxShape.circle),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0, right: 8.0),
                          child: Center(
                              child: Icon(
                                CupertinoIcons.pen,
                                color: kPrimaryColor,
                              )),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.1), shape: BoxShape.circle),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0, right: 8.0),
                          child: Center(
                              child: Icon(
                                CupertinoIcons.delete,
                                color: kPrimaryColor,
                              )),
                        )),
                  ),
                ),
              ],
            ),
              ],
            ),
            const SizedBox(height: 20,),
            // Expanded(
            //   child: GridView.builder(
            //     // shrinkWrap: true,
            //       itemCount: 2,
            //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 9,
            //           childAspectRatio: 2/1.5,
            //           mainAxisSpacing: 10.0,
            //           crossAxisSpacing: 20.0),
            //       itemBuilder: (context, index) {
            //         return Row(
            //           children: [
            //             Text('Benchmark ${index + 1} ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14.0),),
            //             Text('(Yes)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),),
            //           ],
            //         );
            //       }),
            // ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Benchmark 1 ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14.0),),
                    Text('(Yes)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),),
                  ],
                ),
                Row(
                  children: [
                    Text('Benchmark 2 ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14.0),),
                    Text('(Yes)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Benchmark 3 ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14.0),),
                    Text('(Yes)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),),
                  ],
                ),
                Row(
                  children: [
                    Text('Benchmark 4 ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14.0),),
                    Text('(Yes)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Benchmark 5 ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14.0),),
                    Text('(Yes)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),),
                  ],
                ),
                Row(
                  children: [
                    Text('Benchmark 6 ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14.0),),
                    Text('(No)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Benchmark 7 ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14.0),),
                    Text('(No)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),),
                  ],
                ),
                Row(
                  children: [
                    Text('Benchmark 8 ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14.0),),
                    Text('(Yes)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6,),
            const Row(
              children: [
                Text('Benchmark 9 ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14.0),),
                Text('(No)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),),
              ],
            ),
            const SizedBox(height: 10,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Benchmark score : ", style: TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 18, color: Colors.grey
                ),),
                Text("7", style: TextStyle(
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

const lightBlue = Color.fromRGBO(217, 237, 247, 1);

const overallQuestionBlueColor = Color.fromRGBO(190, 226, 239, 1);

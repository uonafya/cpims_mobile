// import 'package:cpims_mobile/Models/case_load_model.dart';
// import 'package:cpims_mobile/constants.dart';
// import 'package:cpims_mobile/screens/cpara/provider/cpara_provider.dart';
// import 'package:cpims_mobile/screens/cpara/widgets/cpara_stable_widget.dart';
// import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../registry/organisation_units/widgets/steps_wrapper.dart';
// import '../model/health_model.dart';
//
// class CparaHealthyWidget extends StatefulWidget {
//   const CparaHealthyWidget({super.key});
//
//   @override
//   State<CparaHealthyWidget> createState() => _CparaHealthyWidgetState();
// }
//
// class _CparaHealthyWidgetState extends State<CparaHealthyWidget> {
//   // State of the questions
//   RadioButtonOptions? question1Option, question2Option, question3Option;
//   // List of children
//   late List<HealthChild> children;
//
//   @override
//   void initState() {
//     super.initState();
//     List<CaseLoadModel> models = context.read<CparaProvider>().children ?? [];
//     // Get instance of model from provider
//     HealthModel healthModel = context.read<CparaProvider>().healthModel ?? HealthModel();
//     // question1Option = stableModel.question1 == null ? question1Option : convertingStringToRadioButtonOptions(stableModel.question1!);
//     // question2Option = stableModel.question2 == null ? question2Option : convertingStringToRadioButtonOptions(stableModel.question2!);
//     // question3Option = stableModel.question3 == null ? question3Option : convertingStringToRadioButtonOptions(stableModel.question3!);
//
//     // Initialize children
//     children = [];
//     for (CaseLoadModel model in models) {
//       children.add(HealthChild(
//           id: "${model.cpimsId}",
//           question1: "",
//           question2: "",
//           question3: "",
//           name: "${model.ovcFirstName} ${model.ovcSurname}"));
//     }
//     // Initialize Details
//   }
//
//   RadioButtonOptions? getOverallOption({RadioButtonOptions? question1Option, RadioButtonOptions? question2Option, RadioButtonOptions? question3Option}){
//
//     if(question1Option == null && question2Option == null && question3Option == null){
//       return null;
//     }
//     else{
//       List<RadioButtonOptions?> options = [question1Option, question2Option, question3Option];
//       for(var option in options){
//         if(option == null || option == RadioButtonOptions.no){
//           return RadioButtonOptions.no;
//         }
//       }
//     }
//
//     return RadioButtonOptions.yes;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StepsWrapper(
//       title: 'CPARA healthy widget',
//       children: [
//         const GoalWidget(
//           title: 'Healthy: Goal 1: Increase diagnosis of HIV infection',
//           description: 'Benchmark 1: All children, adolescents, and caregivers in the household have known HIV status or a test is not required based on risk assessment'
//               'Caseworker is advised to refer to job aid about discussing sensitive topics for this section, if needed.',),
//         const SizedBox(height: 10),
//         const Text("(Adolescent must have tested HIV negative or screened for HIV risk and HIV test was not required in the last six months)",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 14.0,
//           ),
//         ),
//         const SizedBox(height: 20),
//         const QuestionForCard(text: "HIV diagnosis for children",),
//         const SizedBox(height: 20,),
//         QuestionWidget(
//           question: "1.1 Have all your children been tested for HIV and their HIV status known (HIV negative, positive) ?",
//           selectedOption: (value){
//             setState(() {
//               // question1Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question1: selectedOption));
//             });
//           },
//           isNaAvailable: false,
//           option: question1Option,
//         ),
//         const SizedBox(height: 10,),
//         QuestionWidget(
//           question: "1.2 For those with unknown HIV status, have they been screened for HIV risk and results showed test not required ?",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: true,
//           option: question2Option,
//         ),
//         const SizedBox(height: 20),
//         const QuestionForCard(text: "Early Infant Diagnosis",),
//         const SizedBox(height: 10,),
//         QuestionWidget(
//           question: "1.3 If there is an infant Exposed to HIV (HEI), has the final HIV status been confirmed at 18 months or one week after cessation of breastfeeding, whichever comes later ?",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: true,
//           option: question2Option,
//         ),
//         const SizedBox(height: 20),
//         const QuestionForCard(text: "HIV diagnosis for caregiver",),
//         const SizedBox(height: 10,),
//         QuestionWidget(
//           question: "1.4 Is the HIV status of the caregiver known (positive, negative) ?",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: false,
//           option: question2Option,
//         ),
//         const SizedBox(height: 10,),
//         QuestionWidget(
//           question: "1.5 For caregiver with unknown HIV status have they been screened for HIV risk and the results showing test not required ?",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: true,
//           option: question2Option,
//         ),
//         const SizedBox(height: 30,),
//         BenchMarkAchievementWidget(text: "Has the household achieved this benchmarks?", benchmarkOption: getOverallOption(question1Option: question1Option, question2Option: question2Option, question3Option: question3Option),),
//         const SizedBox(height: 30,),
//         const GoalWidget(
//           title: 'Healthy: Goal 2: Increase HIV treatment adherence, continuity of treatment and viral suppression',
//           description: 'Benchmark 2: All HIV+ children, adolescents, and caregivers in the household with a viral'
//               ' load result documented in the medical record and/or laboratory information systems (LIS) have been virally suppressed for the last 12 months. All HIV+ children, adolescents, and caregivers in the household have adhered to treatment for 12 months after initiation of antiretroviral therapy Note: The questions below apply to HHs with child/adolescent living with HIV and HIV positive caregivers (If the child/caregiver has not sustained viral load suppression for the past 12 months the benchmark is achieved if they are adhering to treatment for the last 12 months)',),
//         const SizedBox(height: 10,),
//         OverallQuestionWidget(
//         question: "Is there anyone who is HIV positive in the Household ?",
//         selectedOption: (value){
//           setState(() {
//             // question2Option = value;
//             // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//             // String selectedOption = convertingRadioButtonOptionsToString(value);
//             // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//           });
//         },
//       ),
//         const SizedBox(height: 10,),
//         const QuestionForCard(text: "Children 0-12",),
//         const SizedBox(height: 10,),
//         OverallQuestionWidget(
//           question: "Is there a child 0 - 12 years who is HIV positive ?",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//         ),
//         const SizedBox(height: 10,),
//         QuestionWidget(
//           question: "2.1 Have all HIV positive children on treatment with documented viral load results been suppressed in the past 12 months ?",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: false,
//           option: question2Option,
//         ),
//         // const SizedBox(height: 10,),
//         QuestionWidget(
//           question: "2.2 For those with no documented viral load results; Have all the children living with HIV been attending their appointments regularly for the past 12 months (check CCC card to confirm adherence to treatment)",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: true,
//           option: question2Option,
//         ),
//         // const SizedBox(height: 10,),
//         QuestionWidget(
//           question: "2.3 Have all HIV+ children been regularly taking medication without missing doses for the past 12 months (reported by caregiver for the 0-12 years) ?",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: false,
//           option: question2Option,
//         ),
//         const SizedBox(height: 10,),
//         const QuestionForCard(text: "Adolescents and children above 12 years",),
//         const SizedBox(height: 10,),
//         OverallQuestionWidget(
//           question: "Is there an adolescents or a child above 12 years who is HIV positive ?",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//         ),
//         const SizedBox(height: 10,),
//         QuestionWidget(
//           question: "2.4 Have all HIV positive children and adolescents (12years and above) on treatment with documented viral load results been suppressed in the past 12 months ?",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: false,
//           option: question2Option,
//         ),
//         QuestionWidget(
//           question: "2.5 For those with no documented viral load results; Have all the children and adolescents (12years and above) living with HIV been attending their appointments regularly for the past 12 months (check CCC card to confirm adherence to treatment)",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: true,
//           option: question2Option,
//         ),
//         QuestionWidget(
//           question: "2.6 Have all HIV+ adolescent been regularly taking medication without missing doses for the past 12 months? (Adolescents self-reported).",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: false,
//           option: question2Option,
//         ),
//         const SizedBox(height: 10,),
//         const QuestionForCard(text: "Caregiver",),
//         const SizedBox(height: 10,),
//         OverallQuestionWidget(
//           question: "Is the caregiver HIV positive ?",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//         ),
//         const SizedBox(height: 10,),
//         QuestionWidget(
//           question: "2.7 Have all HIV positive caregivers on treatment with documented viral load results been suppressed in the past 12 months ?",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: false,
//           option: question2Option,
//         ),
//         QuestionWidget(
//           question: "2.8 For those with no documented viral load results; Have the caregiver living with HIV been attending their appointments regularly for the past 12 months (check CCC card to confirm adherence to treatment)",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: true,
//           option: question2Option,
//         ),
//         QuestionWidget(
//           question: "2.9 Have all HIV+ caregivers been regularly taking medication without missing doses for the past 12 months? (Caregiver self-reported).",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: false,
//           option: question2Option,
//         ),
//         const SizedBox(height: 30,),
//         BenchMarkAchievementWidget(text: "Has the household achieved this benchmarks?", benchmarkOption: getOverallOption(question1Option: question1Option, question2Option: question2Option, question3Option: question3Option),),
//         const SizedBox(height: 30,),
//         const GoalWidget(
//           title: 'Healthy: Goal 3: Reduce Risk of HIV Infection',
//           description: 'Benchmark3: All adolescents 10-17 years of age in the household have key knowledge about preventing HIV infection Adolescents aged 10-17 can describe at least two HIV infection risks in their local community, can provide at least one example of how they can protect themselves against HIV risk, and can correctly describe the location of at least one place where HIV prevention support is available. '
//               'Note: For HHs with no adolescent girls and boys, skip questions below and select “N/A” for “Achievement of this benchmark.”',),
//         const SizedBox(height: 10,),
//         OverallQuestionWidget(
//           question: "Does the household have adolescent girls and boys ?",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//         ),
//         const SizedBox(height: 10,),
//         //todo: Add children here
//         BenchMarkAchievementWidget(text: "Has the household achieved this benchmarks?", benchmarkOption: getOverallOption(question1Option: question1Option, question2Option: question2Option, question3Option: question3Option),),
//         const SizedBox(height: 30,),
//         const GoalWidget(
//           title: 'Healthy: Goal 4: Improve Development for Children <5 Years (Particularly HIV Exposed and Infected Infants/Young Children)',
//           description: 'Benchmark 4: No children < 5 years in the household are undernourished Note: If none of the children in the household is <5 years) select “N/A” and move to the stale domain',),
//         const SizedBox(height: 10,),
//         OverallQuestionWidget(
//           question: "Is there child < 5 years in the household ?",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//         ),
//         const SizedBox(height: 10,),
//         QuestionWidget(
//           question: "4.1 Have all children below the age of five been assessed using MUAC and scored green ?",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: false,
//           option: question2Option,
//         ),
//         QuestionWidget(
//           question: "4.2 Have all the children below five years showed no signs of bipedal edema (e.g. Pressure applied on top of both feet for three seconds and did not leave a pit)?",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: false,
//           option: question2Option,
//         ),
//         QuestionWidget(
//           question: "4.3 Have all the children previously identified as malnourished been treated and has a Z score of >-2? (Confirm with clinical as appropriate)",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: true,
//           option: question2Option,
//         ),
//         OverallQuestionWidget(
//           question: "Is there child < 2 years in the household ?",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//         ),
//         QuestionWidget(
//           question: "4.4 If there is a child under 2 years in the household, Is the infant’s immunization on schedule? (Check mother baby booklet pages 33-35)",
//           selectedOption: (value){
//             setState(() {
//               // question2Option = value;
//               // StableModel stableModel = context.read<CparaProvider>().stableModel ?? StableModel();
//               // String selectedOption = convertingRadioButtonOptionsToString(value);
//               // context.read<CparaProvider>().updateStableModel(stableModel.copyWith(question2: selectedOption));
//             });
//           },
//           isNaAvailable: false,
//           option: question2Option,
//         ),
//         const SizedBox(height: 10,),
//         BenchMarkAchievementWidget(text: "Has the household achieved this benchmarks?", benchmarkOption: getOverallOption(question1Option: question1Option, question2Option: question2Option, question3Option: question3Option),),
//       ],
//     );
//   }
// }
//
//

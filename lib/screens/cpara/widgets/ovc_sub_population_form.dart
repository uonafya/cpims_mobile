import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/model/ovc_model.dart';
import 'package:cpims_mobile/screens/cpara/provider/cpara_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

import '../../../Models/case_load_model.dart';
import '../../../providers/connection_provider.dart';
import '../../../widgets/drawer.dart';

class CheckboxQuestion {
  final int? id;
  final String? question;
  final String? questionID;
  bool? isChecked;

  CheckboxQuestion(
      {required this.question,
      this.questionID,
      required this.id,
      this.isChecked = false});

  CheckboxQuestion copyWith(
      {int? id, String? question, String? questionID, bool? isChecked}) {
    return CheckboxQuestion(
        question: question ?? this.question,
        id: id ?? this.id,
        questionID: questionID ?? this.questionID,
        isChecked: isChecked ?? this.isChecked);
  }
}

class CheckboxForm extends StatefulWidget {
  final CaseLoadModel caseLoadModel;

  // final Function? onCheckboxSelected;

  const CheckboxForm({Key? key, required this.caseLoadModel}) : super(key: key);

  @override
  _CheckboxFormState createState() => _CheckboxFormState();
}

class _CheckboxFormState extends State<CheckboxForm> {
  DateTime? selectedDate;

  var dateOfAssesmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  List<CheckboxQuestion> questions = [
    CheckboxQuestion(id: 1, question: 'Orphan', questionID: "double"),
    CheckboxQuestion(id: 2, question: 'AGYW', questionID: "AGYW"),
    CheckboxQuestion(id: 3, question: 'HEI', questionID: "HEI"),
    CheckboxQuestion(id: 4, question: 'Child of FSW', questionID: "FSW"),
    CheckboxQuestion(id: 5, question: 'Child of PLHIV', questionID: "PLHIV"),
    CheckboxQuestion(id: 6, question: 'CLHIV', questionID: "CLHIV"),
    CheckboxQuestion(id: 7, question: 'SVAC', questionID: "SVAC"),
    CheckboxQuestion(
        id: 8, question: 'Household Affected by HIV', questionID: "AHIV"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const ReusableTitleText(title: "OVC Sub Population Form"),
              const SizedBox(height: 10),
              Text(
                  'Child Name: ${widget.caseLoadModel.ovcFirstName} ${widget.caseLoadModel.ovcSurname}'),
              const SizedBox(height: 10),
              Text('OVC CPIMS ID: ${widget.caseLoadModel.cpimsId}'),
              for (var question in questions)
                Row(
                  // Use Row instead of Column
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child:
                            ReusableTitleText(title: question.question ?? "")),
                    Checkbox(
                      value: question.isChecked,
                      onChanged: (value) {
                        setState(() {
                          question.isChecked = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              const SizedBox(height: 15),
              // DateTextField(
              //   label: 'Date of Assessment',
              //   enabled: true,
              //   onDateSelected: (date) {
              //     print('Date selected: $date');
              //     setState(() {
              //       selectedDate = date;
              //     });
              //   },
              //   identifier: DateTextFieldIdentifier.dateOfAssessment,
              // ),
              const SizedBox(height: 15),
              CustomButton(
                text: "Submit",
                onTap: () {
                  handleSubmit(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleSubmit(BuildContext context) async {
    final localDb = LocalDb.instance;
    final hasConnection = await Provider.of<ConnectivityProvider>(
      context,
      listen: false,
    ).checkInternetConnection();

    final currentContext = context; // Store the context in a local variable

    List<CheckboxQuestion> selectedQuestions = [];
    for (var question in questions) {
      if (question.isChecked!) {
        selectedQuestions.add(question);
      }
    }
    try {
      String uuid = const Uuid().v4();
      String? dateOfAssessment = selectedDate != null
          ? DateFormat('yyyy-MM-dd').format(selectedDate!)
          : null;
      await localDb.insertOvcSubpopulationData(uuid,
          widget.caseLoadModel.cpimsId!, dateOfAssessment!, selectedQuestions);
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (error) {
      if (currentContext.mounted) {
        showDialog(
          context: currentContext, // Use the local context
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('An error occurred: $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
}

class OvcOverallForm extends StatefulWidget {
  const OvcOverallForm({super.key});

  @override
  State<OvcOverallForm> createState() => _OvcOverallFormState();
}

class _OvcOverallFormState extends State<OvcOverallForm> {
  late List<CparaOvcChild> children;

  @override
  void initState() {
    super.initState();
    children = [];
    initializeCparaOvcQuestions();
  }

  void initializeCparaOvcQuestions() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CparaProvider>().updateCparaOvcQuestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CparaProvider>(builder: (context, model, _) {
      children = model.cparaOvcSubPopulation?.childrenQuestions ?? [];
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (int i = 0; i < children.length; i++)
            DottedBorder(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      children[i].name ?? "",
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Child Name',
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    OvcRowQuestion(
                        question: "Orphans (double or Child headed)?",
                        answer: children[i].answer1,
                        onValueChange: (value) {
                          CparaOvcSubPopulation ovcSub = context
                                  .read<CparaProvider>()
                                  .cparaOvcSubPopulation ??
                              CparaOvcSubPopulation();
                          List<CparaOvcChild> childrenQuestions = children;
                          childrenQuestions[i] = children[i]
                              .copyWith(answer1: value, question1: "double");
                          context.read<CparaProvider>().updateCparaOvcModel(
                              ovcSub.copyWith(
                                  childrenQuestions: childrenQuestions));
                        }),
                    OvcRowQuestion(
                        question:
                            "At Risk Adolescent Girls andYoung Women (AGYW)?",
                        answer: children[i].answer2,
                        onValueChange: (value) {
                          CparaOvcSubPopulation ovcSub = context
                                  .read<CparaProvider>()
                                  .cparaOvcSubPopulation ??
                              CparaOvcSubPopulation();
                          List<CparaOvcChild> childrenQuestions = children;
                          childrenQuestions[i] = children[i]
                              .copyWith(answer2: value, question2: "AGYW");
                          context.read<CparaProvider>().updateCparaOvcModel(
                              ovcSub.copyWith(
                                  childrenQuestions: childrenQuestions));
                          setState(() {});
                        }),
                    OvcRowQuestion(
                        question: "HEI?",
                        answer: children[i].answer3,
                        onValueChange: (value) {
                          CparaOvcSubPopulation ovcSub = context
                                  .read<CparaProvider>()
                                  .cparaOvcSubPopulation ??
                              CparaOvcSubPopulation();
                          List<CparaOvcChild> childrenQuestions = children;
                          childrenQuestions[i] = children[i]
                              .copyWith(answer3: value, question3: "HEI");
                          context.read<CparaProvider>().updateCparaOvcModel(
                              ovcSub.copyWith(
                                  childrenQuestions: childrenQuestions));
                          setState(() {});
                        }),
                    OvcRowQuestion(
                        question: "Children of Female Sex Workers (FSW)?*",
                        answer: children[i].answer4,
                        onValueChange: (value) {
                          CparaOvcSubPopulation ovcSub = context
                                  .read<CparaProvider>()
                                  .cparaOvcSubPopulation ??
                              CparaOvcSubPopulation();
                          List<CparaOvcChild> childrenQuestions = children;
                          childrenQuestions[i] = children[i]
                              .copyWith(answer4: value, question4: "FSW");
                          context.read<CparaProvider>().updateCparaOvcModel(
                              ovcSub.copyWith(
                                  childrenQuestions: childrenQuestions));
                        }),
                    OvcRowQuestion(
                        question:
                            "Children of People Living with HIV/AIDS (PLHIV)?",
                        answer: children[i].answer5,
                        onValueChange: (value) {
                          CparaOvcSubPopulation ovcSub = context
                                  .read<CparaProvider>()
                                  .cparaOvcSubPopulation ??
                              CparaOvcSubPopulation();
                          List<CparaOvcChild> childrenQuestions = children;
                          childrenQuestions[i] = children[i]
                              .copyWith(answer5: value, question5: "PLHIV");
                          context.read<CparaProvider>().updateCparaOvcModel(
                              ovcSub.copyWith(
                                  childrenQuestions: childrenQuestions));
                        }),
                    OvcRowQuestion(
                        question: "Children living with HIV/AIDS (CLHIV)?",
                        answer: children[i].answer6,
                        onValueChange: (value) {
                          CparaOvcSubPopulation ovcSub = context
                                  .read<CparaProvider>()
                                  .cparaOvcSubPopulation ??
                              CparaOvcSubPopulation();
                          List<CparaOvcChild> childrenQuestions = children;
                          childrenQuestions[i] = children[i]
                              .copyWith(answer6: value, question6: "CLHIV");
                          context.read<CparaProvider>().updateCparaOvcModel(
                              ovcSub.copyWith(
                                  childrenQuestions: childrenQuestions));
                        }),
                    OvcRowQuestion(
                        question: "Sexual violence against children (SVAC)?",
                        answer: children[i].answer7,
                        onValueChange: (value) {
                          CparaOvcSubPopulation ovcSub = context
                                  .read<CparaProvider>()
                                  .cparaOvcSubPopulation ??
                              CparaOvcSubPopulation();
                          List<CparaOvcChild> childrenQuestions = children;
                          childrenQuestions[i] = children[i]
                              .copyWith(answer7: value, question7: "SVAC");
                          context.read<CparaProvider>().updateCparaOvcModel(
                              ovcSub.copyWith(
                                  childrenQuestions: childrenQuestions));
                        }),
                    OvcRowQuestion(
                        question: "Household affected by HIV ?",
                        answer: children[i].answer8,
                        onValueChange: (value) {
                          CparaOvcSubPopulation ovcSub = context
                                  .read<CparaProvider>()
                                  .cparaOvcSubPopulation ??
                              CparaOvcSubPopulation();
                          List<CparaOvcChild> childrenQuestions = children;
                          childrenQuestions[i] = children[i]
                              .copyWith(answer8: value, question8: "AHIV");
                          context.read<CparaProvider>().updateCparaOvcModel(
                              ovcSub.copyWith(
                                  childrenQuestions: childrenQuestions));
                        }),
                  ],
                ),
              ),
            ),
        ],
      );
    });
  }
}

class OvcRowQuestion extends StatelessWidget {
  final bool? answer;
  final String question;
  final Function(bool?)? onValueChange;
  const OvcRowQuestion(
      {super.key, required this.question, this.answer, this.onValueChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: ReusableTitleText(title: question)),
        Checkbox(
          value: answer ?? false,
          onChanged: onValueChange,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

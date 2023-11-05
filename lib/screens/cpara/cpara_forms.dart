import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/cpara/model/cpara_model.dart';
import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/model/health_model.dart';
import 'package:cpims_mobile/screens/cpara/model/safe_model.dart';
import 'package:cpims_mobile/screens/cpara/model/schooled_model.dart';
import 'package:cpims_mobile/screens/cpara/model/stable_model.dart';
import 'package:cpims_mobile/screens/cpara/provider/cpara_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_healthy_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_safe_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_schooled_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_stable_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/ovc_sub_population_form.dart';
import 'package:cpims_mobile/screens/homepage/provider/stats_provider.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_stepper.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../Models/case_load_model.dart';
import '../../providers/connection_provider.dart';
import 'model/ovc_model.dart';

class CparaFormsScreen extends StatefulWidget {
  final CaseLoadModel caseLoadModel;

  const CparaFormsScreen({super.key, required this.caseLoadModel});

  @override
  State<CparaFormsScreen> createState() => _CparaFormsScreenState();
}

class _CparaFormsScreenState extends State<CparaFormsScreen> {
  final ScrollController _scrollController = ScrollController();
  int selectedStep = 0;

  List<Widget> steps = [
    const CparaDetailsWidget(),
    const CparaHealthyWidget(),
    const CparaStableWidget(),
    const CparaSafeWidget(),
    const CparaSchooledWidget(),
  ];

  Database? database;

  // Initialize database
  @override
  void initState() {
    super.initState();
    // final caseLoadData = Provider.of<UIProvider>(context, listen: false).caseLoadData;
    // todo: update case load data in Cpara provider
    // fetchChildren(caseLoadData);
  }

  Future<void> initializeDbInstance() async {
    database = await LocalDb.instance.database;
    if (mounted) setState(() {});
  }

  fetchChildren(caseList) async {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CparaProvider>().updateChildren(caseList);
    });
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
      body: ListView(
        controller: _scrollController, // Assign the ScrollController
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ]),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    color: Colors.black,
                    child: Text(
                      'Case Plan Achievement Readiness Assessment \n ${widget.caseLoadModel.caregiverNames}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        CustomStepperWidget(
                          onTap: (index) {
                            setState(() {
                              selectedStep = index;
                            });
                          },
                          data: cparaStepperData,
                          selectedIndex: selectedStep,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        steps[selectedStep],
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: selectedStep <= 0 ? 'Cancel' : 'Previous',
                                onTap: () {
                                  if (selectedStep == 0) {
                                    Navigator.pop(context);
                                    context
                                        .read<CparaProvider>()
                                        .clearCparaProvider();

                                  }
                                  _scrollController.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.easeInOut,
                                  );
                                  setState(() {
                                    if (selectedStep > 0) {
                                      selectedStep--;
                                    }
                                  });
                                },
                                color: kTextGrey,
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Expanded(
                              child: CustomButton(
                                text: selectedStep == steps.length - 1
                                    ? 'Submit'
                                    : 'Next',
                                onTap: () async {
                                  if (selectedStep == steps.length - 1) {
                                    // display collected data
                                    DetailModel detailModel = context
                                            .read<CparaProvider>()
                                            .detailModel ??
                                        DetailModel();
                                    HealthModel healthModel = context
                                            .read<CparaProvider>()
                                            .healthModel ??
                                        HealthModel();
                                    // context.read<CparaProvider>().updateHealthModel((healthModel ?? HealthModel()
                                    //     ));
                                    StableModel stableModel = context
                                            .read<CparaProvider>()
                                            .stableModel ??
                                        StableModel();
                                    SafeModel safeModel = context
                                            .read<CparaProvider>()
                                            .safeModel ??
                                        SafeModel();
                                    SchooledModel schooledModel = context
                                            .read<CparaProvider>()
                                            .schooledModel ??
                                        SchooledModel();

                                    // number of children
                                    List<CaseLoadModel> children =
                                        context.read<CparaProvider>().children;

                                    if (safeModel.childrenQuestions == null) {
                                      List<SafeChild> childrenQuestions = [];
                                      for (int i = 0;
                                          i < children.length;
                                          i++) {
                                        childrenQuestions.add(SafeChild(
                                            question1: null,
                                            ovcId: "${children[i].cpimsId}",
                                            name:
                                                "${children[i].ovcFirstName} ${children[i].ovcSurname}"));
                                      }

                                      safeModel = safeModel.copyWith(
                                          childrenQuestions: childrenQuestions);
                                      context
                                          .read<CparaProvider>()
                                          .updateSafeModel(safeModel);
                                    }

                                    if (healthModel.childrenQuestions == null) {
                                      List<HealthChild> childrenQuestions = [];
                                      for (int i = 0;
                                          i < children.length;
                                          i++) {
                                        childrenQuestions.add(HealthChild(
                                            question1: "",
                                            question2: '',
                                            question3: '',
                                            id: "${children[i].cpimsId}",
                                            name:
                                                "${children[i].ovcFirstName} ${children[i].ovcSurname}"));
                                      }
                                      healthModel = healthModel.copyWith(
                                          childrenQuestions: childrenQuestions);
                                      context
                                          .read<CparaProvider>()
                                          .updateHealthModel(healthModel);
                                    }

                                    CparaModel? cparaModel = context
                                        .read<CparaProvider>()
                                        .cparaModel;

                                    try {
                                      String? ovsId = context
                                          .read<CparaProvider>()
                                          .caseLoadModel
                                          ?.cpimsId;

                                      if (ovsId == null) {
                                        throw ("No CPMSID found");
                                      }
                                      String ovcpmisid = ovsId;
                                      // Insert to db
                                      CparaModel cparaModelDB = CparaModel(
                                        detail: detailModel,
                                        safe: safeModel,
                                        stable: stableModel,
                                        schooled: schooledModel,
                                        health: (healthModel),
                                      );
                                      // Create form
                                      await LocalDb.instance.insertCparaData(
                                          cparaModelDB: cparaModelDB,
                                          ovcId: ovcpmisid,
                                          careProviderId: ovcpmisid);
                                      //todo: call ovc
                                      // if(context.mounted){
                                      //   DateTime? date = DateTime.tryParse(detailModel.dateOfAssessment ?? "");
                                      //   handleSubmit(context: context, selectedDate: date ?? DateTime.now());
                                      // }

                                      if (context.mounted) {
                                        context
                                            .read<CparaProvider>()
                                            .clearCparaProvider();
                                        context
                                            .read<StatsProvider>()
                                            .updateCparaFormStats();
                                       //navigate back
                                        Get.snackbar(
                                          'Success',
                                          'Successfully saved CPARA form',
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white,
                                        );
                                        Navigator.pop(context);
                                      }
                                    } catch (err) {
                                      Get.snackbar(
                                        'Success',
                                        'Successfully saved CPARA form',
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                    }
                                  }

                                  _scrollController.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.easeInOut,
                                  );
                                  setState(() {
                                    if (selectedStep < steps.length - 1) {
                                      selectedStep++;
                                    }
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 20),
          const Footer(),
        ],
      ),
    );
  }

  void handleSubmit({required BuildContext context, required DateTime? selectedDate}) async {
    CparaOvcSubPopulation ovcSub =
        context.read<CparaProvider>().cparaOvcSubPopulation ?? CparaOvcSubPopulation();
    final localDb = LocalDb.instance;
    List<CparaOvcChild> listOfOvcChild = ovcSub.childrenQuestions ?? [];

    final currentContext = context; // Store the context in a local variable

    try {
      for(var child in listOfOvcChild){
        List<CheckboxQuestion> selectedQuestions = [];
            selectedQuestions.add(CheckboxQuestion(question: "question", id: 0, questionID: child.question1 ?? "double", isChecked: child.answer1 ?? false));
        selectedQuestions.add(CheckboxQuestion(question: "question", id: 0, questionID: child.question2 ?? "AGYW", isChecked: child.answer2 ?? false));
        selectedQuestions.add(CheckboxQuestion(question: "question", id: 0, questionID: child.question3 ?? "HEI", isChecked: child.answer3 ?? false));
        selectedQuestions.add(CheckboxQuestion(question: "question", id: 0, questionID: child.question4 ?? "FSW", isChecked: child.answer4 ?? false));
        selectedQuestions.add(CheckboxQuestion(question: "question", id: 0, questionID: child.question5 ?? "PLHIV", isChecked: child.answer5 ?? false));
        selectedQuestions.add(CheckboxQuestion(question: "question", id: 0, questionID: child.question6 ?? "CLHIV", isChecked: child.answer6 ?? false));
        selectedQuestions.add(CheckboxQuestion(question: "question", id: 0, questionID: child.question7 ?? "SVAC", isChecked: child.answer7 ?? false));
        selectedQuestions.add(CheckboxQuestion(question: "question", id: 0, questionID: child.question8 ?? "AHIV", isChecked: child.answer8 ?? false));

        String uuid = const Uuid().v4();
        String? dateOfAssessment = selectedDate != null
            ? DateFormat('yyyy-MM-dd').format(selectedDate)
            : null;
        await localDb.insertOvcSubpopulationData(uuid,
            widget.caseLoadModel.cpimsId!, dateOfAssessment!, selectedQuestions);
      }
      // if(mounted) {
      //   Navigator.pop(context);
      // }
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

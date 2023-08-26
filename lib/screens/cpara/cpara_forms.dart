import 'package:cpims_mobile/constants.dart';
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
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_stepper.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import '../../Models/case_load_model.dart';

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
  static const databaseName = "CPARAv2.db";

  // Initialize database
  @override
  void initState() {
    super.initState();
    context.read<CparaProvider>().caseLoadModel = widget.caseLoadModel;
    // initialize the database
    initializeDatabase();
  }

  // Function that creates the database and tables
  void initializeDatabase() async {
    try {
      debugPrint("This has been created");
      database =
          await openDatabase(p.join(await getDatabasesPath(), databaseName),
              onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE IF NOT EXISTS Form(id INTEGER PRIMARY KEY, date TEXT);");
        await db.execute(
            "CREATE TABLE IF NOT EXISTS Child(childOVCCPMISID TEXT PRIMARY KEY, childName TEXT, childAge TEXT, childGender TEXT, childSchool TEXT, childOVCRegistered TEXT);");
        await db.execute(
            "CREATE TABLE IF NOT EXISTS Household(householdID TEXT PRIMARY KEY);");
        await db.execute(
            "CREATE TABLE IF NOT EXISTS HouseholdChild(childID TEXT, householdID TEXT, FOREIGN KEY (childID) REFERENCES Child(childovccpmisid), FOREIGN KEY (householdID) REFERENCES Household(householdID), PRIMARY KEY(childID, householdID));");
        await db.execute(
            "CREATE TABLE IF NOT EXISTS HouseholdAnswer(formID INTEGER, id INTEGER PRIMARY KEY, houseHoldID TEXT, questionID TEXT, answer TEXT, FOREIGN KEY (houseHoldID) REFERENCES Household(householdid), FOREIGN KEY (formID) REFERENCES Form(id));");
        await db.execute(
            "CREATE TABLE IF NOT EXISTS ChildAnswer(formID INTEGER, id INTEGER PRIMARY KEY, childID TEXT, questionid TEXT, answer TEXT, FOREIGN KEY (childID) REFERENCES Child(childovccpmisid), FOREIGN KEY (formID) REFERENCES Form(id));");
      }, version: 2);
    } catch (err) {
      debugPrint("OHH SHIT!");
      debugPrint(err.toString());
      debugPrint("OHH SHIT");
    }
  }

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
                      'Case Plan Achievement Readiness Assessment || ${widget.caseLoadModel.caregiverNames}',
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
                                  }
                                  _scrollController.animateTo(
                                    0,
                                    duration: Duration(milliseconds: 500),
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
                                onTap: () {
                                  if (selectedStep == steps.length - 1) {
                                    // display collected data
                                    DetailModel? detailModel = context
                                        .read<CparaProvider>()
                                        .detailModel;
                                    HealthModel? healthModel = context
                                        .read<CparaProvider>()
                                        .healthModel;
                                    StableModel? stableModel = context
                                        .read<CparaProvider>()
                                        .stableModel;
                                    SafeModel? safeModel =
                                        context.read<CparaProvider>().safeModel;
                                    SchooledModel? schooledModel = context
                                        .read<CparaProvider>()
                                        .schooledModel;
                                    CparaModel? cparaModel = context
                                        .read<CparaProvider>()
                                        .cparaModel;

                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              title:
                                                  const Text('Collected Data'),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text("Stable Model:"),
                                                    Row(
                                                      children: [
                                                        Text("Question: 1"),
                                                        Text(
                                                            "Answer: ${stableModel?.question1}"),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            "Question: 2"),
                                                        Text(
                                                            " || Answer: ${stableModel?.question2}"),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            "Question: 3"),
                                                        Text(
                                                            " || Answer: ${stableModel?.question3}"),
                                                      ],
                                                    ),

                                                    // Health Model
                                                    HealthModelCollected(),
                                                    const Text("Safe Model:"),
                                                    Row(
                                                      children: [
                                                        Text("Question: 1"),
                                                        Text(
                                                            "Answer: ${safeModel?.question1}"),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            "Question: 2"),
                                                        Text(
                                                            " || Answer: ${stableModel?.question2}"),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            "Question: 3"),
                                                        Text(
                                                            " || Answer: ${stableModel?.question3}"),
                                                      ],
                                                    ),
                                                    const Text("Detail model:"),
                                                    const Text("Detail model:"),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Date of Assessment'),
                                                        Text(
                                                            'Answer: ${detailModel?.dateOfAssessment}'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Is this first case plan readiness assessment?'),
                                                        Text(
                                                            'Answer: ${detailModel?.isFirstAssessment}'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Date of Previous Assessment'),
                                                        Text(
                                                            'Answer: ${detailModel?.dateOfLastAssessment}'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Is the child headed household?'),
                                                        Text(
                                                            'Answer: ${detailModel?.isChildHeaded}'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Does the child have an HIV exposed infant?'),
                                                        Text(
                                                            'Answer: ${detailModel?.hasHivExposedInfant}'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Does this HH currently have a pregnant and/or breastfeeding woman/adolescent?'),
                                                        Text(
                                                            'Answer: ${detailModel?.hasPregnantOrBreastfeedingWoman}'),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                    const Text(
                                                        "OVC Sub Population Form"),
                                                    const SizedBox(height: 10),
                                                  ],
                                                ),
                                              ),
                                            ));

                                    try {
                                      String ovcpmisid = "1573288";
                                      // Insert to db
                                      CparaModel cparaModelDB = CparaModel(
                                          detail: detailModel ?? DetailModel(),
                                          safe: safeModel ?? SafeModel(),
                                          stable: stableModel ?? StableModel(),
                                          schooled: schooledModel ??
                                              SchooledModel(
                                                  question1: "",
                                                  question2: "question2",
                                                  question3: "question3",
                                                  question4: "question4"),
                                          health: healthModel ?? HealthModel(),
                                          ovcSubPopulationModel: OvcSubPopulationModel());

                                      // Create form
                                      cparaModelDB
                                          .createForm(database)
                                          .then((value) {
                                        // Get formID
                                        cparaModelDB
                                            .getLatestFormID(database)
                                            .then((formData) {
                                          var formDate = formData.formDate;
                                          var formDateString =
                                              formDate.toString().split(' ')[0];
                                          var formID = formData.formID;
                                          cparaModelDB
                                              .addHouseholdFilledQuestionsToDB(
                                                  database,
                                                  "Test House",
                                                  formDateString,
                                                  ovcpmisid,
                                                  formID);
                                        });
                                      });
                                    } catch (err) {
                                      debugPrint("OHH SHIT!");
                                      debugPrint(err.toString());
                                      debugPrint("OHH SHIT");
                                    }
                                  }

                                  _scrollController.animateTo(
                                    0,
                                    duration: Duration(milliseconds: 500),
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
          const PastCPARAWidget(),
          const Footer(),
        ],
      ),
    );
  }
}

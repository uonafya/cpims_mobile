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
import 'package:cpims_mobile/screens/cpara/provider/db_util.dart';
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
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
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
    final caseLoadData = Provider.of<UIProvider>(context, listen: false).caseLoadData;
    // todo: update case load data in Cpara provider
    // initialize the database
    // initializeDatabase();
    // initializeDbInstance();
    fetchChildren(caseLoadData);
  }

  Future<void> initializeDbInstance() async {
    database = await LocalDb.instance.database;
    if(mounted) setState(() {});
  }

  fetchChildren(caseList) async{
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // Provider.of<CparaProvider>(context, listen: false).updateChildren(caseList));
    context.read<CparaProvider>().updateChildren(caseList);
    });
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
                                onTap: () async{
                                  if (selectedStep == steps.length - 1) {
                                    // display collected data
                                    DetailModel? detailModel = context
                                        .read<CparaProvider>()
                                        .detailModel;
                                    HealthModel? healthModel = context
                                        .read<CparaProvider>()
                                        .healthModel;
                                    // context.read<CparaProvider>().updateHealthModel((healthModel ?? HealthModel()
                                    //     ));
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

                                    // showDialog(
                                    //   context: context,
                                    //   builder: (_) => AlertDialog(
                                    //     backgroundColor: Colors.white,
                                    //     title: const Text(
                                    //       'CPARA Form Collected Data',
                                    //       style: TextStyle(
                                    //         color: Colors.blue,
                                    //         fontSize: 20,
                                    //         fontWeight: FontWeight.bold,
                                    //       ),
                                    //     ),
                                    //     content: SingleChildScrollView(
                                    //       child: Column(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment.start,
                                    //         children: [
                                    //           const Text(
                                    //             "Stable Model:",
                                    //             style: TextStyle(
                                    //               color: Colors.blue,
                                    //               fontSize: 30.0,
                                    //               fontWeight: FontWeight.w800,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           const Text(
                                    //             "Question: 1",
                                    //             style: TextStyle(
                                    //               color: Colors.blue,
                                    //               fontSize: 18.0,
                                    //               fontStyle: FontStyle.italic,
                                    //               fontWeight: FontWeight.w800,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           Text(
                                    //             "Answer: ${stableModel?.question1}",
                                    //             style: const TextStyle(
                                    //               color: Colors.black,
                                    //               fontSize: 18.0,
                                    //               fontWeight: FontWeight.w400,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           const Text(
                                    //             "Question: 2",
                                    //             style: TextStyle(
                                    //               color: Colors.blue,
                                    //               fontSize: 18.0,
                                    //               fontStyle: FontStyle.italic,
                                    //               fontWeight: FontWeight.w800,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           Text(
                                    //             "Answer: ${stableModel?.question2}",
                                    //             style: const TextStyle(
                                    //               color: Colors.black,
                                    //               fontSize: 18.0,
                                    //               fontWeight: FontWeight.w400,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           const Text(
                                    //             "Question: 3",
                                    //             style: TextStyle(
                                    //               color: Colors.blue,
                                    //               fontSize: 18.0,
                                    //               fontStyle: FontStyle.italic,
                                    //               fontWeight: FontWeight.w800,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           Text(
                                    //             "Answer: ${stableModel?.question3}",
                                    //             style: const TextStyle(
                                    //               color: Colors.black,
                                    //               fontSize: 18.0,
                                    //               fontWeight: FontWeight.w400,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //
                                    //           // Health Model
                                    //           const HealthModelCollected(),
                                    //           // Safe model
                                    //           const Text(
                                    //             "Safe Model:",
                                    //             style: TextStyle(
                                    //               color: Colors.blue,
                                    //               fontSize: 30.0,
                                    //               fontWeight: FontWeight.w800,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           const Text(
                                    //             "Question: 1",
                                    //             style: TextStyle(
                                    //               color: Colors.blue,
                                    //               fontSize: 18.0,
                                    //               fontStyle: FontStyle.italic,
                                    //               fontWeight: FontWeight.w800,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           Text(
                                    //             "Answer: ${safeModel?.question1}",
                                    //             style: const TextStyle(
                                    //               color: Colors.black,
                                    //               fontSize: 18.0,
                                    //               fontWeight: FontWeight.w400,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           const Text(
                                    //             "Question: 2",
                                    //             style: TextStyle(
                                    //               color: Colors.blue,
                                    //               fontSize: 18.0,
                                    //               fontStyle: FontStyle.italic,
                                    //               fontWeight: FontWeight.w800,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           Text(
                                    //             "Answer: ${stableModel?.question2}",
                                    //             style: const TextStyle(
                                    //               color: Colors.black,
                                    //               fontSize: 18.0,
                                    //               fontWeight: FontWeight.w400,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           const Text(
                                    //             "Question: 3",
                                    //             style: TextStyle(
                                    //               color: Colors.blue,
                                    //               fontSize: 18.0,
                                    //               fontStyle: FontStyle.italic,
                                    //               fontWeight: FontWeight.w800,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           Text(
                                    //             "Answer: ${stableModel?.question3}",
                                    //             style: const TextStyle(
                                    //               color: Colors.black,
                                    //               fontSize: 18.0,
                                    //               fontWeight: FontWeight.w400,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           const Text("Detail model:",
                                    //             style: TextStyle(
                                    //               color: Colors.blue,
                                    //               fontSize: 30.0,
                                    //               fontWeight: FontWeight.w800,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),),
                                    //
                                    //           const Text(
                                    //             'Date of Assessment',
                                    //             style: TextStyle(
                                    //               color: Colors.blue,
                                    //               fontSize: 18.0,
                                    //               fontStyle: FontStyle.italic,
                                    //               fontWeight: FontWeight.w800,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           Text(
                                    //             'Answer: ${detailModel?.dateOfAssessment}',
                                    //             style: const TextStyle(
                                    //               color: Colors.black,
                                    //               fontSize: 18.0,
                                    //               fontWeight: FontWeight.w400,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //
                                    //           const Text(
                                    //             'Is this first case plan readiness assessment?',
                                    //             style: TextStyle(
                                    //               color: Colors.blue,
                                    //               fontSize: 18.0,
                                    //               fontStyle: FontStyle.italic,
                                    //               fontWeight: FontWeight.w800,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           Text(
                                    //             'Answer: ${detailModel?.isFirstAssessment}',
                                    //             style: const TextStyle(
                                    //               color: Colors.black,
                                    //               fontSize: 18.0,
                                    //               fontWeight: FontWeight.w400,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           const Text(
                                    //             'Date of Previous Assessment',
                                    //             style: TextStyle(
                                    //               color: Colors.blue,
                                    //               fontSize: 18.0,
                                    //               fontStyle: FontStyle.italic,
                                    //               fontWeight: FontWeight.w800,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           Text(
                                    //             'Answer: ${detailModel?.dateOfLastAssessment}',
                                    //             style: const TextStyle(
                                    //               color: Colors.black,
                                    //               fontSize: 18.0,
                                    //               fontWeight: FontWeight.w400,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           const Text(
                                    //             'Is the child headed household?',
                                    //             style: TextStyle(
                                    //               color: Colors.blue,
                                    //               fontSize: 18.0,
                                    //               fontStyle: FontStyle.italic,
                                    //               fontWeight: FontWeight.w800,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           Text(
                                    //             'Answer: ${detailModel?.isChildHeaded}',
                                    //             style: const TextStyle(
                                    //               color: Colors.black,
                                    //               fontSize: 18.0,
                                    //               fontWeight: FontWeight.w400,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //
                                    //           const Text(
                                    //             'Does the child have an HIV exposed infant?',
                                    //             style: TextStyle(
                                    //               color: Colors.blue,
                                    //               fontSize: 18.0,
                                    //               fontStyle: FontStyle.italic,
                                    //               fontWeight: FontWeight.w800,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           Text(
                                    //             'Answer: ${detailModel?.hasHivExposedInfant}',
                                    //             style: const TextStyle(
                                    //               color: Colors.black,
                                    //               fontSize: 18.0,
                                    //               fontWeight: FontWeight.w400,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //
                                    //           const Text(
                                    //             'Does this HH currently have a pregnant and/or breastfeeding woman/adolescent?',
                                    //             style: TextStyle(
                                    //               color: Colors.blue,
                                    //               fontSize: 18.0,
                                    //               fontStyle: FontStyle.italic,
                                    //               fontWeight: FontWeight.w800,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //           Text(
                                    //             'Answer: ${detailModel?.hasPregnantOrBreastfeedingWoman}',
                                    //             style: const TextStyle(
                                    //               color: Colors.black,
                                    //               fontSize: 18.0,
                                    //               fontWeight: FontWeight.w400,
                                    //               letterSpacing: 0.1,
                                    //               height: 1.5,
                                    //             ),
                                    //           ),
                                    //
                                    //           const SizedBox(height: 20),
                                    //           const SizedBox(height: 10),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ),
                                    // );

                                    try {
                                      String? ovsId = context.read<CparaProvider>().caseLoadModel?.cpimsId;
                                      // String? careGiverId = context.read<CparaProvider>().caseLoadModel?.cpimsId;

                                      if(ovsId == null) throw("No CPMSID found");
                                      String ovcpmisid = ovsId ?? "0" ;
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
                                          health: (healthModel ?? HealthModel()
                                          // ).copyWith(childrenQuestions: [
                                          //   HealthChild(question1: "No", question2: "Yes",question3: "No", id: "35273283", name: "Okello Enos"),
                                          //   HealthChild(question1: "Yes", question2: "No",question3: "No", id: "0716229563", name: "Nakato Sarah"),
                                          //   HealthChild(question1: "Yes", question2: "Yes",question3: "No", id: "2012593", name: "LUCAS OWUOR"),
                                          // ]
                                          ),
                                          // ovcSubPopulationModel:
                                          //     OvcSubPopulationModel()
                                              );
                                      // Create form
                                      await LocalDb.instance.insertCparaData(cparaModelDB: cparaModelDB, ovcId: ovcpmisid, careProviderId: ovcpmisid );
// if(!context.mounted)
                                      if (context.mounted) {
                                        context.read<CparaProvider>().clearCparaProvider();
                                        showDialog(
                                          context: context, // Use the context from the build method
                                          builder: (context) =>
                                              AlertDialog(
                                                title: const Text('Success'),
                                                content: const Text(
                                                    'CPARA data saved successfully.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Get.back(); // Close the dialog
                                                      Get.back(); // Go back to the previous screen
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ),
                                        );
                                      }
                                    } catch (err) {
                                      debugPrint("OHH SHIT!");
                                      debugPrint(err.toString());
                                      debugPrint("OHH SHIT");
                                    }
                                  }
                                  // else{
                                  //   var form = await getUnsynchedForms(await LocalDb.instance.database);
                                  //   print(form);
                                  // }

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
          const PastCPARAWidget(),
          const Footer(),
        ],
      ),
    );
  }
}

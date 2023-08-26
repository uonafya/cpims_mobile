
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/provider/cpara_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

import '../../../Models/case_load_model.dart';
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
}

class CheckboxForm extends StatefulWidget {
  final CaseLoadModel caseLoadModel;


  // final Function? onCheckboxSelected;

  const CheckboxForm({Key? key, required this.caseLoadModel
  }) : super(key: key);

  @override
  _CheckboxFormState createState() => _CheckboxFormState();


}

class _CheckboxFormState extends State<CheckboxForm> {

  @override
  void initState() {
    super.initState();
    // DetailModel detailModel= context.read<CparaProvider>().detailModel?? DetailModel();
    // DetailModel detailModel= Provider.of<CparaProvider>(context, listen: false).detailModel?? DetailModel();
  }

  List<CheckboxQuestion> questions = [
    CheckboxQuestion(id: 1, question: 'Orphan', questionID: "Orphan"),
    CheckboxQuestion(id: 2, question: 'AGYW', questionID: "AGYW"),
    CheckboxQuestion(id: 3, question: 'HEI', questionID: "HEI"),
    CheckboxQuestion(id: 4, question: 'Child of FSW', questionID: "FSW"),
    CheckboxQuestion(id: 5, question: 'Child of PLHIV', questionID: "PLHIV"),
    CheckboxQuestion(id: 6, question: 'CLHIV', questionID: "CLHIV"),
    CheckboxQuestion(id: 7, question: 'SVAC', questionID: "SVAC"),
    CheckboxQuestion(
        id: 8, question: 'Household Affected by HIV', questionID: "HHIV"),
  ];

  @override
  Widget build(BuildContext context) {
    DetailModel detailModel= Provider.of<CparaProvider>(context, listen: false).detailModel?? DetailModel();
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
              CustomButton(
                text: "Submit",
                onTap: () {
                  handleSubmit();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleSubmit() async {
    final localDb = LocalDb.instance;

    List<CheckboxQuestion> selectedQuestions = [];
    for (var question in questions) {
      if (question.isChecked!) {
        selectedQuestions.add(question);
      }
    }
    final context = this.context; // Store the context

    try {
      // Save OVC prepopulation data without specifying formId
      String uuid = const Uuid().v4();
      String dateOfAssessment = Provider.of<CparaProvider>(context, listen: false).detailModel?.dateOfAssessment ?? "NULL";
      await localDb.insertOvcSubpopulationData(
          uuid, widget.caseLoadModel.cpimsId!,dateOfAssessment,selectedQuestions);

      // Show success dialog if the context is still mounted
      if (context.mounted) {
        showDialog(
          context: context, // Use the context from the build method
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('OVC Sub-Population data saved successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                  Get.back(); // Go back to the previous screen
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      print('Error saving OVC Sub-Population data: $error');
    }
  }
}

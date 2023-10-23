import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/provider/cpara_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

import '../../../Models/case_load_model.dart';
import '../../../providers/connection_provider.dart';
import '../../../widgets/drawer.dart';
import '../provider/db_util.dart';

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

  const CheckboxForm({Key? key, required this.caseLoadModel}) : super(key: key);

  @override
  _CheckboxFormState createState() => _CheckboxFormState();
}

class _CheckboxFormState extends State<CheckboxForm> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
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
              DateTextField(
                label: 'Date of Assessment',
                enabled: true,
                onDateSelected: (date) {
                  print('Date selected: $date');
                  setState(() {
                    selectedDate = date;
                  });
                },
                identifier: DateTextFieldIdentifier.dateOfAssessment,
              ),
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
      if (currentContext.mounted) {
        showDialog(
          context: currentContext, // Use the local context
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('OVC Sub-Population data saved successfully.'),
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
    } catch (error) {
      // Show error dialog if the context is still mounted
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

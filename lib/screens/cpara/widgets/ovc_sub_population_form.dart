import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import '../../../Models/case_load_model.dart';
import '../../../widgets/drawer.dart';

class CheckboxQuestion {
  final int? id;
  final String? question;
  bool? isChecked;

  CheckboxQuestion(
      {required this.question, required this.id, this.isChecked = false});
}

class CheckboxForm extends StatefulWidget {
  final CaseLoadModel caseLoadModel;

  // final Function? onCheckboxSelected;

  const CheckboxForm({Key? key, required this.caseLoadModel}) : super(key: key);

  @override
  _CheckboxFormState createState() => _CheckboxFormState();
}

class _CheckboxFormState extends State<CheckboxForm> {
  List<CheckboxQuestion> questions = [
    CheckboxQuestion(id: 1, question: 'Orphan'),
    CheckboxQuestion(id: 2, question: 'AGYW'),
    CheckboxQuestion(id: 3, question: 'HEI'),
    CheckboxQuestion(id: 4, question: 'FSW Child'),
    CheckboxQuestion(id: 5, question: 'PLHIV Child'),
    CheckboxQuestion(id: 6, question: 'CLHIV'),
    CheckboxQuestion(id: 7, question: 'SVAC'),
    CheckboxQuestion(id: 8, question: 'Household Affected by HIV'),
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
          padding: const EdgeInsets.all(8.0),
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
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    handleSubmit();
                  },
                  child: const Text("Submit", style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleSubmit() {
    for (var question in questions) {
      int value = question.isChecked! ? 1 : 0;
      print('Question ID: ${question.id}, Value: $value');
    }
  }
}

import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:flutter/material.dart';

class CheckboxQuestion {
  final String question;
  bool isChecked;

  CheckboxQuestion({required this.question, this.isChecked = false});
}

class CheckboxForm extends StatefulWidget {
  const CheckboxForm({Key? key}) : super(key: key);

  @override
  _CheckboxFormState createState() => _CheckboxFormState();
}

class _CheckboxFormState extends State<CheckboxForm> {
  List<CheckboxQuestion> questions = [
    CheckboxQuestion(question: 'Orphan'),
    CheckboxQuestion(question: 'AGYW'),
    CheckboxQuestion(question: 'HEI'),
    CheckboxQuestion(question: 'FSW Child'),
    CheckboxQuestion(question: 'PLHIV Child'),
    CheckboxQuestion(question: 'CLHIV'),
    CheckboxQuestion(question: 'SVAC'),
    CheckboxQuestion(question: 'Household Affected by HIV'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ReusableTitleText(title: "OVC Sub Population Form"),
        for (var question in questions)
          Row( // Use Row instead of Column
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                question.question,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Checkbox(
                value: question.isChecked,
                onChanged: (value) {
                  setState(() {
                    question.isChecked = value!;
                  });
                },
              ),
            ],
          ),
      ],
    );
  }
}

import 'package:cpims_mobile/screens/cpara/widgets/cpara_details_widget.dart';
import 'package:flutter/material.dart';

class CheckboxQuestion {
  final int? id;
  final String? question;
  bool? isChecked;

  CheckboxQuestion(
      {required this.question, required this.id, this.isChecked = false});
}

class CheckboxForm extends StatefulWidget {
  final String childName;
  final String ovcCpimsId;

  final Function? onCheckboxSelected;

  const CheckboxForm(
      {Key? key,
      required this.childName,
      required this.ovcCpimsId,
      required this.onCheckboxSelected})
      : super(key: key);

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
    return Column(
      children: [
        const ReusableTitleText(title: "OVC Sub Population Form"),
        const SizedBox(height: 10),
        Text('Child Name: ${widget.childName}'),
        const SizedBox(height: 10),
        Text('OVC CPIMS ID: ${widget.ovcCpimsId}'),
        for (var question in questions)
          Row(
            // Use Row instead of Column
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: ReusableTitleText(title: question.question ?? "")),
              Checkbox(
                value: question.isChecked,
                onChanged: (value) {
                  setState(() {
                    question.isChecked = value!;
                    widget.onCheckboxSelected!(question.id);
                  });
                },
              ),
              const SizedBox(height: 10),
              //elevated button
            ],
          ),
      ],
    );
  }
}

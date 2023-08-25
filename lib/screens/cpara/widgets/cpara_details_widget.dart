import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/provider/cpara_provider.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_stable_widget.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../registry/organisation_units/widgets/steps_wrapper.dart';

class CparaDetailsWidget extends StatefulWidget {
  const CparaDetailsWidget({super.key});

  @override
  State<StatefulWidget> createState() => _CparaDetailsWidgetState();
}

class _CparaDetailsWidgetState extends State<CparaDetailsWidget> {
  RadioButtonOptions? selected;
  RadioButtonOptions? isFirstAssessment;
  RadioButtonOptions? isChildHeaded;
  RadioButtonOptions? hasHivExposedInfant;
  RadioButtonOptions? hasPregnantOrBreastfeedingWoman;

  final List<ChildDetails> children = [
    ChildDetails(
      name: 'John Doe',
      age: 10,
      gender: 'Male',
      uniqueNumber: '123456789',
      schoolLevel: 'Primary',
      registeredInProgram: true,
    ),
    ChildDetails(
      name: 'Jane Doe',
      age: 8,
      gender: 'Female',
      uniqueNumber: '987654321',
      schoolLevel: 'Kindergarten',
      registeredInProgram: false,
    ),
  ];

  @override
  void initState(){
    DetailModel detailModel = context.read<CparaProvider>().detailModel ?? DetailModel();
    isFirstAssessment = detailModel.isFirstAssessment == null ? isFirstAssessment : convertingStringToRadioButtonOptions(detailModel.isFirstAssessment!);
    isChildHeaded = detailModel.isChildHeaded == null ? isChildHeaded : convertingStringToRadioButtonOptions(detailModel.isChildHeaded!);
    hasHivExposedInfant = detailModel.hasHivExposedInfant == null ? hasHivExposedInfant : convertingStringToRadioButtonOptions(detailModel.hasHivExposedInfant!);
    // dateOfAssessment = detailModel.dateOfAssessment == null ? dateOfAssessment : DateTime.parse(detailModel.dateOfAssessment!);
    // dateOfLastAssessment = detailModel.dateOfLastAssessment == null ? dateOfLastAssessment : DateTime.parse(detailModel.dateOfLastAssessment!);
    super.initState();
  }

  void _getDataAndMoveToNext() {
    print('Is first assessment: $isFirstAssessment');
    print('Is child headed: $isChildHeaded');
    print('Has HIV exposed infant: $hasHivExposedInfant');
    print(
        'Has pregnant or breastfeeding woman: $hasPregnantOrBreastfeedingWoman');

    DateTime? dateOfAssessment =
        _dateTextFieldKey.currentState?.getSelectedDate();
    String formattedDateOfAssessment = dateOfAssessment != null
        ? DateFormat('yyyy-MM-dd').format(dateOfAssessment)
        : '';
    print('Date of assessment: $formattedDateOfAssessment');

    DateTime? dateOfPreviousAssessment =
        _dateTextFieldPreviousKey.currentState?.getSelectedDate();
    String formattedDateOfPreviousAssessment = dateOfPreviousAssessment != null
        ? DateFormat('yyyy-MM-dd').format(dateOfPreviousAssessment)
        : '';
    print('Date of previous assessment: $formattedDateOfPreviousAssessment');

    // Iterate through the children and collect OVC sub-population data
    // for (var child in children) {
    //   print('Child Name: ${child.name}');
    //   print('Child OVC CPIMS ID: ${child.uniqueNumber}');
    //   // Retrieve CheckboxQuestion objects for the current child
    //   List<CheckboxQuestion> childQuestions = questions1.map((questions1) =>
    //       CheckboxQuestion(id: questions1.id, question: questions1.question, isChecked: questions1.isChecked))
    //       .toList();
    //
    //   // Print the checkbox values for the current child
    //   for (var question in childQuestions) {
    //     print('${question.question}: ${question.isChecked}');
    //   }
    // }
  }

  final GlobalKey<_DateTextFieldState> _dateTextFieldKey = GlobalKey();
  final GlobalKey<_DateTextFieldState> _dateTextFieldPreviousKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return StepsWrapper(
      title: 'CPARA Details',
      children: [
        DateTextField(
          key: _dateTextFieldKey,
          label: 'Date of Assessment',
          enabled: true,
          identifier: DateTextFieldIdentifier.dateOfAssessment,
          onDateSelected: (date) {
            print('Date selected: $date');
            DetailModel detailModel =
                context.read<CparaProvider>().detailModel ?? DetailModel();
            context.read<CparaProvider>().updateDetailModel(
                detailModel.copyWith(dateOfAssessment: date.toString()));
          },
        ),
        const Divider(
          height: 20,
          thickness: 2,
        ),
        const SizedBox(height: 20),
        const TextViewsColumn(),
        QuestionWidget(
            question: 'Is this the first Case Plan Readiness Assessment?',
            selectedOption: (value) {
              setState(() {
                isFirstAssessment = value;
                if (isFirstAssessment == RadioButtonOptions.yes) {
                  _dateTextFieldPreviousKey.currentState?.clearDate();
                }
                DetailModel detailModel =
                    context.read<CparaProvider>().detailModel ?? DetailModel();
                String selectedOption =
                    convertingRadioButtonOptionsToString(value);
                context.read<CparaProvider>().updateDetailModel(
                    detailModel.copyWith(isFirstAssessment: selectedOption));
              });
            },
            isNaAvailable: false),
        const SizedBox(height: 20),
        DateTextField(
          key: _dateTextFieldPreviousKey,
          label: 'If No, give date of Previous Case Plan Readiness Assessment',
          enabled: isFirstAssessment == RadioButtonOptions.no,
          identifier: DateTextFieldIdentifier.previousAssessment,
          onDateSelected: (date) {
            print('Date selected: $date');
            DetailModel detailModel =
                context.read<CparaProvider>().detailModel ?? DetailModel();
            context.read<CparaProvider>().updateDetailModel(
                detailModel.copyWith(dateOfLastAssessment: date.toString()));
          },
        ),
        const SizedBox(height: 20),
        const ReusableTitleText(
            title:
                'Details of all children below 18 years currently living in the household.'),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: children.length,
          itemBuilder: (context, index) {
            return ChildCard(childDetails: children[index]);
          },
        ),
        QuestionWidget(
            question:
                "Is this household child-headed (i.e. Household head age is less than 18 years)?",
            selectedOption: (value) {
              setState(() {
                DetailModel detailModel =
                    context.read<CparaProvider>().detailModel ?? DetailModel();
                String selectedOption =
                    convertingRadioButtonOptionsToString(value);
                context.read<CparaProvider>().updateDetailModel(
                    detailModel.copyWith(isChildHeaded: selectedOption));
              });
            },
            isNaAvailable: false),
        QuestionWidget(
            question: 'Does this HH have HIV exposed infant?',
            selectedOption: (value) {
              setState(() {
                hasHivExposedInfant = value;
                DetailModel detailModel =
                    context.read<CparaProvider>().detailModel ?? DetailModel();
                String selectedOption =
                    convertingRadioButtonOptionsToString(value);
                context.read<CparaProvider>().updateDetailModel(
                    detailModel.copyWith(hasHivExposedInfant: selectedOption));
              });
            },
            isNaAvailable: false),
        QuestionWidget(
            question:
                'Does this HH currently have a pregnant and/or breastfeeding woman/ adolescent?',
            selectedOption: (value) {
              setState(() {
                hasPregnantOrBreastfeedingWoman = value;
                DetailModel detailModel =
                    context.read<CparaProvider>().detailModel ?? DetailModel();
                String selectedOption =
                    convertingRadioButtonOptionsToString(value);
                context.read<CparaProvider>().updateDetailModel(detailModel
                    .copyWith(hasPregnantOrBreastfeedingWoman: selectedOption));
              });
            },
            isNaAvailable: false),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _getDataAndMoveToNext,
          child: const Text('Next'),
        ),
        // for (var child in children)
        //   ExpansionTile(title: Text(child.name), children: [
        //     CheckboxForm(
        //       childName: child.name,
        //       ovcCpimsId: child.uniqueNumber,
        //       onCheckboxSelected: (id) {
        //         DetailModel detailModel =
        //             context.read<CparaProvider>().detailModel ?? DetailModel();
        //         context.read<CparaProvider>().updateDetailModel(
        //             detailModel.copyWith(childrenQuestions: id));
        //       },
        //     ),
        //   ]),
        // const SizedBox(height: 20),
      ],
    );
  }
}

class DateTextField extends StatefulWidget {
  const DateTextField(
      {Key? key,
      required this.label,
      required this.enabled,
      required this.onDateSelected,
      required this.identifier})
      : super(key: key);

  final String label;
  final bool enabled;
  final DateTextFieldIdentifier identifier;
  final Function(DateTime?)? onDateSelected;

  @override
  _DateTextFieldState createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  DateTime? selectedDate;

  void clearDate() {
    setState(() {
      selectedDate = null;
    });
  }

  DateTime? getSelectedDate() {
    return selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    String textFieldText = selectedDate != null
        ? DateFormat('MMMM d, yyyy').format(selectedDate!)
        : '';
    return TextField(
      onTap: () {
        if (widget.enabled) {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          ).then((pickedDate) {
            if (pickedDate != null && mounted) {
              setState(() {
                selectedDate = pickedDate;
                widget.onDateSelected!(selectedDate);
              });
            }
          });
        }
      },
      readOnly: true,
      enabled: widget.enabled,
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
      ),
      controller: TextEditingController(text: textFieldText),
    );
  }
}

// class class TextViewsColumn
class TextViewsColumn extends StatefulWidget {
  const TextViewsColumn({super.key});

  @override
  _TextViewsColumnState createState() => _TextViewsColumnState();
}

class _TextViewsColumnState extends State<TextViewsColumn> {
  late Future<CparaOvcDetails> _ovcDetails;

  @override
  void initState() {
    DetailModel detailModel =
        context.read<CparaProvider>().detailModel ?? DetailModel();


    super.initState();
    _ovcDetails = ApiService.fetchOvcDetails(
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkyOTc3ODM4LCJpYXQiOjE2OTI5NzQyMzgsImp0aSI6IjFlZDVkMGYzNWI1ZDQ2MmM5YTkyMDUxYWFmM2NiOTdkIiwidXNlcl9pZCI6ODg4fQ.RKzW5BJYb3eorTlqZMAABs6sejTvQtWeFlZeFc5r6ZA',
        '2457100');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CparaOvcDetails>(
      future: _ovcDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // or any loading widget
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final details = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ReusableTitleText(title: 'Name of Organisation(LIP)'),
              const SizedBox(height: 10),
              Text(details.cboName),
              const SizedBox(height: 10),
              const ReusableTitleText(title: 'Date enrolled in the project'),
              const SizedBox(height: 10),
              Text(details.ovcEnrollmentDate),
              const SizedBox(height: 10),
              const ReusableTitleText(title: "County"),
              const SizedBox(height: 10),
              Text(details.wardName),
              const SizedBox(height: 10),
              const ReusableTitleText(title: 'Sub County'),
              const SizedBox(height: 10),
              Text(details.wardName),
              const SizedBox(height: 10),
              const ReusableTitleText(
                  title: 'Name of caseworker/CHV conducting assessment'),
              const SizedBox(height: 10),
              Text(details.chvNames),
              const SizedBox(height: 10),
              const ReusableTitleText(title: 'Name of SDP staff/Case Manager'),
              const SizedBox(height: 10),
              Text(details.cboName),
              const SizedBox(height: 10),
              const ReusableTitleText(title: 'Name of Caregiver'),
              const SizedBox(height: 10),
              Text(details.caregiverNames),
              const SizedBox(height: 10),
              const ReusableTitleText(title: 'Caregiver ID Number'),
              const SizedBox(height: 10),
              Text(details.caregiverCpimsId.toString()),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              const ReusableTitleText(title: 'Caregiver Gender'),
              const SizedBox(height: 10),
              const Text("Female"),
              const SizedBox(height: 10),
              const ReusableTitleText(title: 'Caregiver DOB'),
              const SizedBox(height: 10),
              const Text('August 21, 1973'),
              const SizedBox(height: 10),
              const ReusableTitleText(title: 'Caregiver Phone Number'),
              const SizedBox(height: 10),
              const Text('708568702'),
              const SizedBox(height: 10),
              const Divider(height: 20, thickness: 2),
              const SizedBox(height: 20),
            ],
          );
        }
      },
    );
  }
}

class ChildCard extends StatelessWidget {
  const ChildCard({Key? key, required this.childDetails}) : super(key: key);

  final ChildDetails childDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableTitleText(title: 'Name'),
                SizedBox(
                  width: 10.0,
                ),
                ReusableTitleText(title: 'Age')
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(childDetails.name),
                Text(childDetails.age.toString()),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableTitleText(title: 'Gender'),
                ReusableTitleText(title: 'Unique Number'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(childDetails.gender),
                Text(childDetails.uniqueNumber),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableTitleText(
                  title: 'School Level',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(childDetails.schoolLevel),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                    child: ReusableTitleText(
                        title: 'Registered in this OVC Program')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(childDetails.registeredInProgram.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableTitleText extends StatelessWidget {
  const ReusableTitleText({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}

class ChildDetails {
  final String name;
  final int age;
  final String gender;
  final String uniqueNumber;
  final String schoolLevel;
  final bool registeredInProgram;

  ChildDetails({
    required this.name,
    required this.age,
    required this.gender,
    required this.uniqueNumber,
    required this.schoolLevel,
    required this.registeredInProgram,
  });
}

class CparaOvcDetails {
  final String ovcCpimsId;
  final String ovcNames;
  final String dateOfBirth;
  final String ovcEnrollmentDate;
  final String exitStatus;
  final String exitDate;
  final int cboId;
  final String cboName;
  final int chvCpimsId;
  final String chvNames;
  final int caregiverCpimsId;
  final String caregiverNames;
  final String wardCode;
  final String wardName;

  CparaOvcDetails({
    required this.ovcCpimsId,
    required this.ovcNames,
    required this.dateOfBirth,
    required this.ovcEnrollmentDate,
    required this.exitStatus,
    required this.exitDate,
    required this.cboId,
    required this.cboName,
    required this.chvCpimsId,
    required this.chvNames,
    required this.caregiverCpimsId,
    required this.caregiverNames,
    required this.wardCode,
    required this.wardName,
  });

  factory CparaOvcDetails.fromJson(Map<String, dynamic> json) {
    return CparaOvcDetails(
      ovcCpimsId: json['ovc_cpims_id'],
      ovcNames: json['ovc_names'],
      dateOfBirth: json['date_of_birth'],
      ovcEnrollmentDate: json['ovc_enrollment_date'],
      exitStatus: json['exit_status'],
      exitDate: json['exit_date'],
      cboId: json['cbo_id'],
      cboName: json['cbo_name'],
      chvCpimsId: json['chv_cpims_id'],
      chvNames: json['chv_names'],
      caregiverCpimsId: json['caregiver_cpims_id'],
      caregiverNames: json['caregiver_names'],
      wardCode: json['ward']['code'],
      wardName: json['ward']['name'],
    );
  }
}

class ApiService {
  static Future<CparaOvcDetails> fetchOvcDetails(
      String token, String ovcCpimsId) async {
    final response = await http.get(
      Uri.parse('https://dev.cpims.net/api/form/CPR/?ovc_cpims_id=$ovcCpimsId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return CparaOvcDetails.fromJson(jsonData);
    } else {
      throw Exception('Failed to load OVC details');
    }
  }
}

enum DateTextFieldIdentifier {
  dateOfAssessment,
  previousAssessment,
}

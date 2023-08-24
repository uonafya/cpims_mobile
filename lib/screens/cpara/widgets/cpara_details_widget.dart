import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../registry/organisation_units/widgets/steps_wrapper.dart';
import 'ovc_sub_population_form.dart';

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
    print(
        'Date of assessment: $formattedDateOfAssessment'); //am not able to get the date of assessment

    DateTime? dateOfPreviousAssessment =
        _dateTextFieldPreviousKey.currentState?.getSelectedDate();
    String formattedDateOfPreviousAssessment = dateOfPreviousAssessment != null
        ? DateFormat('yyyy-MM-dd').format(dateOfPreviousAssessment)
        : '';
    print('Date of previous assessment: $formattedDateOfPreviousAssessment');
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
        ),
        const Divider(
          height: 20,
          thickness: 2,
        ),
        const SizedBox(height: 20),
        const TextViewsColumn(),
        const Text('Is this the first Case Plan Readiness Assessment?'),
        CustomRadioButton(
            isNaAvailable: false,
            optionSelected: (value) {
              setState(() {
                isFirstAssessment = value;
                if (isFirstAssessment == RadioButtonOptions.yes) {
                  _dateTextFieldPreviousKey.currentState?.clearDate();
                }
              });
            }),
        const SizedBox(height: 20),
        DateTextField(
          key: _dateTextFieldPreviousKey,
          label: 'If No, give date of Previous Case Plan Readiness Assessment',
          enabled: isFirstAssessment == RadioButtonOptions.no,
          identifier: DateTextFieldIdentifier.previousAssessment,
        ),
        const SizedBox(height: 20),
        const ReusableTitleText(
            title:
                'Details of all children below 18 years currently living in the household.'),
        ListView.builder(
          shrinkWrap: true,
          itemCount: children.length,
          itemBuilder: (context, index) {
            return ChildCard(childDetails: children[index]);
          },
        ),
        const Text(
            'Is this household child-headed (i.e. Household head age is less than 18 years)?'),
        CustomRadioButton(
            isNaAvailable: false,
            optionSelected: (value) {
              setState(() {
                isChildHeaded = value;
              });
            }),
        const Text('Does this HH have HIV exposed infant?'),
        CustomRadioButton(
            isNaAvailable: false,
            optionSelected: (value) {
              setState(() {
                hasHivExposedInfant = value;
              });
            }),
        const Text(
            'Does this HH currently have a pregnant and/or breastfeeding woman/ adolescent?'),
        CustomRadioButton(
            isNaAvailable: false,
            optionSelected: (value) {
              setState(() {
                hasPregnantOrBreastfeedingWoman = value;
              });
            }),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _getDataAndMoveToNext,
          child: const Text('Next'),
        ),
        CheckboxForm(),
      ],
    );
  }
}

class DateTextField extends StatefulWidget {
  const DateTextField(
      {Key? key,
      required this.label,
      required this.enabled,
      required this.identifier})
      : super(key: key);

  final String label;
  final bool enabled;
  final DateTextFieldIdentifier identifier;

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
              });
            }
          });
        }
      },
      readOnly: true,
      enabled: widget.enabled,
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(),
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
    super.initState();
    _ovcDetails = ApiService.fetchOvcDetails(
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkyODcxNTM2LCJpYXQiOjE2OTI4Njc5MzYsImp0aSI6ImMxYzQxYzE2YmU1OTQzMGVhMDVhMzIwNDhmMTBkM2Q2IiwidXNlcl9pZCI6ODg4fQ.__r5tgvnqXHBIOhkGuQUELr18NE98IF4AhRPvqybOqo',
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
                Expanded(
                  child: FittedBox(
                      child: ReusableTitleText(
                          title: 'Registered in this OVC Program')),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(childDetails.name),
                Text(childDetails.registeredInProgram.toString()),
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
                ReusableTitleText(title: 'Age')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(childDetails.schoolLevel),
                Text(childDetails.age.toString()),
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

import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';
import 'package:flutter/material.dart';

import '../../registry/organisation_units/widgets/steps_wrapper.dart';

class CparaDetailsWidget extends StatefulWidget {
  const CparaDetailsWidget({super.key});

  @override
  State<StatefulWidget> createState() => _CparaDetailsWidgetState();
}

class _CparaDetailsWidgetState extends State<CparaDetailsWidget> {
  RadioButtonOptions? selected;
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
  Widget build(BuildContext context) {
    RadioButtonOptions? selected;
    return StepsWrapper(
      title: 'CPARA details widget',
      children: [
        const DateTextField(),
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
                selected = value;
              });
            }),
        const DateTextField(),
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
                selected = value;
              });
            }),
        const Text('Does this HH have HIV exposed infant?'),
        CustomRadioButton(
            isNaAvailable: false,
            optionSelected: (value) {
              setState(() {
                selected = value;
              });
            }),
        const Text(
            'Does this HH currently have a pregnant and/or breastfeeding woman/ adolescent?'),
        CustomRadioButton(
            isNaAvailable: false,
            optionSelected: (value) {
              setState(() {
                selected = value;
              });
            }),
      ],
    );
  }
}

class DateTextField extends StatelessWidget {
  const DateTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        // Implement your date picker logic here
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
      },
      decoration: const InputDecoration(
        labelText: 'Date of Assessment',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class TextViewsColumn extends StatelessWidget {
  const TextViewsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableTitleText(title: 'Name of Organisation(LIP)'),
        SizedBox(height: 10),
        Text(
          'REDEEMED INTEGRATED DEVELOPMENT AGENCY (RIDA)',
        ),
        SizedBox(height: 10),
        ReusableTitleText(title: 'Date enrolled in the project'),
        SizedBox(height: 10),
        Text('August 21, 2021'),
        SizedBox(height: 10),
        ReusableTitleText(title: "County"),
        SizedBox(height: 10),
        Text('Nairobi'),
        SizedBox(height: 10),
        ReusableTitleText(title: 'Sub County'),
        SizedBox(height: 10),
        Text('Kasarani'),
        SizedBox(height: 10),
        ReusableTitleText(
            title: 'Name of caseworker/CHV conducting assessment'),
        SizedBox(height: 10),
        Text('John Doe'),
        SizedBox(height: 10),
        ReusableTitleText(title: 'Name of SDP staff/Case Manager'),
        SizedBox(height: 10),
        Text('REDEEMED INTEGRATED DEVELOPMENT AGENCY (RIDA)'),
        SizedBox(height: 10),
        ReusableTitleText(title: 'Name of Caregiver'),
        SizedBox(height: 10),
        Text('Jane Jane'),
        SizedBox(height: 10),
        ReusableTitleText(title: 'Caregiver ID Number'),
        SizedBox(height: 10),
        Text('123456789'),
        SizedBox(height: 10),
        ReusableTitleText(title: 'Caregiver Gender'),
        SizedBox(height: 10),
        Text('Male'),
        SizedBox(height: 10),
        ReusableTitleText(title: 'Caregiver DOB'),
        SizedBox(height: 10),
        Text('August 21, 1973'),
        SizedBox(height: 10),
        ReusableTitleText(title: 'Caregiver Phone Number'),
        SizedBox(height: 10),
        Text('708568702'),
        SizedBox(height: 10),
        Divider(height: 20, thickness: 2),
        SizedBox(height: 20),
      ],
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
                ReusableTitleText(title: 'Registered in this OVC Program'),
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

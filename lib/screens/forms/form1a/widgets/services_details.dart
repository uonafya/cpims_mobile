import 'package:cpims_mobile/screens/registry/organisation_units/widgets/steps_wrapper.dart';
import 'package:cpims_mobile/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';

class ServicesDetails extends StatefulWidget {
  const ServicesDetails({super.key});

  @override
  State<ServicesDetails> createState() => _ServicesDetailsState();
}

class _ServicesDetailsState extends State<ServicesDetails> {
  List<String> typeOfEvents = [
    'OCE1 - Child Pregnant',
    'OCE2 - Child not Adhering to ARVs',
    'OCE3 - Child Malnourished',
    'OCE4 - Child HIV status Changed',
    'OCE5 - Child Acquired Opportunistic Infection',
    'OCE6 - Child Missed Hiv Clinic Appointment',
    'OCE7 - Child-Headed Household',
    'OCE8 - Child Abused',
    'OCE9 - Child Dropped out of School',
    'OCE10 - Change of Caregiver',
    'OCE11 - Relocation',
    'OCE12 - Death',
    'OCE13 - Other specify'
  ];

  String selectedtypeOfEvent = 'Select Various Critical Events';

  @override
  Widget build(BuildContext context) {
    return const StepsWrapper(title: 'Services', children: [
      Text('Service Details',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    ]);
  }
}

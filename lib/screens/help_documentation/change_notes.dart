import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeNotesScreen extends StatelessWidget {
  const ChangeNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(),
        drawer: const Drawer(
          child: CustomDrawer(),
        ),
        body: ListView(
          padding: kSystemPadding,
          children: [
            const SizedBox(height: 20),
            const Text('Changes',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 5),
            const Text(
              'Changes and date',
              style: TextStyle(color: kTextGrey),
            ),
            const SizedBox(height: 30),
            CustomCard(title: 'System Change Notes', children: [
              changeNote('July 11, 2018', [
                'Presidential Bursary Form',
              ]),
              changeNote('July 9, 2018', [
                'Introduced change notes',
                'Viral load functionality',
                'Facilities and Schools settings to allow search for preview',
                'Raw data download- Master List, Assessments, Priorities and Services',
              ]),
            ])
          ],
        ));
  }

  Widget changeNote(String date, List<String> changes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style:
              GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(
          height: 5,
        ),
        ...List.generate(
          changes.length,
          (index) => Text('- ${changes[index]}'),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

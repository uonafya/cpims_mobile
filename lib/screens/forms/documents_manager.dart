import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_dropdown.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocumentsManager extends StatefulWidget {
  const DocumentsManager({super.key});

  @override
  State<DocumentsManager> createState() => _DocumentsManagerState();
}

class _DocumentsManagerState extends State<DocumentsManager> {
  bool isSearching = false;
  String selectedCriteria = 'Select Criteria';

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
          const Text('Documents Manager',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          const Text(
            'Template Generation',
            style: TextStyle(color: kTextGrey),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomCard(title: 'Search Child to Manage Documents', children: [
            const CustomTextField(
              hintText: 'Enter Child\'s Name',
            ),
            const SizedBox(
              height: 15,
            ),
            CustomDropdown(
                initialValue: selectedCriteria,
                items: const [
                  'Select Criteria',
                  'Names',
                  'Org Unit',
                  'Residence',
                  'CPIMS ID',
                ],
                onChanged: (val) {
                  setState(() {
                    selectedCriteria = val;
                  });
                }),
            const SizedBox(
              height: 15,
            ),
            CustomButton(text: 'Search', onTap: () {}),
            const SizedBox(
              height: 10,
            )
          ]),
          if (!isSearching)
            SizedBox(
              height: 230.h,
            ),
          const Footer(),
        ],
      ),
    );
  }
}

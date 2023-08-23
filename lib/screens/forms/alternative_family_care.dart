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

class AlternativeFamilyCare extends StatefulWidget {
  const AlternativeFamilyCare({super.key});

  @override
  State<AlternativeFamilyCare> createState() => _AlternativeFamilyCareState();
}

class _AlternativeFamilyCareState extends State<AlternativeFamilyCare> {
  String selectedCriteria = 'Select Criteria';
  bool isSearching = false;
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
            const SizedBox(
              height: 25,
            ),
            CustomCard(title: 'Search Child', children: [
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
        ));
  }
}

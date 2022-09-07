import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/registry/persons_registry/register_new_person.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_dropdown.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

class FollowUps extends StatefulWidget {
  const FollowUps({super.key});

  @override
  State<FollowUps> createState() => _FollowUpsState();
}

class _FollowUpsState extends State<FollowUps> {
  String selectedCriteria = 'Please Select';
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
            const SizedBox(height: 20),
            const Text('Forms Follow-Ups',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 5),
            const Text(
              'Search Forms',
              style: TextStyle(color: kTextGrey),
            ),
            const SizedBox(height: 30),
            CustomCard(title: 'Search Form', children: [
              CustomDropdown(
                  initialValue: selectedCriteria,
                  items: const [
                    'Please Select',
                    'Child Status Index(CSI)',
                    'Household Assessment',
                    'Services and Monitoring(Form 1A)',
                    'Caregiver Assessment(Form 1B)',
                    'Child protection case',
                    'Child resident in institution',
                    'Alternative Family Care',
                    'School and Bursary',
                  ],
                  onChanged: (val) {
                    setState(() {
                      selectedCriteria = val;
                    });
                  }),
              const SizedBox(
                height: 15,
              ),
              const CustomTextField(
                hintText: 'Enter Child\'s Name',
              ),
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
                height: 170.h,
              ),
            const Footer(),
          ],
        ));
  }
}

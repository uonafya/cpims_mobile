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

class CaseRecordSheet extends StatefulWidget {
  const CaseRecordSheet({super.key});

  @override
  State<CaseRecordSheet> createState() => _CaseRecordSheetState();
}

class _CaseRecordSheetState extends State<CaseRecordSheet> {
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
              Row(
                children: [
                  Expanded(child: CustomButton(text: 'Search', onTap: () {})),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: CustomButton(
                          text: 'Register New',
                          onTap: () {
                            Get.to(() => const RegisterNewPerson());
                          })),
                ],
              ),
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

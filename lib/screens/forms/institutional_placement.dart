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
import 'package:get/route_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstitutionalPlacement extends StatefulWidget {
  const InstitutionalPlacement({super.key});

  @override
  State<InstitutionalPlacement> createState() => _InstitutionalPlacementState();
}

class _InstitutionalPlacementState extends State<InstitutionalPlacement> {
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
          const Text('Forms',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          const Text(
            'Institutional Placement',
            style: TextStyle(color: kTextGrey),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomCard(title: 'Search Form', children: [
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

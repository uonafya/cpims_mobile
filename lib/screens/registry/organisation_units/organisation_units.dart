import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/registry/organisation_units/register_new_organisation.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_dropdown.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class OrganisationUnitsRegistry extends StatefulWidget {
  const OrganisationUnitsRegistry({super.key});

  @override
  State<OrganisationUnitsRegistry> createState() =>
      _OrganisationUnitsRegistryState();
}

class _OrganisationUnitsRegistryState extends State<OrganisationUnitsRegistry> {
  String selectedOrganisationType = 'All Types';
  String selectedSubtype = 'All Types';
  List<String> organisationTypes = [
    'All Types',
    'Committee',
    'Adoption Society',
    'Statutory Institution',
    'Charitable Child Organisation',
    'Non Government Organisation',
    'Government Unit'
        'Health Facility',
  ];
  List<List<String>> subtypes = [
    ['All Types'],
    [
      'All Types',
      'Location AAC',
      'Sub county AAC',
      'County AAC',
      'National Adoption Commitee',
    ],
    [
      'All Types',
      'Adoption Society',
    ],
    [
      'All Types',
      'Borstal',
      'Rescue Home',
      'Rehabilitation School',
      'Remand Home',
      'Assessment & Placement',
    ],
    [
      'All Types',
      'Charitable Child Organisation',
    ],
    [
      'All Types',
      'International NGO',
      'Local NGO',
      'Community Based Organisation',
      'Faith Based Organisation',
      'Private Organisation',
    ],
    [
      'All Types',
      'County Children Office',
      'Sub County Children Office',
      'Police Station',
      'Health Facility',
      'Education',
      'National Office',
      'Children\'s Court',
    ],
    [
      'All Types',
      'Government Health Facility',
      'Private Health Facility',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(height: 20),
          const Text('Organizational Units Registry',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          const Text(
            'Search unit',
            style: TextStyle(color: kTextGrey),
          ),
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ]),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  color: Colors.black,
                  child: const Text(
                    'Search Organisational Unit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 7.5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
                  child: CustomDropdown(
                      initialValue: selectedOrganisationType,
                      items: organisationTypes,
                      onChanged: (value) {
                        setState(() {
                          selectedSubtype = 'All Types';
                          selectedOrganisationType = value;
                        });
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
                  child: CustomDropdown(
                      initialValue: selectedSubtype,
                      items: subtypes[
                          organisationTypes.indexOf(selectedOrganisationType)],
                      onChanged: (value) {
                        setState(() {
                          selectedSubtype = value;
                        });
                      }),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
                  child: CustomTextField(
                    hintText: 'Organisation Unit',
                  ),
                ),
                const SizedBox(
                  height: 7.5,
                ),
                const CustomRadioTile(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                          child: CustomButton(text: 'Search', onTap: () {})),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: CustomButton(
                              text: 'Register New',
                              onTap: () {
                                Get.to(() =>
                                    const RegisterNewOrganisationScreen());
                              })),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Footer()
        ],
      ),
    );
  }
}

class CustomRadioTile extends StatefulWidget {
  const CustomRadioTile({
    Key? key,
    this.title = 'Include closed units',
  }) : super(key: key);
  final String title;

  @override
  State<CustomRadioTile> createState() => _CustomRadioTileState();
}

class _CustomRadioTileState extends State<CustomRadioTile> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 15),
        InkWell(
          onTap: () {
            setState(() {
              isSelected = !isSelected;
            });
          },
          child: Icon(
            isSelected ? Icons.check_box : Icons.square_outlined,
            color: isSelected ? kPrimaryColor : kTextGrey,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(widget.title),
      ],
    );
  }
}

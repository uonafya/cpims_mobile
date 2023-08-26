// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, avoid_print

import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_dropdown.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
//import 'package:cpims_mobile/widgets/dialog.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FollowUps extends StatefulWidget {
  const FollowUps({super.key});

  @override
  State<FollowUps> createState() => _FollowUpsState();
  //State<FollowUps> createDialog() => _showDialog();
}

class _FollowUpsState extends State<FollowUps> {
  String selectedCriteria = 'Please Select';
  String searchDialogSource = "First";

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
            _createDataTable(),
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
              CustomButton(
                  text: 'Search',
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            //contentPadding: EdgeInsets.fromLTRB(left, top, right, bottom)
                            contentPadding: EdgeInsets.fromLTRB(10, 16, 10, 20),
                            title: Text(
                              'Choose Form',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            children: <Widget>[
                              new Row(
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: new Icon(Icons.close),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Text(
                                    'Please select:',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  )),
                                  Expanded(
                                    child: DropdownButton<String>(
                                      value: searchDialogSource,
                                      items: [
                                        DropdownMenuItem(
                                          value: "First",
                                          child: Text(
                                            "Services & monitoring - Form1A",
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: "Second",
                                          child: Text(
                                            "Caregiver Assesment - Form1B",
                                          ),
                                        ),
                                      ],
                                      onChanged: (val) => setState(() {
                                        searchDialogSource = val!;
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }); //showDialog
                  }),
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

  _createDataTable() {
    //return DataTable(columns: _createColumns(), rows: _createRows());
  }
  // ignore: unused_element
  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('ID')),
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('DOB')),
      DataColumn(label: Text('Reg Date'))
    ];
  }
/**List<DataRow> _createRows(){
  return access
     .map((e) => DataRow(cells: [
      DataCell(Text('#' + e['cpims_id'].toString())),
      DataCell(Text(e['name'])),
      DataCell(Text(e['date_of_birth'])),
      DataCell(Text(e['registration_date']))
     ]))
     .toList();
}**/
}

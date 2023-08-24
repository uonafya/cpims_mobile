import 'package:cpims_mobile/services/unapproved_data.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_chip.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnapprovedRecordsScreens extends StatefulWidget {
  const UnapprovedRecordsScreens({super.key});

  @override
  State<UnapprovedRecordsScreens> createState() =>
      _UnapprovedRecordsScreensState();
}

class _UnapprovedRecordsScreensState extends State<UnapprovedRecordsScreens> {
  List<String> unapprovedRecords = [
    'Form 1A',
    'Form 1B',
    'CPARA',
    'CPA',
  ];

  @override
  void initState() {
    super.initState();
    getRecords();
  }

  void getRecords() async {
    final prefs = await SharedPreferences.getInstance();

    final accessToken = prefs.getString('access');

    await UnapprovedDataService.fetchUnnaprovedData(accessToken);
  }

  String selectedRecord = 'Form 1A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) => CustomChip(
                        title: unapprovedRecords[index],
                        isSelected: selectedRecord == unapprovedRecords[index],
                        onTap: () {
                          setState(() {
                            selectedRecord = unapprovedRecords[index];
                          });
                        },
                      ),
                  itemCount: unapprovedRecords.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                        width: 12,
                      )),
            ),
            const SizedBox(height: 10),
            const Text(
              'Unapproved records',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ]),
        ));
  }
}

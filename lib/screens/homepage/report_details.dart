import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: kSystemPadding,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: kToolbarHeight + 40),
            Text(
              'Report details-$title',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(
                  child: CustomTextField(
                    hintText: 'Search',
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Icon(
                  FontAwesomeIcons.solidFileExcel,
                  color: kPrimaryColor,
                ),
                const SizedBox(
                  width: 15,
                ),
                Icon(
                  FontAwesomeIcons.filePdf,
                  color: Colors.red[900],
                ),
              ],
            ),
            const SizedBox(height: 10),
          ])),
    );
  }
}

List reportTableCols = [
  {"title": '#', 'widthFactor': 0.05, 'key': 'name'},
  {"title": 'Name', 'widthFactor': 0.2, 'key': 'date'},
  {"title": 'Date Modified', 'widthFactor': 0.1, 'key': 'month'},
  {"title": 'Details', 'key': 'status'},
];

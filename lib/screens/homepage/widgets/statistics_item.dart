import 'package:cpims_mobile/screens/homepage/report_details.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class StatisticsItem extends StatelessWidget {
  const StatisticsItem({Key? key, required this.title, required this.icon, required this.color, required this.secondaryColor, required this.form1ACount, required this.form1BCount, required this.cpaCount, required this.cparaCount}) : super(key: key);
  final String title;
  final IconData icon;
  final Color color;
  final Color secondaryColor;
  final int form1ACount;
  final int form1BCount;
  final int cpaCount;
  final int cparaCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ReportDetailsScreen(
              title: title,
            ));
      },
      child: Container(
        height: 190,
        width: double.infinity,
        color: color,
        margin: const EdgeInsets.symmetric(vertical: 7.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        (form1ACount + form1BCount + cpaCount + cparaCount).toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Text(
                          "Form 1a ($form1ACount)",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Text(
                          "CPARA ($cparaCount)",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                      ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Text(
                          "Form 1b ($form1BCount)",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Text(
                          "CPT ($cpaCount)",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                      ])
                    ],
                  ),
                ),
                Icon(
                  icon,
                  size: 60,
                  color: Colors.white12.withOpacity(0.3),
                )
              ]),
            ),
            const Spacer(),
            Container(
              height: 35,
              width: double.infinity,
              color: secondaryColor,
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'View Details',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

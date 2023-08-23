import 'package:cpims_mobile/screens/homepage/report_details.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class HomepageCardSecondary extends StatelessWidget {
  const HomepageCardSecondary({Key? key, required this.data}) : super(key: key);
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ReportDetailsScreen(
              title: data['title'],
            ));
      },
      child: Container(
        height: 120,
        width: double.infinity,
        color: data['color'],
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
                        data['title'],
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        data['value'],
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  data['icon'],
                  size: 60,
                  color: Colors.white12.withOpacity(0.3),
                )
              ]),
            ),
            const Spacer(),
            Container(
              height: 30,
              width: double.infinity,
              color: data['s_color'],
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

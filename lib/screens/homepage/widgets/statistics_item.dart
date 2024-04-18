import 'package:flutter/material.dart';

class StatisticsItem extends StatelessWidget {
  const StatisticsItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.color,
      required this.secondaryColor,
      required this.form1ACount,
      required this.formoneasummary,
      required this.formonebsummary,
      required this.cparaSummary,
      required this.caseplanSummary,
      required this.hrsSummary,
      required this.hmfSummary,
      required this.form1BCount,
      required this.cpaCount,
      required this.cparaCount,
      required this.hrsCount,
      required this.hmfCount,
      required this.graduationMonitoringCount,
      required this.graduationMonitoringSummary,
      required this.onClick})
      : super(key: key);
  final String title;
  final IconData icon;
  final Color color;
  final Color secondaryColor;
  final String form1ACount;
  final String formoneasummary;
  final String formonebsummary;
  final String cparaSummary;
  final String caseplanSummary;
  final String hrsSummary;
  final String hmfSummary;
  final String form1BCount;
  final String cpaCount;
  final String cparaCount;
  final String hrsCount;
  final String hmfCount;
  final String graduationMonitoringCount;
  final String graduationMonitoringSummary;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    debugPrint('form1ACount GER: $form1ACount');
    debugPrint('form1BCount GER: $form1BCount');
    debugPrint('formoneadtict GER: $formoneasummary');
    debugPrint('cpaCount GER: $cpaCount');
    debugPrint('cparaCount GER: $cparaCount');
    debugPrint('hrsCount GER: $hrsCount');
    debugPrint('hmfCount GER: $hmfCount');
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        height: 220,
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
                        (int.parse(form1ACount) +
                                int.parse(form1BCount) +
                                int.parse(cpaCount) +
                                int.parse(cparaCount) +
                                int.parse(hrsCount) +
                                int.parse(hmfCount) +
                                int.parse(graduationMonitoringCount))
                            .toString(),
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
                          "Form 1A ($formoneasummary)",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Text(
                          "CPARA ($cparaSummary)",
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
                          "Form 1B ($formonebsummary)",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Text(
                          "CPT ($caseplanSummary)",
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
                          "HRS Form ($hrsSummary)",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Text(
                          "HMF Form ($hmfSummary)",
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
                      Row(
                        children: [
                          Text(
                            "CPA Form($graduationMonitoringSummary)",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
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

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.secondaryColor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Color color;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: color,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

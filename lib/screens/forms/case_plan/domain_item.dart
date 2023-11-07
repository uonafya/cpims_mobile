import 'package:cpims_mobile/screens/forms/case_plan/cpt/models/safe_cpt_model.dart';
import 'package:flutter/material.dart';

class CPTDomainModel {
  String? domainId;
  final String? domain;
  final List<String?>? serviceIds;
  final String? goalId;
  final String? gapId;
  final String? priorityId;
  final List<String?>? responsibleIds;
  final String? resultsId;
  final String? reasonId;
  String? completionDate = "";

  CPTDomainModel({
    required this.domain,
    required this.serviceIds,
    required this.goalId,
    required this.gapId,
    required this.priorityId,
    required this.responsibleIds,
    required this.resultsId,
    required this.reasonId,
    this.domainId,
    this.completionDate,
  });
}

class DomainItem extends StatelessWidget {
  const DomainItem({super.key, required this.domain});
  final CPTDomainModel domain;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[200]!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Domain: ",
                style: TextStyle(color: Colors.grey),
              ),
              Text(domain.domain!),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(child: textItem(title: "Goal", value: domain.goalId!)),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: textItem(title: "Needs/Gaps", value: domain.gapId!)),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: textItem(
                      title: "Priority Actions", value: domain.priorityId!)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Services",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          ...List.generate(domain.serviceIds!.length,
              (index) => Text(domain.serviceIds![index]!)),
          const SizedBox(
            height: 4,
          ),
          const Text(
            "Person responsible",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          ...List.generate(domain.responsibleIds!.length,
              (index) => Text(domain.responsibleIds![index]!)),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }

  Widget textItem({
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(value),
      ],
    );
  }
}

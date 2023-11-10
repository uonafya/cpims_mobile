import 'package:cpims_mobile/providers/cpara/unapproved_records_screen_provider.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../Models/case_load_model.dart';
import '../../../providers/app_meta_data_provider.dart';
import '../../../providers/cpara/unapproved_cpara_database.dart';
import '../cpara_forms.dart';
import '../provider/cpara_provider.dart';

class UnnaprovedCparaScreen extends StatelessWidget {
  const UnnaprovedCparaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get Unapproved CPARAs from Provider
    return Consumer<UnapprovedRecordsScreenProvider>(
      builder: (context, model, _) {
        return ListView.builder(
            itemCount: model.unapprovedCparas.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: UnnaprovedCparaRecordCard(
                    removeCparaUnapprovedItem: () => model
                        .removeUnapprovedCpara(model.unapprovedCparas[index]),
                    model: model.unapprovedCparas[index]),
              );
            });
      },
    );
  }
}

typedef RemoveCparaUnapprovedItem = Function();

class UnnaprovedCparaRecordCard extends StatefulWidget {
  final UnapprovedCparaModel model;
  final RemoveCparaUnapprovedItem removeCparaUnapprovedItem;
  const UnnaprovedCparaRecordCard(
      {super.key,
      required this.removeCparaUnapprovedItem,
      required this.model});

  @override
  State<UnnaprovedCparaRecordCard> createState() =>
      _UnnaprovedCparaRecordCardState();
}

class _UnnaprovedCparaRecordCardState extends State<UnnaprovedCparaRecordCard> {
  @override
  void initState() {
    super.initState();
    fetchChildName();
  }

  String childName = "";
  fetchChildName() async {
    String name =
        await LocalDb.instance.getFullChildNameFromOVCID(widget.model.cpmis_id);
    setState(() {
      childName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.mounted) {
          // Get instance of CPARA provider
          var cparaProvider = context.read<CparaProvider>();

          // Populate details
          String startDateTime = DateTime.now().toString();
          context
              .read<AppMetaDataProvider>()
              .updateStartTimeInterview(startDateTime);
          context.read<CparaProvider>().updateCparaModel(widget.model);
          context.read<CparaProvider>().updateDetailModel(widget.model.detail);
          context.read<CparaProvider>().updateHealthModel(widget.model.health);
          context.read<CparaProvider>().updateSafeModel(widget.model.safe);
          context
              .read<CparaProvider>()
              .updateSchooledModel(widget.model.schooled);
          context.read<CparaProvider>().updateStableModel(widget.model.stable);
          context
              .read<CparaProvider>()
              .updateCparaOvcModel(widget.model.ovcSubPopulations);

          // Remove widget from listing
          widget.removeCparaUnapprovedItem();

          // Navigate to CPARA
          Get.to(() => CparaFormsScreen(
                caseLoadModel: CaseLoadModel(ovcFirstName: childName),
                isRejected: true,
                rejectedMessage: widget.model.message,
                formId: widget.model.uuid,
                cpmisID: widget.model.cpmis_id,
              ));
        }
      },
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0, left: 4.0, right: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.model.message,
                style: const TextStyle(color: Colors.red),
              ),
              const Text(
                "Reason",
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
              const SizedBox(
                height: 12.0,
              ),
              RichText(
                  text: TextSpan(
                      text: "Ovc Cpims ID : ",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal),
                      children: [
                    TextSpan(
                        text: widget.model.cpmis_id,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold))
                  ])),
              const SizedBox(
                height: 2.0,
              ),
              RichText(
                  text: TextSpan(
                      text: "Full Names : ",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal),
                      children: [
                    TextSpan(
                        text: childName,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold))
                  ])),
              const SizedBox(
                height: 6.0,
              ),
              RichText(
                  text: TextSpan(
                      text: "Assessment date : ",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal),
                      children: [
                    TextSpan(
                        text: widget.model.detail.dateOfAssessment,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal))
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:core';

import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/providers/case_plan_provider.dart';
import 'package:cpims_mobile/providers/hiv_management_form_provider.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/models/healthy_cpt_model.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/models/safe_cpt_model.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/models/schooled_cpt_model.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/models/stable_cpt_model.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/new_case_plan_template.dart';
import 'package:cpims_mobile/screens/forms/case_plan/cpt/new_cpt_provider.dart';
import 'package:cpims_mobile/screens/forms/case_plan/utils/case_plan_dummy_data.dart';
import 'package:cpims_mobile/Models/unapproved_form_1_model.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/screens/forms/graduation_monitoring/model/graduation_monitoring_form_model.dart';
import 'package:cpims_mobile/screens/forms/graduation_monitoring/provider/graduation_monitoring_provider.dart';
import 'package:cpims_mobile/screens/forms/graduation_monitoring/widgets/graduation_monitoring_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/unapproved/hiv_risk_assessment_form_model.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/unapproved/unapproved_hrs_model.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/screens/hiv_management_form_screen.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/unapproved/UnApprovedHmfModel.dart';
import 'package:cpims_mobile/services/unapproved_data_service.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/custom_chip.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../cpara/model/unnaproved_cpara_screen.dart';
import 'package:multi_dropdown/models/value_item.dart';
import '../../Models/unapproved_caseplan_form_model.dart';
import '../../providers/form1a_provider.dart';
import '../../providers/form1b_provider.dart';
import '../cpara/provider/hiv_assessment_provider.dart';
import '../forms/form1a/new/form_one_a.dart';
import '../forms/form1a/new/utils/form_one_a_provider.dart';
import '../forms/form1a/utils/form_1a_options.dart';
import '../forms/form1b/form_1B.dart';
import '../forms/form1b/utils/form1bConstants.dart';
import '../forms/graduation_monitoring/unapproved/unapproved_graduation_form.dart';
import '../forms/hiv_assessment/hiv_assessment.dart';
import '../forms/hiv_management/models/hiv_management_form_model.dart';
import '../homepage/provider/stats_provider.dart';

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
    'CPT',
    'CPARA',
    'HMF',
    'HRS',
    'CPA'
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      getRecords();
    });
  }

  List<UnapprovedForm1DataModel> unapprovedForm1AData = [];
  List<UnapprovedForm1DataModel> unapprovedForm1BData = [];
  List<UnapprovedCasePlanModel> unapprovedCaseplanData = [];
  List<UnApprovedHivManagementForm> unapprovedHMFData = [];
  List<UnapprovedHrsModel> unapprovedHRSData = [];
  List<UnApprovedGraduationFormModel> unnapprovedGraduationData = [];

  void deleteUnapprovedForm1(int id) async {
    bool success = await UnapprovedDataService.deleteUnapprovedForm1(id);
    if (success) {
      setState(() {
        if (selectedRecord == unapprovedRecords[0]) {
          unapprovedForm1AData.removeWhere((element) => element.localId == id);
        } else if (selectedRecord == unapprovedRecords[1]) {
          unapprovedForm1BData.removeWhere((element) => element.localId == id);
        }
      });
      Provider.of<StatsProvider>(context, listen: false)
          .updateUnapprovedFormStats();
    }
  }

  void deleteUnapprovedCPT(int id) async {
    bool success = await UnapprovedDataService.deleteUnapprovedCpt(id);
    if (success) {
      setState(() {
        unapprovedCaseplanData.removeWhere((element) => element.id == id);
      });
      Provider.of<StatsProvider>(context, listen: false)
          .updateUnapprovedFormStats();
    }
  }

  void getRecords() async {
    final List<UnapprovedForm1DataModel> form1ARecords =
        await UnapprovedDataService.fetchLocalUnapprovedForm1AData();
    final List<UnapprovedForm1DataModel> form1BRecords =
        await UnapprovedDataService.fetchLocalUnapprovedForm1BData();
    final List<UnapprovedCasePlanModel> unapprovedCaseplanRecords =
        await UnapprovedDataService.fetchLocalUnapprovedCasePlanData();
    final List<UnApprovedHivManagementForm> unapprovedHMFRecords =
        await UnapprovedDataService.fetchRejectedHMFForms();
    final List<UnapprovedHrsModel> unapprovedHRSRecords =
        await UnapprovedDataService.fetchRejectedHRSForms();
    // final List<UnApprovedGraduationFormModel> unapprovedGraduationRecords =
    //     await UnapprovedDataService.fetchRejectedGraduationForms();
    setState(() {
      unapprovedForm1AData = form1ARecords;
      unapprovedForm1BData = form1BRecords;
      unapprovedCaseplanData = unapprovedCaseplanRecords;
      unapprovedHMFData = unapprovedHMFRecords;
      unapprovedHRSData = unapprovedHRSRecords;
      // unnapprovedGraduationData = unapprovedGraduationRecords;
    });
  }

  String selectedRecord = 'Form 1A';

  @override
  Widget build(BuildContext context) {
    Form1AProviderNew form1aProvider = Provider.of<Form1AProviderNew>(context);
    Form1bProvider form1bProvider = Provider.of<Form1bProvider>(context);

    void editUnapprovedForm1B(UnapprovedForm1DataModel unapprovedForm1B) async {
      // TODO : Refactor for efficiency
      final db = LocalDb.instance;
      CaseLoadModel caseLoad =
          await db.getCaseLoad(int.parse(unapprovedForm1B.ovcCpimsId));
      List<ValueItem> form1CriticalEvents = [];
      List<ValueItem> criticalEventsOptions =
          careGiverCriticalEvents.map((service) {
        return ValueItem(
            label: service['item_description'], value: service['item_id']);
      }).toList();
      for (var form1ACriticalEvent in unapprovedForm1B.criticalEvents) {
        var t = criticalEventsOptions
            .where((element) => element.value == form1ACriticalEvent.eventId);
        if (t.isNotEmpty) {
          form1CriticalEvents.add(t.first);
        }
      }
      form1bProvider.setCriticalEventsSelectedEvents(form1CriticalEvents);

      List<ValueItem> form1StableServices = [];
      String stableServicesDomain = domainsList[2]['item_id'];
      List<ValueItem> stableServices = careGiverEconomicServices.map((service) {
        return ValueItem(
            label: service['item_description'], value: service['item_id']);
      }).toList();
      for (var form1AService in unapprovedForm1B.services) {
        if (form1AService.domainId == stableServicesDomain) {
          var t = stableServices
              .where((element) => element.value == form1AService.serviceId);
          if (t.isNotEmpty) {
            form1StableServices.add(t.first);
          }
        }
      }
      form1bProvider.setSelectedStableFormDataServices(
          form1StableServices, stableServicesDomain);

      List<ValueItem> form1HealthyServices = [];
      String healthyServicesDomain = domainsList[1]['item_id'];
      List<ValueItem> healthyServices = careGiverHealthServices.map((service) {
        return ValueItem(
            label: service['item_description'], value: service['item_id']);
      }).toList();
      for (var form1AService in unapprovedForm1B.services) {
        if (form1AService.domainId == healthyServicesDomain) {
          var t = healthyServices
              .where((element) => element.value == form1AService.serviceId);
          if (t.isNotEmpty) {
            form1HealthyServices.add(t.first);
          }
        }
      }
      form1bProvider.setSelectedHealthServices(
          form1HealthyServices, healthyServicesDomain);

      List<ValueItem> form1SafeServices = [];
      String safeServicesDomain = domainsList[3]['item_id'];
      List<ValueItem> safeServicesOptions =
          careGiverProtectionServices.map((service) {
        return ValueItem(
            label: service['item_description'], value: service['item_id']);
      }).toList();
      for (var form1AService in unapprovedForm1B.services) {
        if (form1AService.domainId == safeServicesDomain) {
          var t = safeServicesOptions
              .where((element) => element.value == form1AService.serviceId);
          if (t.isNotEmpty) {
            form1SafeServices.add(t.first);
          }
        }
      }
      form1bProvider.setSelectedSafeFormDataServices(
          form1SafeServices, safeServicesDomain);

      // List<> services = unapprovedForm1A.services.map((e) => null);
      context.read<Form1AProvider>();

      var success = await Get.to(() => Form1BScreen(
            caseLoad: caseLoad,
            unapprovedForm1: unapprovedForm1B,
          ));
      if (success != null && success) {
        getRecords();
        Provider.of<StatsProvider>(context, listen: false)
            .updateUnapprovedFormStats();
      }
    }

    void editUnapprovedForm1A(UnapprovedForm1DataModel unapprovedForm1A) async {
      // TODO : Refactor for efficiency
      final db = LocalDb.instance;
      CaseLoadModel caseLoad =
          await db.getCaseLoad(int.parse(unapprovedForm1A.ovcCpimsId));
      List<ValueItem> form1CriticalEvents = [];
      List<ValueItem> criticalEventsOptions =
          formOneACriticalEvents.map((service) {
        return ValueItem(
            label: service['event_description'], value: service['event_id']);
      }).toList();
      for (var form1ACriticalEvent in unapprovedForm1A.criticalEvents) {
        var t = criticalEventsOptions
            .where((element) => element.value == form1ACriticalEvent.eventId);
        if (t.isNotEmpty) {
          form1CriticalEvents.add(t.first);
        }
      }
      form1aProvider.setCriticalEventsSelectedEvents(form1CriticalEvents);

      List<ValueItem> form1StableServices = [];
      String stableServicesDomain = domainsList[2]['item_id'];
      List<ValueItem> stableServices = stableServicesOptions.map((service) {
        return ValueItem(
            label: service['item_description'], value: service['item_id']);
      }).toList();
      for (var form1AService in unapprovedForm1A.services) {
        if (form1AService.domainId == stableServicesDomain) {
          var t = stableServices
              .where((element) => element.value == form1AService.serviceId);
          if (t.isNotEmpty) {
            form1StableServices.add(t.first);
          }
        }
      }
      form1aProvider.setSelectedStableFormDataServices(
          form1StableServices, stableServicesDomain);

      List<ValueItem> form1SchooledServices = [];
      String schooledServicesDomain = domainsList[0]['item_id'];
      List<ValueItem> schoolServices = schooledServicesOptions.map((service) {
        return ValueItem(
            label: service['item_description'], value: service['item_id']);
      }).toList();
      for (var form1AService in unapprovedForm1A.services) {
        if (form1AService.domainId == schooledServicesDomain) {
          var t = schoolServices
              .where((element) => element.value == form1AService.serviceId);
          if (t.isNotEmpty) {
            form1SchooledServices.add(t.first);
          }
        }
      }
      form1aProvider.setSelectedSchooledFormDataServices(
          form1SchooledServices, schooledServicesDomain);

      List<ValueItem> form1HealthyServices = [];
      String healthyServicesDomain = domainsList[1]['item_id'];
      List<ValueItem> healthyServices = healthServicesOptions.map((service) {
        return ValueItem(
            label: service['item_description'], value: service['item_id']);
      }).toList();
      for (var form1AService in unapprovedForm1A.services) {
        if (form1AService.domainId == healthyServicesDomain) {
          var t = healthyServices
              .where((element) => element.value == form1AService.serviceId);
          if (t.isNotEmpty) {
            form1HealthyServices.add(t.first);
          }
        }
      }
      form1aProvider.setSelectedHealthServices(
          form1HealthyServices, healthyServicesDomain);

      List<ValueItem> form1SafeServices = [];
      String safeServicesDomain = domainsList[3]['item_id'];
      List<ValueItem> safeServicesOptions = safeServices.map((service) {
        return ValueItem(
            label: service['item_description'], value: service['item_id']);
      }).toList();
      for (var form1AService in unapprovedForm1A.services) {
        if (form1AService.domainId == safeServicesDomain) {
          var t = safeServicesOptions
              .where((element) => element.value == form1AService.serviceId);
          if (t.isNotEmpty) {
            form1SafeServices.add(t.first);
          }
        }
      }
      form1aProvider.setSelectedSafeFormDataServices(
          form1SafeServices, safeServicesDomain);

      // List<> services = unapprovedForm1A.services.map((e) => null);
      context.read<Form1AProvider>();

      var success = await Get.to(() => FomOneA(
            caseLoadModel: caseLoad,
            unapprovedForm1: unapprovedForm1A,
          ));
      if (success != null && success) {
        getRecords();
        Provider.of<StatsProvider>(context, listen: false)
            .updateUnapprovedFormStats();
      }
    }

    void editUnapprovedForm1(UnapprovedForm1DataModel unapprovedForm1) async {
      if (selectedRecord == unapprovedRecords[0]) {
        editUnapprovedForm1A(unapprovedForm1);
      } else if (selectedRecord == unapprovedRecords[1]) {
        editUnapprovedForm1B(unapprovedForm1);
      }
    }

    void editUnapprovedCptForm(UnapprovedCasePlanModel unapprovedCpt) async {
      // TODO : Refactor for efficiency
      final db = LocalDb.instance;
      CaseLoadModel caseLoad =
          await db.getCaseLoad(int.parse(unapprovedCpt.ovcCpimsId));
      context.read<CptProvider>().updateFormUuid(unapprovedCpt.formUuid);
      // Healthy Services
      CptHealthFormData cptHealtFormData =
          context.read<CptProvider>().cptHealthFormData ?? CptHealthFormData();
      String healthyServicesDomain = allDomains[1]['item_id'];
      for (var cptService in unapprovedCpt.services) {
        if (cptService.domainId == healthyServicesDomain) {
          context.read<CptProvider>().updateCptFormData(
                cptHealtFormData.copyWith(
                  domainId: cptService.domainId,
                  goalId: cptService.goalId,
                  gapId: cptService.gapId,
                  priorityId: cptService.priorityId,
                  resultsId: cptService.resultsId,
                  reasonId: cptService.reasonId,
                  serviceIds: cptService.serviceIds,
                  responsibleIds: cptService.responsibleIds,
                ),
              );
        }
      }

      // Safe Services
      CptSafeFormData cptSafeFormData =
          context.read<CptProvider>().cptSafeFormData ?? CptSafeFormData();
      String safeServicesDomain = allDomains[3]['item_id'];
      for (var cptService in unapprovedCpt.services) {
        if (cptService.domainId == safeServicesDomain) {
          context
              .read<CptProvider>()
              .updateCptSafeFormData(cptSafeFormData.copyWith(
                domainId: cptService.domainId,
                goalId: cptService.goalId,
                gapId: cptService.gapId,
                priorityId: cptService.priorityId,
                resultsId: cptService.resultsId,
                reasonId: cptService.reasonId,
                serviceIds: cptService.serviceIds,
                responsibleIds: cptService.responsibleIds,
              ));
        }
      }

      // Schooled Services
      CptschooledFormData cptschooledFormData =
          context.read<CptProvider>().cptschooledFormData ??
              CptschooledFormData();
      String schooledServicesDomain = allDomains[0]['item_id'];
      for (var cptService in unapprovedCpt.services) {
        if (cptService.domainId == schooledServicesDomain) {
          context
              .read<CptProvider>()
              .updateCptSchooledFormData(cptschooledFormData.copyWith(
                domainId: cptService.domainId,
                goalId: cptService.goalId,
                gapId: cptService.gapId,
                priorityId: cptService.priorityId,
                resultsId: cptService.resultsId,
                reasonId: cptService.reasonId,
                serviceIds: cptService.serviceIds,
                responsibleIds: cptService.responsibleIds,
              ));
        }
      }

      // Stable Services
      CptStableFormData cptStableFormData =
          context.read<CptProvider>().cptStableFormData ?? CptStableFormData();
      String stableServicesDomain = allDomains[2]['item_id'];
      for (var cptService in unapprovedCpt.services) {
        if (cptService.domainId == stableServicesDomain) {
          context
              .read<CptProvider>()
              .updateCptStableFormData(cptStableFormData.copyWith(
                domainId: cptService.domainId,
                goalId: cptService.goalId,
                gapId: cptService.gapId,
                priorityId: cptService.priorityId,
                resultsId: cptService.resultsId,
                reasonId: cptService.reasonId,
                serviceIds: cptService.serviceIds,
                responsibleIds: cptService.responsibleIds,
              ));
        }
      }

      context.read<CasePlanProvider>();
      Get.to(
        () => CasePlanTemplateForm(
          caseLoad: caseLoad,
        ),
      );
      Provider.of<StatsProvider>(context, listen: false)
          .updateUnapprovedFormStats();
    }

    void editHMF(UnApprovedHivManagementForm unapprovedHMF) async {
      final db = LocalDb.instance;
      CaseLoadModel caseLoad =
          await db.getCaseLoad(int.parse(unapprovedHMF.ovcCpimsId!));
      HivManagementFormModel hivManagementFormModel =
          context.read<HIVManagementFormProvider>().hivManagementFormModel;
      context
          .read<HIVManagementFormProvider>()
          .updateHIVVisitationModel(hivManagementFormModel.copyWith(
            dateOfEvent: unapprovedHMF.dateOfEvent,
            dateHIVConfirmedPositive: unapprovedHMF.dateHIVConfirmedPositive,
            dateTreatmentInitiated: unapprovedHMF.dateTreatmentInitiated,
            baselineHEILoad:  "",
            dateStartedFirstLine: unapprovedHMF.dateStartedFirstLine,
            arvsSubWithFirstLine:
                unapprovedHMF.arvsSubWithFirstLine == true ? "Yes" : "No",
            arvsSubWithFirstLineDate: unapprovedHMF.arvsSubWithFirstLineDate,
            switchToSecondLine:
                unapprovedHMF.switchToSecondLine == true ? "Yes" : "No",
            switchToSecondLineDate: unapprovedHMF.switchToSecondLineDate,
            switchToThirdLine:
                unapprovedHMF.switchToThirdLine == true ? "Yes" : "No",
            switchToThirdLineDate: unapprovedHMF.switchToThirdLineDate,
            visitDate: unapprovedHMF.visitDate,
            durationOnARTs: unapprovedHMF.durationOnARTs,
            height: unapprovedHMF.height,
            mUAC: unapprovedHMF.mUAC,
            arvDrugsAdherence: unapprovedHMF.arvDrugsAdherence,
            arvDrugsDuration: unapprovedHMF.arvDrugsDuration,
            adherenceCounseling: unapprovedHMF.adherenceCounseling,
            treatmentSupporter: unapprovedHMF.treatmentSupporter,
            treatmentSupporterSex: unapprovedHMF.treatmentSupporterSex,
            treatmentSupporterAge: unapprovedHMF.treatmentSupporterAge,
            treatmentSupporterHIVStatus:
                unapprovedHMF.treatmentSupporterHIVStatus,
            viralLoadResults: unapprovedHMF.viralLoadResults,
            labInvestigationsDate: unapprovedHMF.labInvestigationsDate,
            detectableViralLoadInterventions:
                unapprovedHMF.detectableViralLoadInterventions,
            disclosure: unapprovedHMF.disclosure,
            mUACScore: unapprovedHMF.mUACScore,
            zScore: unapprovedHMF.zScore,
            nutritionalSupport: unapprovedHMF.nutritionalSupport,
            supportGroupStatus: unapprovedHMF.supportGroupStatus,
            nhifEnrollment: unapprovedHMF.nhifEnrollment == true ? "Yes" : "No",
            nhifEnrollmentStatus: unapprovedHMF.nhifEnrollmentStatus,
            referralServices: unapprovedHMF.referralServices,
            nextAppointmentDate: unapprovedHMF.nextAppointmentDate,
            peerEducatorName: unapprovedHMF.peerEducatorName,
            peerEducatorContact: unapprovedHMF.peerEducatorContact,
          ));

      await Future.delayed(Duration(milliseconds: 300));

      context.read<HIVManagementFormProvider>();
      Get.to(() => HIVManagementForm(caseLoad: caseLoad));
      Provider.of<StatsProvider>(context, listen: false)
          .updateUnapprovedFormStats();
    }

    void deleteUnapprovedHMF(String id) async {
      bool success = await UnapprovedDataService.deleteUnapprovedHMF(id);
      if (success) {
        setState(() {
          unapprovedHMFData
              .removeWhere((element) => element.adherenceId == id.toString());
        });
        Provider.of<StatsProvider>(context, listen: false)
            .updateUnapprovedFormStats();
      }
    }

    void editHrsForm(UnapprovedHrsModel unapprovedHrsModel) async {
      final db = LocalDb.instance;
      CaseLoadModel caseLoad =
          await db.getCaseLoad(int.parse(unapprovedHrsModel.ovcCpimsId!));
      RiskAssessmentFormModel riskAssessmentFormModel =
          context.read<HIVAssessmentProvider>().riskAssessmentFormModel;
      context
          .read<HIVAssessmentProvider>()
          .updateRiskAssessmentModel(riskAssessmentFormModel.copyWith(
            formUuid: unapprovedHrsModel.formUuid,
            dateOfAssessment: unapprovedHrsModel.dateOfAssessment,
            statusOfChild: unapprovedHrsModel.statusOfChild == "true" ? "Yes" : "No",
            hivStatus: unapprovedHrsModel.hivStatus,
            hivTestDone: unapprovedHrsModel.hivTestDone == "true" ? "Yes" : "No",
            biologicalFather: unapprovedHrsModel.biologicalFather == "true" ? "Yes" : "No",
            malnourished: unapprovedHrsModel.malnourished == "true" ? "Yes" : "No",
            sexualAbuse: unapprovedHrsModel.sexualAbuse == "true" ? "Yes" : "No",
            sexualAbuseAdolescent: unapprovedHrsModel.sexualAbuseAdolescent == "true" ? "Yes" : "No",
            traditionalProcedures: unapprovedHrsModel.traditionalProcedures == "true" ? "Yes" : "No",
            persistentlySick: unapprovedHrsModel.persistentlySick,
            tb: unapprovedHrsModel.tb,
            sexualIntercourse: unapprovedHrsModel.sexualIntercourse,
            symptomsOfSTI: unapprovedHrsModel.symptomsOfSTI,
            ivDrugUser: unapprovedHrsModel.ivDrugUser,
            finalEvaluation: unapprovedHrsModel.finalEvaluation == "true" ? "Yes" : "No",
            parentAcceptHivTesting: unapprovedHrsModel.parentAcceptHivTesting == "true" ? "Yes" : "No",
            parentAcceptHivTestingDate:
                unapprovedHrsModel.parentAcceptHivTestingDate,
            formalReferralMade: unapprovedHrsModel.formalReferralMade == "true" ? "Yes" : "No",
            formalReferralMadeDate: unapprovedHrsModel.formalReferralMadeDate,
            formalReferralCompleted: unapprovedHrsModel.formalReferralCompleted == "true" ? "Yes" : "No",
            formalReferralCompletedDate:
                unapprovedHrsModel.formalReferralCompletedDate,
            reasonForNotMakingReferral:
                unapprovedHrsModel.reasonForNotMakingReferral,
            hivTestResult: unapprovedHrsModel.hivTestResult,
            referredForArt: unapprovedHrsModel.referredForArt == "true" ? "Yes" : "No",
            referredForArtDate: unapprovedHrsModel.referredForArtDate,
            artReferralCompleted: unapprovedHrsModel.artReferralCompleted == "true" ? "Yes" : "No",
            artReferralCompletedDate:
                unapprovedHrsModel.artReferralCompletedDate,
            facilityOfArtEnrollment: unapprovedHrsModel.facilityOfArtEnrollment,
          ));

      await Future.delayed(const Duration(milliseconds: 200));

      context.read<HIVAssessmentProvider>();
      Get.to(() => HIVAssessmentScreen(caseLoadModel: caseLoad));
      Provider.of<StatsProvider>(context, listen: false)
          .updateUnapprovedFormStats();
    }

    void deleteUnapprovedHrs(String? id) async {
      bool success = await UnapprovedDataService.deleteUnapprovedHrs(id!);
      if (success) {
        setState(() {
          unapprovedHRSData.removeWhere((element) => element.riskId == id);
        });
        Provider.of<StatsProvider>(context, listen: false)
            .updateUnapprovedFormStats();
      }
    }

    void editGraduationForm(
        UnApprovedGraduationFormModel unapprovedGraduationForm) async {
      final db = LocalDb.instance;
      CaseLoadModel caseLoad =
          await db.getCaseLoad(int.parse(unapprovedGraduationForm.ovcCpimsId!));
      GraduationMonitoringFormModel graduationMonitoringFormModel = context
          .read<GraduationMonitoringProvider>()
          .graduationMonitoringFormModel;

      context
          .read<GraduationMonitoringProvider>()
          .updateGraduationMonitoringModel(
            graduationMonitoringFormModel.copyWith(
              formType: unapprovedGraduationForm.formType,
              dateOfMonitoring: unapprovedGraduationForm.dateOfMonitoring,
              benchmark1: unapprovedGraduationForm.benchmark1,
              benchmark2: unapprovedGraduationForm.benchmark2,
              benchmark3: unapprovedGraduationForm.benchmark3,
              benchmark4: unapprovedGraduationForm.benchmark4,
              benchmark5: unapprovedGraduationForm.benchmark5,
              benchmark6: unapprovedGraduationForm.benchmark6,
              benchmark7: unapprovedGraduationForm.benchmark7,
              benchmark8: unapprovedGraduationForm.benchmark8,
              benchmark9: unapprovedGraduationForm.benchmark9,
              householdReadyToExit:
                  unapprovedGraduationForm.householdReadyToExit,
              caseDeterminedReadyForClosure:
                  unapprovedGraduationForm.caseDeterminedReadyForClosure,
            ),
          );

      await Future.delayed(const Duration(milliseconds: 300));
      context.read<GraduationMonitoringProvider>();
      Get.to(() => GraduationMonitoringFormScreen(caseLoad: caseLoad));
      Provider.of<StatsProvider>(context, listen: false)
          .updateUnapprovedFormStats();
    }

    void deleteUnapprovedGraduationForm(String? id) async {
      bool success =
          await UnapprovedDataService.deleteUnapprovedgraduation(id!);
      if (success) {
        setState(() {
          unnapprovedGraduationData
              .removeWhere((element) => element.formUuid == id);
        });
        Provider.of<StatsProvider>(context, listen: false)
            .updateUnapprovedFormStats();
      }
    }

    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (selectedRecord == 'CPT')
              ChildDetailsCard(
                unapprovedRecords: unapprovedCaseplanData,
                selectedRecord: selectedRecord,
                onDelete: deleteUnapprovedCPT,
                onEdit: editUnapprovedCptForm,
              ),
            if (selectedRecord == "CPARA")
              const Expanded(child: UnnaprovedCparaScreen()),
            if (selectedRecord == "HMF")
              UnapprovedHMFList(
                  unapprovedHMFData: unapprovedHMFData,
                  onEdit: editHMF,
                  onDelete: deleteUnapprovedHMF),
            if (selectedRecord == "HRS")
              UnapprovedHRSList(
                  unapprovedHrsData: unapprovedHRSData,
                  onEdit: editHrsForm,
                  onDelete: deleteUnapprovedHrs),
            if (selectedRecord == "CPA")
              UnapprovedGraduationList(
                  unapprovedGraduationData: unnapprovedGraduationData,
                  onEdit: editGraduationForm,
                  onDelete: deleteUnapprovedGraduationForm),
            if (selectedRecord == unapprovedRecords[0])
              Expanded(
                child: FormTab(
                  selectedRecord: selectedRecord,
                  unapprovedForm1aData: unapprovedForm1AData,
                  onDelete: deleteUnapprovedForm1,
                  onEdit: editUnapprovedForm1,
                ),
              ),
            if (selectedRecord == unapprovedRecords[1])
              Expanded(
                child: FormTab(
                  selectedRecord: selectedRecord,
                  unapprovedForm1aData: unapprovedForm1BData,
                  onDelete: deleteUnapprovedForm1,
                  onEdit: editUnapprovedForm1,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class FormTab extends StatelessWidget {
  final String selectedRecord;
  final List<UnapprovedForm1DataModel>? unapprovedForm1aData;
  final Function(int) onDelete;
  final Function(UnapprovedForm1DataModel) onEdit;

  const FormTab({
    super.key,
    required this.selectedRecord,
    this.unapprovedForm1aData,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        CustomCard(
          title: 'Unapproved $selectedRecord List',
          children: [
            if (selectedRecord == "Form 1A" || selectedRecord == "Form 1B")
              ...List.generate(
                unapprovedForm1aData!.length,
                (index) {
                  final UnapprovedForm1DataModel dataModel =
                      unapprovedForm1aData![index];
                  return UnapprovedForm1CardDetails<UnapprovedForm1DataModel>(
                    unapprovedData: dataModel,
                    eventOrDomainId: dataModel.services[0].domainId,
                    isService: true,
                    onDelete: onDelete,
                    onEdit: onEdit,
                  );
                },
              )
          ],
        ),
      ],
    );
  }
}

class ChildDetailsCard<T> extends StatelessWidget {
  final List<UnapprovedCasePlanModel> unapprovedRecords;
  final String selectedRecord;
  final Function(int)? onDelete;
  final Function(UnapprovedCasePlanModel) onEdit;

  const ChildDetailsCard({
    super.key,
    required this.unapprovedRecords,
    required this.selectedRecord,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          CustomCard(
            title: 'Unapproved $selectedRecord Forms',
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                    itemCount: unapprovedRecords.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, index) {
                      final UnapprovedCasePlanModel unapprovedRecord =
                          unapprovedRecords[index];
                      return UnapprovedCasePlanFormDetails(
                        unapprovedRecord: unapprovedRecord,
                        onDelete: (int) {
                          onDelete!(int);
                        },
                        onEdit: onEdit,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UnapprovedCasePlanFormDetails extends StatelessWidget {
  final UnapprovedCasePlanModel unapprovedRecord;
  final Function(int) onDelete;
  final Function(UnapprovedCasePlanModel) onEdit;

  const UnapprovedCasePlanFormDetails({
    super.key,
    required this.unapprovedRecord,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "CPIMS ID: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  unapprovedRecord.ovcCpimsId,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () async {
                      await onEdit(unapprovedRecord);
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () async {
                      await onDelete(unapprovedRecord.id ?? 0);
                    },
                    icon: const Icon(Icons.delete)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Text(
                      "Message here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      unapprovedRecord.dateOfEvent,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  unapprovedRecord.message,
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Visibility(
              visible: unapprovedRecord.services.isNotEmpty,
              child: const Text(
                "Services",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Visibility(
                visible: unapprovedRecord.services.isNotEmpty,
                child: Column(
                  children: unapprovedRecord.services
                      .asMap()
                      .entries
                      .map((e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "#${e.key}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Domain: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(e.value.domainId),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Goal: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(e.value.goalId),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Gap: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(e.value.gapId),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Priority: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(e.value.priorityId),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Result: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(e.value.resultsId),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Reason: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(e.value.reasonId),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Service IDs",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    e.value.serviceIds.join(', '),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Responsible IDs",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    e.value.responsibleIds.join(', '),
                                  ),
                                ],
                              ),
                            ],
                          ))
                      .toList(),
                )),
          ],
        ),
      ),
    );
  }
}

class UnapprovedForm1CardDetails<T> extends StatelessWidget {
  // list with a type of unapproved data model
  final UnapprovedForm1DataModel unapprovedData;
  final String? eventOrDomainId;
  final bool isService;
  final Function(int) onDelete;
  final Function(UnapprovedForm1DataModel) onEdit;

  const UnapprovedForm1CardDetails({
    super.key,
    required this.unapprovedData,
    this.eventOrDomainId,
    required this.isService,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const Text(
                  "CPIMS ID: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  unapprovedData.ovcCpimsId,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () async {
                      await onEdit(unapprovedData);
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () async {
                      await onDelete(unapprovedData.localId ?? 0);
                    },
                    icon: const Icon(Icons.delete)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Text(
                      "Message",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      unapprovedData.dateOfEvent,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  unapprovedData.message,
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Visibility(
              visible: unapprovedData.services.isNotEmpty,
              child: const Text(
                "Services",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Visibility(
                visible: unapprovedData.services.isNotEmpty,
                child: Column(
                  children: unapprovedData.services
                      .map((e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "ID: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(e.serviceId.toString()),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Domain: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(e.domainId),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                "Message",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                e.message ?? 'Unknown',
                              ),
                              const SizedBox(
                                height: 8,
                              )
                            ],
                          ))
                      .toList(),
                )),
            const SizedBox(
              height: 4,
            ),
            Visibility(
              visible: unapprovedData.criticalEvents.isNotEmpty,
              child: const Text(
                "Critical Events",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Visibility(
                visible: unapprovedData.criticalEvents.isNotEmpty,
                child: Column(
                  children: unapprovedData.criticalEvents
                      .map((e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Row(
                                    children: [
                                      const Text(
                                        "ID: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(e.eventId),
                                    ],
                                  )),
                                  Expanded(
                                      child: Row(
                                    children: [
                                      const Text(
                                        "Date: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(e.eventDate),
                                    ],
                                  )),
                                ],
                              ),
                              const Text(
                                "Message",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                e.message ?? 'Unknown',
                              ),
                              const SizedBox(
                                height: 8,
                              )
                            ],
                          ))
                      .toList(),
                )),
          ],
        ),
      ),
    );
  }
}

class UnapprovedHMFList extends StatelessWidget {
  final List<UnApprovedHivManagementForm> unapprovedHMFData;
  final Function(UnApprovedHivManagementForm) onEdit;
  final Function(String) onDelete;

  const UnapprovedHMFList({
    super.key,
    required this.unapprovedHMFData,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: unapprovedHMFData.length,
      itemBuilder: (BuildContext context, int index) {
        final UnApprovedHivManagementForm unapprovedHMF =
            unapprovedHMFData[index];
        return UnapprovedHMFCard(
          unapprovedHMF: unapprovedHMF,
          onEdit: onEdit,
          onDelete: onDelete,
        );
      },
    ));
  }
}

class UnapprovedHMFCard extends StatelessWidget {
  final UnApprovedHivManagementForm unapprovedHMF;
  final Function(UnApprovedHivManagementForm) onEdit;
  final Function(String) onDelete;

  const UnapprovedHMFCard({
    super.key,
    required this.unapprovedHMF,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('CPIMS ID: ${unapprovedHMF.ovcCpimsId}'),
        subtitle: Text('Reason For rejection: ${unapprovedHMF.message}'),
        onTap: () {
          onEdit(unapprovedHMF);
        },
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => onEdit(unapprovedHMF),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onDelete(unapprovedHMF.adherenceId!),
            ),
          ],
        ),
      ),
    );
  }
}

class UnapprovedHRSList extends StatelessWidget {
  final List<UnapprovedHrsModel> unapprovedHrsData;
  final Function(UnapprovedHrsModel) onEdit;
  final Function(String?) onDelete;

  const UnapprovedHRSList({
    super.key,
    required this.unapprovedHrsData,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: unapprovedHrsData.length,
        itemBuilder: (BuildContext context, int index) {
          final UnapprovedHrsModel unapprovedHrsModel =
              unapprovedHrsData[index];
          return UnapprovedHrsCard(
            unapprovedHrs: unapprovedHrsModel,
            onEdit: onEdit,
            onDelete: onDelete,
          );
        },
      ),
    );
  }
}

class UnapprovedHrsCard extends StatelessWidget {
  final UnapprovedHrsModel unapprovedHrs;
  final Function(UnapprovedHrsModel) onEdit;
  final Function(String) onDelete;

  const UnapprovedHrsCard({
    super.key,
    required this.unapprovedHrs,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('CPIMS ID: ${unapprovedHrs.ovcCpimsId}'),
        subtitle: Text('Reason For rejection: ${unapprovedHrs.message}'),
        onTap: () {
          onEdit(unapprovedHrs);
        },
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => onEdit(unapprovedHrs),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onDelete(unapprovedHrs.riskId!),
            ),
          ],
        ),
      ),
    );
  }
}

class UnapprovedGraduationList extends StatelessWidget {
  final List<UnApprovedGraduationFormModel> unapprovedGraduationData;
  final Function(UnApprovedGraduationFormModel) onEdit;
  final Function(String) onDelete;

  const UnapprovedGraduationList({
    super.key,
    required this.unapprovedGraduationData,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: unapprovedGraduationData.length,
        itemBuilder: (BuildContext context, int index) {
          final UnApprovedGraduationFormModel unapprovedGraduationForm =
              unapprovedGraduationData[index];
          return UnapprovedGraduationCard(
            unapprovedGraduationForm: unapprovedGraduationForm,
            onEdit: onEdit,
            onDelete: onDelete,
          );
        },
      ),
    );
  }
}

class UnapprovedGraduationCard extends StatelessWidget {
  final UnApprovedGraduationFormModel unapprovedGraduationForm;
  final Function(UnApprovedGraduationFormModel) onEdit;
  final Function(String) onDelete;

  const UnapprovedGraduationCard({
    super.key,
    required this.unapprovedGraduationForm,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('CPIMS ID: ${unapprovedGraduationForm.ovcCpimsId}'),
        subtitle:
            Text('Reason For rejection: ${unapprovedGraduationForm.message}'),
        onTap: () {
          onEdit(unapprovedGraduationForm);
        },
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => onEdit(unapprovedGraduationForm),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onDelete(unapprovedGraduationForm.formUuid!),
            ),
          ],
        ),
      ),
    );
  }
}

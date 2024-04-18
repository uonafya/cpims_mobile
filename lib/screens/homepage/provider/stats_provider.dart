import 'package:flutter/foundation.dart';
import '../../../services/form_service.dart';

class StatsProvider extends ChangeNotifier {
  int formOneACount = 0;
  int formOneBCount = 0;
  int formOneADistictCount = 0;
  int formOneBDistictCount = 0;
  int casePlanDistinctCount = 0;
  int cparaDistinctCount = 0;
  int hrsDistinctCount = 0;
  int hmfDistinctCount = 0;
  int cparaCount = 0;
  int cptCount = 0;
  int hrsCount = 0;
  int hmfCount = 0;
  int graduationMonitoringFormCount = 0;
  int distinctGraduationMonitoringForm = 0;

  //unnapproved forms
  int unapprovedFormOneACount = 0;
  int unapprovedFormOneBCount = 0;
  int unapprovedFormOneADistictCount = 0;
  int unapprovedFormOneBDistictCount = 0;
  int unapprovedCasePlanDistinctCount = 0;
  int unapprovedCparaDistinctCount = 0;
  int unapprovedHrsDistinctCount = 0;
  int unapprovedHmfDistinctCount = 0;
  int unapprovedCparaCount = 0;
  int unapprovedCptCount = 0;
  int unapprovedHrsCount = 0;
  int unapprovedHmfCount = 0;
  int unapprovedGraduationMonitoringFormCount = 0;
  int unapprovedDistinctGraduationMonitoringForm = 0;

  void updateFormStats() async {
    formOneACount = await Form1Service.getCountAllFormOneA() ?? 0;
    formOneBCount = await Form1Service.getCountAllFormOneB() ?? 0;
    formOneADistictCount =
        await Form1Service.getCountAllFormOneADistinct() ?? 0;
    debugPrint('formOneADistictCount: $formOneADistictCount');
    formOneBDistictCount =
        await Form1Service.getCountAllFormOneBDistinct() ?? 0;
    debugPrint('formOneBDistictCount: $formOneBDistictCount');
    cparaCount = await Form1Service.getCountAllFormCpara() ?? 0;
    cptCount = await CasePlanService.getCaseplanUnsyncedCount() ?? 0;
    hrsCount = await CasePlanService.getCountOfHRSForms() ?? 0;
    hmfCount = await CasePlanService.getCountOfHmfForms() ?? 0;
    casePlanDistinctCount =
        await CasePlanService.getCaseplanUnsyncedCountDistict() ?? 0;
    cparaDistinctCount = await Form1Service.getCountAllFormCparaDistinct() ?? 0;
    hrsDistinctCount = await CasePlanService.getCountOfHRSFormsDistinct() ?? 0;
    hmfDistinctCount = await CasePlanService.getCountOfHmfFormsDistinct() ?? 0;
    graduationMonitoringFormCount =
        await CasePlanService.getCountOnUnsycedGraduationForms() ?? 0;
    distinctGraduationMonitoringForm =
        await CasePlanService.getCountOnUnsycedGraduationFormsDistinct() ?? 0;

    unapprovedFormOneACount =
        await Form1Service.getCountAllFormOneAUnApproved() ?? 0;
    unapprovedFormOneBCount =
        await Form1Service.getCountAllFormOneBUnApproved() ?? 0;
    unapprovedCparaCount = await Form1Service.countCparaUnApprovedForms() ?? 0;
    unapprovedCptCount =
        await CasePlanService.getAllUnApprovedCaseplanCount() ?? 0;
    unapprovedHrsCount =
        await CasePlanService.getCountOfHRSFormsUnApproved() ?? 0;
    unapprovedHmfCount =
        await CasePlanService.getCountOfRejectedHmfForms() ?? 0;
    unapprovedGraduationMonitoringFormCount =
        await CasePlanService.getCountOfRejectedGraduationForms() ?? 0;

    notifyListeners();
  }

  void updateCparaFormStats() async {
    cparaCount = await Form1Service.getCountAllFormCpara() ?? 0;
    notifyListeners();
  }

  void updateFormOneAStats() async {
    formOneACount = await Form1Service.getCountAllFormOneA() ?? 0;
    notifyListeners();
  }

  void updateFormOneBStats() async {
    formOneBCount = await Form1Service.getCountAllFormOneB() ?? 0;
    notifyListeners();
  }

  void updateCptStats() async {
    cptCount = await CasePlanService.getCaseplanUnsyncedCount() ?? 0;
    notifyListeners();
  }

  void updateHrsStats() async {
    hrsCount = await CasePlanService.getCountOfHRSForms() ?? 0;
    notifyListeners();
  }

  void updateHmfStats() async {
    hmfCount = await CasePlanService.getCountOfHmfForms() ?? 0;
    notifyListeners();
  }

  void updateFormOneADistinctStats() async {
    formOneADistictCount =
        await Form1Service.getCountAllFormOneADistinct() ?? 0;
    notifyListeners();
  }

  void updateFormOneBDistinctStats() async {
    formOneBDistictCount =
        await Form1Service.getCountAllFormOneBDistinct() ?? 0;
    notifyListeners();
  }

  void updateCasePlanDistinctStats() async {
    casePlanDistinctCount =
        await CasePlanService.getCaseplanUnsyncedCountDistict() ?? 0;
    notifyListeners();
  }

  void updateCparaDistinctStats() async {
    cparaDistinctCount = await Form1Service.getCountAllFormCparaDistinct() ?? 0;
    notifyListeners();
  }

  void updateHrsDistinctStats() async {
    hrsDistinctCount = await CasePlanService.getCountOfHRSFormsDistinct() ?? 0;
    notifyListeners();
  }

  void updateHmfDistinctStats() async {
    hmfDistinctCount = await CasePlanService.getCountOfHmfFormsDistinct() ?? 0;
    notifyListeners();
  }

  void updateGraduationMonitoringFormStats() async {
    graduationMonitoringFormCount =
        await CasePlanService.getCountOnUnsycedGraduationForms() ?? 0;
    notifyListeners();
  }

  void updateDistinctGraduationMonitoringFormStats() async {
    distinctGraduationMonitoringForm =
        await CasePlanService.getCountOnUnsycedGraduationFormsDistinct() ?? 0;
    notifyListeners();
  }

  void updateUnapprovedFormOneAStats() async {
    unapprovedFormOneACount =
        await Form1Service.getCountAllFormOneAUnApproved() ?? 0;
    notifyListeners();
  }

  void updateUnapprovedFormOneBDistinctStats() async {
    unapprovedFormOneBDistictCount =
        await Form1Service.getCountAllFormOneBDistinct() ?? 0;
    notifyListeners();
  }

  void updateUnapprovedCasePlanDistinctStats() async {
    unapprovedCasePlanDistinctCount =
        await CasePlanService.getAllUnApprovedCaseplanCount() ?? 0;
    notifyListeners();
  }

  void updateUnapprovedCparaDistinctStats() async {
    unapprovedCparaDistinctCount =
        await Form1Service.countCparaUnApprovedForms() ?? 0;
    notifyListeners();
  }

  void updateUnapprovedHrsDistinctStats() async {
    unapprovedHrsDistinctCount =
        await CasePlanService.getCountOfHRSFormsUnApproved() ?? 0;
    notifyListeners();
  }

  void updateUnapprovedHmfDistinctStats() async {
    unapprovedHmfDistinctCount =
        await CasePlanService.getCountOfRejectedHmfForms() ?? 0;
    notifyListeners();
  }

  void updateUnapprovedGraduationMonitoringFormStats() async {
    unapprovedGraduationMonitoringFormCount =
        await CasePlanService.getCountOfRejectedGraduationForms() ?? 0;
    notifyListeners();
  }

  

  void updateUnapprovedFormStats() async {
    debugPrint('Updating form counter.....');
    unapprovedFormOneACount =
        await Form1Service.getCountAllFormOneAUnApproved() ?? 0;
    unapprovedFormOneBCount =
        await Form1Service.getCountAllFormOneBUnApproved() ?? 0;
    unapprovedCparaCount = await Form1Service.countCparaUnApprovedForms() ?? 0;
    unapprovedCptCount =
        await CasePlanService.getAllUnApprovedCaseplanCount() ?? 0;
    unapprovedHrsCount =
        await CasePlanService.getCountOfHRSFormsUnApproved() ?? 0;
    unapprovedHmfCount =
        await CasePlanService.getCountOfRejectedHmfForms() ?? 0;
    unapprovedGraduationMonitoringFormCount =
        await CasePlanService.getCountOfRejectedGraduationForms() ?? 0;

    notifyListeners();
  }
}

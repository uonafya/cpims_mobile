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

  void updateFormStats() async {
    formOneACount = await Form1Service.getCountAllFormOneA() ?? 0;
    formOneBCount = await Form1Service.getCountAllFormOneB() ?? 0;
    formOneADistictCount = await Form1Service.getCountAllFormOneADistinct() ?? 0;
    debugPrint('formOneADistictCount: $formOneADistictCount');
    formOneBDistictCount = await Form1Service.getCountAllFormOneBDistinct() ?? 0;
    debugPrint('formOneBDistictCount: $formOneBDistictCount');
    cparaCount = await Form1Service.getCountAllFormCpara() ?? 0;
    cptCount = await CasePlanService.getCaseplanUnsyncedCount() ?? 0;
    hrsCount = await CasePlanService.getCountOfHRSForms() ?? 0;
    hmfCount = await CasePlanService.getCountOfHmfForms() ?? 0;
    casePlanDistinctCount = await CasePlanService.getCaseplanUnsyncedCountDistict() ?? 0;
    // cparaDistinctCount = await CasePlanService.getCountOfCparaFormsDistinct() ?? 0;
    hrsDistinctCount = await CasePlanService.getCountOfHRSFormsDistinct() ?? 0;
    hmfDistinctCount = await CasePlanService.getCountOfHmfFormsDistinct() ?? 0;

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
    formOneADistictCount = await Form1Service.getCountAllFormOneADistinct() ?? 0;
    notifyListeners();
  }

  void updateFormOneBDistinctStats() async {
    formOneBDistictCount = await Form1Service.getCountAllFormOneBDistinct() ?? 0;
    notifyListeners();
  }

  void updateCasePlanDistinctStats() async {
    casePlanDistinctCount = await CasePlanService.getCaseplanUnsyncedCountDistict() ?? 0;
    notifyListeners();
  }

  // void updateCparaDistinctStats() async {
  //   cparaDistinctCount = await CasePlanService.getCountOfCparaFormsDistinct() ?? 0;
  //   notifyListeners();
  // }
  //
  void updateHrsDistinctStats() async {
    hrsDistinctCount = await CasePlanService.getCountOfHRSFormsDistinct() ?? 0;
    notifyListeners();
  }

  void updateHmfDistinctStats() async {
    hmfDistinctCount = await CasePlanService.getCountOfHmfFormsDistinct() ?? 0;
    notifyListeners();
  }
}

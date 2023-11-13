import 'package:flutter/foundation.dart';
import '../../../services/form_service.dart';

class StatsProvider extends ChangeNotifier {
  int formOneACount = 0;
  int formOneBCount = 0;
  int cparaCount = 0;
  int cptCount = 0;
  int hrsCount = 0;
  int hmfCount = 0;

  void updateFormStats() async {
    formOneACount = await Form1Service.getCountAllFormOneA() ?? 0;
    formOneBCount = await Form1Service.getCountAllFormOneB() ?? 0;
    cparaCount = await Form1Service.getCountAllFormCpara() ?? 0;
    cptCount = await CasePlanService.getCaseplanUnsyncedCount() ?? 0;
    hrsCount = await CasePlanService.getCountOfHRSForms() ?? 0;
    hmfCount = await CasePlanService.getCountOfHmfForms() ?? 0;
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
}

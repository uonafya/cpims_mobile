import 'package:cpims_mobile/Models/case_load.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/services/caseload_service.dart';
import 'package:flutter/material.dart';

class UIProvider with ChangeNotifier {
  int selectedDrawerOption = 0;
  List<CaseLoadModel>? _caseLoadData;

  List<CaseLoadModel>? get caseLoadData => _caseLoadData;

  void changeDrawerOption(int value) {
    selectedDrawerOption = value;
    notifyListeners();
  }

  var _getDashData;
  get getDashData => _getDashData;

  setDashData(_) {
    _getDashData = _;

    notifyListeners();
  }

  Future<void> setCaseLoadData() async {
    final caseLoadData = await CaseLoadDb.instance.retrieveCaseLoads();

    _caseLoadData = caseLoadData;

    print(caseLoadData.length);
    notifyListeners();
  }
}

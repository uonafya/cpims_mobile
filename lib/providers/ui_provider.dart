import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
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
    final data = await LocalDb.instance.retrieveCaseLoads();

    _caseLoadData = data;

    notifyListeners();
  }
}

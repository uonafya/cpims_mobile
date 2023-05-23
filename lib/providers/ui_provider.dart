import 'package:flutter/material.dart';

class UIProvider with ChangeNotifier {
  int selectedDrawerOption = 0;

  void changeDrawerOption(int value) {
    selectedDrawerOption = value;
    notifyListeners();
  }

  var _getAccess;
  get getAccess => _getAccess;

  setAuthToken(_) {
    print("ui provide set access state");
    print(_);
    _getAccess = _;
  }

  var _getDashData;
  get getDashData => _getDashData;

  setDashData(_) {
    print("ui provide set access state");
    print(_);
    _getDashData = _;
  }
}

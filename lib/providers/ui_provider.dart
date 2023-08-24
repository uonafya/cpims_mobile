import 'package:flutter/material.dart';

class UIProvider with ChangeNotifier {
  int selectedDrawerOption = 0;

  void changeDrawerOption(int value) {
    selectedDrawerOption = value;
    notifyListeners();
  }

  var _getDashData;
  get getDashData => _getDashData;

  setDashData(_) {
    print("ui provide set access state");
    print(_);
    _getDashData = _;

    notifyListeners();
  }
}

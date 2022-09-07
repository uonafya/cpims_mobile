import 'package:flutter/foundation.dart';

class UIProvider with ChangeNotifier {
  int selectedDrawerOption = 0;
  void changeDrawerOption(int value) {
    selectedDrawerOption = value;
    notifyListeners();
  }
}

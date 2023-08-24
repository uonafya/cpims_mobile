import 'package:flutter/material.dart';

class Form1AProvider extends ChangeNotifier {
  int selectedStep = 0;
  void setSelectedStep(int step) {
    if (step >= 0 && step <= 1) {
      selectedStep = step;
      notifyListeners();
    } else {
      print("<<<<<<<<<Bad UI>>>>>>>>>>>");
    }
  }

  // Critical Even
}

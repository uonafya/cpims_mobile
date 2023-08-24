import 'package:flutter/material.dart';

// Critical Event(s)
class Form1ACritical {
  List<dynamic>? events;
  String? date;

  Form1ACritical({this.date, this.events});
}

// Services
class Form1AService {
  List<dynamic>? domain;
  List<dynamic>? services;
  String? date;

  Form1AService({this.domain, this.services, this.date});
}

class Form1AProvider extends ChangeNotifier {
  int selectedStep = 0;
  Form1ACritical? criticalModel;
  Form1AService? serviceModel;

  void setSelectedStep(int step) {
    if (step >= 0 && step <= 1) {
      selectedStep = step;
      notifyListeners();
    } else {
      print("<<<<<<<<<Bad UI>>>>>>>>>>>");
    }
  }

  void setCriticalStep(Form1ACritical form) {
    criticalModel = Form1ACritical(
        date: form.date != null ? form.date : criticalModel?.date,
        events: form.events != null ? form.events : criticalModel?.events);
    notifyListeners();
  }

  // Critical Even
}

import 'package:flutter/foundation.dart';

class FormCompletionStatusProvider with ChangeNotifier {
  bool _artTherapyFormCompleted = false;
  bool _hivVisitationFormCompleted = false;

  bool get artTherapyFormCompleted => _artTherapyFormCompleted;
  bool get hivVisitationFormCompleted => _hivVisitationFormCompleted;

  void setArtTherapyFormCompleted(bool completed) {
    _artTherapyFormCompleted = completed;
    notifyListeners();
  }

  void setHIVVisitationFormCompleted(bool completed) {
    _hivVisitationFormCompleted = completed;
    notifyListeners();
  }
}

import 'package:cpims_mobile/screens/cpara/model/cpara_model.dart';
import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/model/health_model.dart';
import 'package:cpims_mobile/screens/cpara/model/safe_model.dart';
import 'package:cpims_mobile/screens/cpara/model/schooled_model.dart';
import 'package:cpims_mobile/screens/cpara/model/stable_model.dart';
import 'package:flutter/foundation.dart';

class CparaProvider extends ChangeNotifier {
  CparaModel? cparaModel;
  DetailModel? detailModel;
  HealthModel? healthModel;
  StableModel? stableModel;
  SafeModel? safeModel;
  SchooledModel? schooledModel;

  // Calculate schooled benchmark
  int schooledBenchmark() {
    int schooledBenchmark = 5;
    if (schooledModel?.question1 == "Yes" &&
            schooledModel?.question2 == "Yes" &&
            schooledModel?.question3 == "Yes" &&
            schooledModel?.question4 == "Yes" ||
        schooledModel?.question4 == "N/A") {
      schooledBenchmark = 1;
    } else {
      schooledBenchmark = 0;
    }
    return schooledBenchmark;
  }

  int healthyBenchmark() {
    
    return 2;
  }

// update cpara model
  void updateCparaModel(CparaModel cparaModel) {
    this.cparaModel = cparaModel;
    notifyListeners();
  }

  // update detail model
  void updateDetailModel(DetailModel detailModel) {
    this.detailModel = detailModel;
    notifyListeners();
  }

  // update health model
  void updateHealthModel(HealthModel healthModel) {
    this.healthModel = healthModel;
    notifyListeners();
  }

  // update stable model
  void updateStableModel(StableModel stableModel) {
    this.stableModel = stableModel;
    notifyListeners();
  }

  // update safe model
  void updateSafeModel(SafeModel safeModel) {
    this.safeModel = safeModel;
    notifyListeners();
  }

  // update schooled model
  void updateSchooledModel(SchooledModel schooledModel) {
    this.schooledModel = schooledModel;
    notifyListeners();
  }
}

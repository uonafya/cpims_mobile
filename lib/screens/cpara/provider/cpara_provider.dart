import 'package:cpims_mobile/screens/cpara/cpara_util.dart';
import 'package:cpims_mobile/screens/cpara/model/cpara_model.dart';
import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/model/health_model.dart';
import 'package:cpims_mobile/screens/cpara/model/safe_model.dart';
import 'package:cpims_mobile/screens/cpara/model/schooled_model.dart';
import 'package:cpims_mobile/screens/cpara/model/stable_model.dart';
import 'package:cpims_mobile/screens/cpara/widgets/cpara_schooled_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:cpims_mobile/screens/cpara/widgets/custom_radio_buttons.dart';

import '../../../Models/case_load_model.dart';

class CparaProvider extends ChangeNotifier {
  CparaModel? cparaModel;
  DetailModel? detailModel;
  HealthModel? _healthModel;
  StableModel? stableModel;
  SafeModel? safeModel;
  SchooledModel? schooledModel;
  OvcSubPopulationModel? ovcSubPopulationModel;
  CaseLoadModel? caseLoadModel;
  List<CaseLoadModel> children = [];

  // A getter for health model that will handle if _healthModel is null
  HealthModel get healthModel {
    if (_healthModel == null) {
      _healthModel = HealthModel();
      notifyListeners();
    }
    return _healthModel!;
  }

  // Function to update health model depending on the question being updated
  void updateHealthModelQuestion(
      String questionCode, RadioButtonOptions? value) {
    _healthModel ??= HealthModel();
    switch (questionCode) {
      case "q1_1":
        _healthModel!.question1 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q1_2":
        _healthModel!.question2 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q1_3":
        _healthModel!.question3 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q1_4":
        _healthModel!.question4 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q1_5":
        _healthModel!.question5 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q2_1":
        _healthModel!.question6 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q2_2":
        _healthModel!.question7 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q2_3":
        _healthModel!.question8 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q2_4":
        _healthModel!.question9 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q2_5":
        _healthModel!.question10 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q2_6":
        _healthModel!.question11 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q2_7":
        _healthModel!.question12 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q2_8":
        _healthModel!.question13 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q2_9":
        _healthModel!.question14 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q4_1":
        _healthModel!.question15 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q4_2":
        _healthModel!.question16 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q4_3":
        _healthModel!.question17 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      case "q4_4":
        _healthModel!.question18 = convertingRadioButtonOptionsToString(value);
        notifyListeners();
        break;
      // case "initial_3":
      //   setState(() {
      //     goal3InitialAnswer = value;
      //   });
      //   HealthModel healthmodel =
      //       Provider.of<CparaProvider>(context, listen: false).healthModel ??
      //           HealthModel();
      //   String overallQuestion5 = convertingRadioButtonOptionsToString(value);
      //   Provider.of<CparaProvider>(context, listen: false).updateHealthModel(
      //       healthmodel.copyWith(overallQuestion5: overallQuestion5));
      //   break;
      // case "initial_4":
      //   setState(() {
      //     goal4Initial = value;
      //   });

      //   if (value == RadioButtonOptions.no) {
      //     updateQuestion("q4_1", RadioButtonOptions.yes);
      //     updateQuestion("q4_2", RadioButtonOptions.yes);
      //     updateQuestion("q4_3", RadioButtonOptions.yes);
      //     updateQuestion("q4_4", RadioButtonOptions.yes);
      //     setState(() {
      //       childLessThan2Initial = RadioButtonOptions.yes;
      //     });
      //   }
      //   if (value == RadioButtonOptions.yes) {
      //     updateQuestion("q4_1", null);
      //     updateQuestion("q4_2", null);
      //     updateQuestion("q4_3", null);
      //     updateQuestion("q4_4", null);
      //     setState(() {
      //       childLessThan2Initial = null;
      //     });
      //   }

      //   HealthModel healthmodel =
      //       Provider.of<CparaProvider>(context, listen: false).healthModel ??
      //           HealthModel();
      //   String overallQuestion6 = convertingRadioButtonOptionsToString(value);
      //   Provider.of<CparaProvider>(context, listen: false).updateHealthModel(
      //       healthmodel.copyWith(overallQuestion6: overallQuestion6));

      //   break;
      case "initial_2":
        debugPrint("Initial 2 is being updated");
        if (value == RadioButtonOptions.yes) {
          _healthModel!.question6 = convertingRadioButtonOptionsToString(null);
          _healthModel!.question7 = convertingRadioButtonOptionsToString(null);
          _healthModel!.question8 = convertingRadioButtonOptionsToString(null);
          _healthModel!.question9 = convertingRadioButtonOptionsToString(null);
          _healthModel!.question10 = convertingRadioButtonOptionsToString(null);
          _healthModel!.question11 = convertingRadioButtonOptionsToString(null);
          _healthModel!.question12 = convertingRadioButtonOptionsToString(null);
          _healthModel!.question13 = convertingRadioButtonOptionsToString(null);
          _healthModel!.question14 = convertingRadioButtonOptionsToString(null);
        }

        if (value == RadioButtonOptions.no) {
          _healthModel!.question6 =
              convertingRadioButtonOptionsToString(RadioButtonOptions.yes);
          _healthModel!.question7 =
              convertingRadioButtonOptionsToString(RadioButtonOptions.yes);
          _healthModel!.question8 =
              convertingRadioButtonOptionsToString(RadioButtonOptions.yes);
          _healthModel!.question9 =
              convertingRadioButtonOptionsToString(RadioButtonOptions.yes);
          _healthModel!.question10 =
              convertingRadioButtonOptionsToString(RadioButtonOptions.yes);
          _healthModel!.question11 =
              convertingRadioButtonOptionsToString(RadioButtonOptions.yes);
          _healthModel!.question12 =
              convertingRadioButtonOptionsToString(RadioButtonOptions.yes);
          _healthModel!.question13 =
              convertingRadioButtonOptionsToString(RadioButtonOptions.yes);
          _healthModel!.question14 =
              convertingRadioButtonOptionsToString(RadioButtonOptions.yes);
        }
        notifyListeners();
        // HealthModel healthmodel =
        //     Provider.of<CparaProvider>(context, listen: false).healthModel ??
        //         HealthModel();
        // String overallQuestion1 = convertingRadioButtonOptionsToString(value);
        // Provider.of<CparaProvider>(context, listen: false).updateHealthModel(
        //     healthmodel.copyWith(overallQuestion1: overallQuestion1));
        break;
      // case "initial2_1":
      //   setState(() {
      //     suppresedPast12Initial = value;
      //   });
      //   if (value == RadioButtonOptions.yes) {
      //     updateQuestion("q2_1", null);
      //     updateQuestion("q2_2", null);
      //     updateQuestion("q2_3", null);
      //   }

      //   if (value == RadioButtonOptions.no) {
      //     updateQuestion("q2_1", RadioButtonOptions.yes);
      //     updateQuestion("q2_2", RadioButtonOptions.yes);
      //     updateQuestion("q2_3", RadioButtonOptions.yes);
      //   }
      //   HealthModel healthmodel =
      //       Provider.of<CparaProvider>(context, listen: false).healthModel ??
      //           HealthModel();
      //   String overallQuestion2 = convertingRadioButtonOptionsToString(value);
      //   Provider.of<CparaProvider>(context, listen: false).updateHealthModel(
      //       healthmodel.copyWith(overallQuestion2: overallQuestion2));
      //   break;
      // case "initial2_4":
      //   setState(() {
      //     documentedChildrenSuppressedInitial = value;
      //   });
      //   if (value == RadioButtonOptions.yes) {
      //     updateQuestion("q2_4", null);
      //     updateQuestion("q2_5", null);
      //     updateQuestion("q2_6", null);
      //   }

      //   if (value == RadioButtonOptions.no) {
      //     updateQuestion("q2_4", RadioButtonOptions.yes);
      //     updateQuestion("q2_5", RadioButtonOptions.yes);
      //     updateQuestion("q2_6", RadioButtonOptions.yes);
      //   }

      //   HealthModel healthmodel =
      //       Provider.of<CparaProvider>(context, listen: false).healthModel ??
      //           HealthModel();
      //   String overallQuestion3 = convertingRadioButtonOptionsToString(value);
      //   Provider.of<CparaProvider>(context, listen: false).updateHealthModel(
      //       healthmodel.copyWith(overallQuestion3: overallQuestion3));
      //   break;
      // case "initial2_7":
      //   setState(() {
      //     noDocumentCaregiverAppointmentInitial = value;
      //   });
      //   if (value == RadioButtonOptions.yes) {
      //     updateQuestion("q2_7", null);
      //     updateQuestion("q2_8", null);
      //     updateQuestion("q2_9", null);
      //   }

      //   if (value == RadioButtonOptions.no) {
      //     updateQuestion("q2_7", RadioButtonOptions.yes);
      //     updateQuestion("q2_8", RadioButtonOptions.yes);
      //     updateQuestion("q2_9", RadioButtonOptions.yes);
      //   }

      //   HealthModel healthmodel =
      //       Provider.of<CparaProvider>(context, listen: false).healthModel ??
      //           HealthModel();
      //   String overallQuestion4 = convertingRadioButtonOptionsToString(value);
      //   Provider.of<CparaProvider>(context, listen: false).updateHealthModel(
      //       healthmodel.copyWith(overallQuestion4: overallQuestion4));

      //   break;
      // case "initial4_4":
      //   setState(() {
      //     childLessThan2Initial = value;
      //   });

      //   if (value == RadioButtonOptions.no) {
      //     updateQuestion("q4_4", RadioButtonOptions.yes);
      //   }
      //   if (value == RadioButtonOptions.yes) {
      //     updateQuestion("q4_4", null);
      //   }
      //   HealthModel healthmodel =
      //       Provider.of<CparaProvider>(context, listen: false).healthModel ??
      //           HealthModel();
      //   String overallQuestion7 = convertingRadioButtonOptionsToString(value);
      //   Provider.of<CparaProvider>(context, listen: false).updateHealthModel(
      //       healthmodel.copyWith(overallQuestion7: overallQuestion7));
      //   break;
      default:
        break;
    }
  }

  // Calculate schooled benchmark
  int schooledBenchmark() {
    int schooledBenchmark = 0;

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

  // Calculate healthy benchmark
  int healthyBenchmark() {
    int finalScore = 0;
    int benchmark1 = 0;
    int benchmark2 = 0;
    int benchmark3 = 0;
    int benchmark4 = 0;

    List<String> firstListOfQuestions = [];
    List<String> secondListOfQuestions = [];
    List<String> thirdListOfQuestions = [];

    // enos implementation to avoid early initialization
    for (HealthChild child in _healthModel?.childrenQuestions ?? []) {
      // childQuestions.add(child.question1 ?? "No");
      firstListOfQuestions.add(child.question1);
      secondListOfQuestions.add(child.question2);
      thirdListOfQuestions.add(child.question3);
    }

// Health BenchMark 1 result
    if (_healthModel?.question1 == "Yes" &&
        (_healthModel?.question2 == "Yes" ||
            _healthModel?.question2 == "N/A") &&
        (_healthModel?.question3 == "Yes" ||
            _healthModel?.question3 == "N/A") &&
        _healthModel?.question4 == "Yes" &&
        (_healthModel?.question5 == "Yes" ||
            _healthModel?.question5 == "N/A")) {
      benchmark1 = 1;
      print("Benchmark 1: $benchmark1");
    } else {
      benchmark1 = 0;
      print("Benchmark 1 1: $benchmark1");
    }

// Health BenchMark 2 result
    if (_healthModel?.question6 == "Yes" &&
        (_healthModel?.question7 == "Yes" ||
            _healthModel?.question7 == "N/A") &&
        _healthModel?.question8 == "Yes" &&
        _healthModel?.question9 == "Yes" &&
        (_healthModel?.question10 == "Yes" ||
            _healthModel?.question10 == "N/A") &&
        _healthModel?.question11 == "Yes" &&
        _healthModel?.question12 == "Yes" &&
        (_healthModel?.question13 == "Yes" ||
            _healthModel?.question13 == "N/A") &&
        _healthModel?.question14 == "Yes") {
      benchmark2 = 1;
      print("Benchmark 2: $benchmark2");
    } else {
      benchmark2 = 0;
      print("Benchmark 2 2: $benchmark2");
    }

// Health BenchMark 3 result
    if (overallChildrenBenchmark(childrenOptions: firstListOfQuestions)
                .toLowerCase() ==
            "yes" &&
        overallChildrenBenchmark(childrenOptions: secondListOfQuestions)
                .toLowerCase() ==
            "yes" &&
        overallChildrenBenchmark(childrenOptions: thirdListOfQuestions)
                .toLowerCase() ==
            "yes") {
      benchmark3 = 1;
      print("Benchmark 3: $benchmark3");
    } else {
      benchmark3 = 0;
      print("Benchmark 3 3: $benchmark3");
    }

    // Health BenchMark 1 result
    if (_healthModel?.question15 == "Yes" &&
        _healthModel?.question16 == "Yes" &&
        (_healthModel?.question17 == "N/A" ||
            _healthModel?.question17 == "Yes") &&
        _healthModel?.question18 == "Yes") {
      benchmark4 = 1;
      print("Benchmark 4: $benchmark4");
    } else {
      benchmark4 = 0;
      print("Benchmark 4 4: $benchmark4");
    }

    finalScore = benchmark1 + benchmark2 + benchmark3 + benchmark4;
    if (finalScore == 4) {
      finalScore = 4;
    } else if (finalScore == 3) {
      finalScore = 3;
    } else if (finalScore == 2) {
      finalScore = 2;
    } else if (finalScore == 1) {
      finalScore = 1;
    } else if (finalScore == 0) {
      finalScore = 0;
    }
    return finalScore;
  }

// Calculate stable benchmark
  int stableBenchMark() {
    int stableBenchmark = 0;
    if (stableModel?.question1 == "Yes" ||
        stableModel?.question1 == "N/A" && stableModel?.question2 == "Yes" ||
        stableModel?.question2 == "N/A" && stableModel?.question3 == "Yes") {
      stableBenchmark = 1;
    } else {
      stableBenchmark = 0;
    }
    return stableBenchmark;
  }

// Calculate safe benchmark
  int safeBenchMark() {
    int schooledBenchmark = 44;
    int benchmark1 = 0;
    int benchmark2 = 0;
    int benchmark3 = 0;

    List<String> childQuestions = [];

    for (SafeChild child in safeModel?.childrenQuestions ?? []) {
      childQuestions.add(child.question1 ?? "No");
    }

    // bool isAllChildrenYes = overallChildrenBenchmark(childrenOptions: childQuestions).toLowerCase() == "yes";

    if (safeModel?.overallQuestion1 == "No" ||
        safeModel?.question1 == "Yes" &&
            safeModel?.question2 == "Yes" &&
            // safeModel?.question3 == "Yes" &&
            safeModel?.question4 == "Yes" &&
            safeModel?.question5 == "Yes" &&
            overallChildrenBenchmark(childrenOptions: childQuestions)
                    .toLowerCase() ==
                "yes") {
      benchmark1 = 1;
    } else {
      benchmark1 = 0;
    }

// Safe Benchmark 2 result
    if (safeModel?.question6 == "Yes" && safeModel?.question7 == "Yes") {
      benchmark2 = 1;
    } else {
      benchmark2 = 0;
    }

// Safe Benchmark 3 result
    if (safeModel?.question7 == "Yes") {
      benchmark3 = 1;
    } else {
      benchmark3 = 0;
    }

    schooledBenchmark = benchmark1 + benchmark2 + benchmark3;
    if (schooledBenchmark == 3) {
      schooledBenchmark = 3;
    } else if (schooledBenchmark == 2) {
      schooledBenchmark = 2;
    } else if (schooledBenchmark == 1) {
      schooledBenchmark = 1;
    } else if (schooledBenchmark == 0) {
      schooledBenchmark = 0;
    }
    return schooledBenchmark;
  }

// Calculate final benchmark
  int finalScore() {
    int finalBenchmarkScore = schooledBenchmark() +
        healthyBenchmark() +
        stableBenchMark() +
        safeBenchMark();

    return finalBenchmarkScore;
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
    _healthModel = healthModel;
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

  void updateOvcSubPopulationModel(
      OvcSubPopulationModel ovcSubPopulationModel) {
    this.ovcSubPopulationModel = ovcSubPopulationModel;
    notifyListeners();
  }

  void updateCaseLoadModel(CaseLoadModel caseLoadModel) {
    this.caseLoadModel = caseLoadModel;
    notifyListeners();
  }

  void updateChildren(List<CaseLoadModel> allChildren) {
    children = allChildren
        .where((element) =>
            element.caregiverNames == caseLoadModel?.caregiverNames)
        .toList();
    notifyListeners();
  }

  void clearCparaProvider() {
    cparaModel = null;
    detailModel = null;
    _healthModel = null;
    stableModel = null;
    safeModel = null;
    schooledModel = null;
    // ovcSubPopulationModel = null;
    // caseLoadModel = null;
    // children = [];
    notifyListeners();
  }
}

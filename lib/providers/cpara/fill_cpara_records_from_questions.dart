import 'package:cpims_mobile/Models/unnaproved_cpara_data.dart';
import 'package:cpims_mobile/providers/cpara/unapproved_cpara_database.dart';
import 'package:cpims_mobile/providers/db_provider.dart';

import '../../screens/cpara/model/cpara_question_ids.dart';
import '../../screens/cpara/model/health_model.dart';
import '../../screens/cpara/model/ovc_model.dart';
import '../../screens/cpara/model/safe_model.dart';

Future<UnapprovedCparaModel> fillCparaFromQuestions(
    UnapprovedCparaModel model, String ovcID, List<Map> forms) async {
  List<String> healthChildren = [];
  List<String> safeChildren = [];
  List<String> ovcChildren = [];

  // Get instance of db
  var db = LocalDb.instance;

  for (var form in forms) {
    switch (form['question_code']) {
      // Stable
      case CparaQuestionIds.stableQuestion1:
        model.stable.question1 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.stableQuestion2:
        model.stable.question2 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.stableQuestion3:
        model.stable.question2 = form['answer_id'] ?? "";
        break;
      // Schooled
      case CparaQuestionIds.schooledQuestion1:
        model.schooled.question1 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.schooledQuestion2:
        model.schooled.question2 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.schooledQuestion3:
        model.schooled.question3 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.schooledQuestion4:
        model.schooled.question4 = form['answer_id'] ?? "";
        break;
      // Detail
      case CparaQuestionIds.detailDateOfAssessment:
        model.detail.dateOfAssessment = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.isThisFirstCasePlanAssessment:
        model.detail.isFirstAssessment = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.previousCasePlanAssessment:
        model.detail.dateOfLastAssessment = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.houseChildHeaded:
        model.detail.isChildHeaded = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.houseHoldHavingHivExposedInfant:
        model.detail.hasHivExposedInfant = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.houseHoldHavingPregnantWoman:
        model.detail.hasPregnantOrBreastfeedingWoman = form['answer_id'] ?? "";
        break;

      // Safe
      case CparaQuestionIds.safeQuestion1:
        model.safe.question1 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.safeQuestion2:
        model.safe.question2 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.safeQuestion3:
        model.safe.question3 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.safeQuestion4:
        model.safe.question4 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.safeQuestion5:
        model.safe.question5 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.safeQuestion6:
        model.safe.question6 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.safeQuestion7:
        model.safe.question7 = form['answer_id'] ?? "";
        break;

      // Safe children
      case CparaQuestionIds.safeChildQuestion1:
        if (safeChildren.contains(form['ovc_cpims_id'])) {
          // Look for child
          for (SafeChild child in model.safe.childrenQuestions ?? []) {
            if (child.ovcId == form['ovc_cpims_id']) {
              child.question1 = form['answer_id'] ?? "";
              break;
            }
          }
        } else {
          model.safe.childrenQuestions ??= [];
          var newChild = SafeChild(
              ovcId: form['ovc_cpims_id'] ?? "",
              name: await db.getFullChildNameFromOVCID(form['ovc_cpims_id']),
              question1: form['answer_id'] ?? "");
          model.safe.childrenQuestions?.add(newChild);
          safeChildren.add(form['ovc_cpims_id']);
        }
        break;

      // OVC Children
      case CparaRemoteQuestionIds.ovcQuestion1:
        if (ovcChildren.contains(form['ovc_cpims_id'])) {
          // Look for child
          for (CparaOvcChild child
              in model.ovcSubPopulations.childrenQuestions ?? []) {
            if (child.ovcId == form['ovc_cpims_id']) {
              child.question1 = form['answer_id'] ?? "";
              child.answer1 = true;
              break;
            }
          }
        } else {
          model.ovcSubPopulations.childrenQuestions ??= [];
          var newChild = CparaOvcChild(
            ovcId: form['ovc_cpims_id'] ?? "",
            name: await db.getFullChildNameFromOVCID(form['ovc_cpims_id']),
            question1: form['answer_id'] ?? "",
            answer1: true,
            question2: null,
            question3: null,
            question4: null,
            question5: null,
            question6: null,
            question7: null,
            question8: null,
          );
          model.ovcSubPopulations.childrenQuestions?.add(newChild);
          ovcChildren.add(form['ovc_cpims_id']);
        }
        break;
      case CparaRemoteQuestionIds.ovcQuestion2:
        if (ovcChildren.contains(form['ovc_cpims_id'])) {
          // Look for child
          for (CparaOvcChild child
              in model.ovcSubPopulations.childrenQuestions ?? []) {
            if (child.ovcId == form['ovc_cpims_id']) {
              child.question2 = form['answer_id'] ?? "";
              child.answer2 = true;
              break;
            }
          }
        } else {
          model.ovcSubPopulations.childrenQuestions ??= [];
          var newChild = CparaOvcChild(
            ovcId: form['ovc_cpims_id'] ?? "",
            name: await db.getFullChildNameFromOVCID(form['ovc_cpims_id']),
            question1: null,
            question2: form['answer_id'] ?? 'yes',
            answer2: true,
            question3: null,
            question4: null,
            question5: null,
            question6: null,
            question7: null,
            question8: null,
          );
          model.ovcSubPopulations.childrenQuestions?.add(newChild);
          ovcChildren.add(form['ovc_cpims_id']);
        }
        break;
      case CparaRemoteQuestionIds.ovcQuestion3:
        if (ovcChildren.contains(form['ovc_cpims_id'])) {
          // Look for child
          for (CparaOvcChild child
              in model.ovcSubPopulations.childrenQuestions ?? []) {
            if (child.ovcId == form['ovc_cpims_id']) {
              child.question3 = form['answer_id'] ?? "";
              child.answer3 = true;
              break;
            }
          }
        } else {
          model.ovcSubPopulations.childrenQuestions ??= [];
          var newChild = CparaOvcChild(
            ovcId: form['ovc_cpims_id'] ?? "",
            name: await db.getFullChildNameFromOVCID(form['ovc_cpims_id']),
            question1: null,
            question2: null,
            question3: form['answer_id'] ?? "yes",
            answer3: true,
            question4: null,
            question5: null,
            question6: null,
            question7: null,
            question8: null,
          );
          model.ovcSubPopulations.childrenQuestions?.add(newChild);
          ovcChildren.add(form['ovc_cpims_id']);
        }
        break;
      case CparaRemoteQuestionIds.ovcQuestion4:
        if (ovcChildren.contains(form['ovc_cpims_id'])) {
          // Look for child
          for (CparaOvcChild child
              in model.ovcSubPopulations.childrenQuestions ?? []) {
            if (child.ovcId == form['ovc_cpims_id']) {
              child.question4 = form['answer_id'] ?? "";
              child.answer4 = true;
              break;
            }
          }
        } else {
          model.ovcSubPopulations.childrenQuestions ??= [];
          var newChild = CparaOvcChild(
            ovcId: form['ovc_cpims_id'] ?? "",
            name: await db.getFullChildNameFromOVCID(form['ovc_cpims_id']),
            question1: null,
            question2: null,
            question3: null,
            question4: form['answer_id'] ?? "yes",
            answer4: true,
            question5: null,
            question6: null,
            question7: null,
            question8: null,
          );
          model.ovcSubPopulations.childrenQuestions?.add(newChild);
          ovcChildren.add(form['ovc_cpims_id']);
        }
        break;
      case CparaRemoteQuestionIds.ovcQuestion5:
        if (ovcChildren.contains(form['ovc_cpims_id'])) {
          // Look for child
          for (CparaOvcChild child
              in model.ovcSubPopulations.childrenQuestions ?? []) {
            if (child.ovcId == form['ovc_cpims_id']) {
              child.question5 = form['answer_id'] ?? "";
              child.answer5 = true;
              break;
            }
          }
        } else {
          model.ovcSubPopulations.childrenQuestions ??= [];
          var newChild = CparaOvcChild(
            ovcId: form['ovc_cpims_id'] ?? "",
            name: await db.getFullChildNameFromOVCID(form['ovc_cpims_id']),
            question1: null,
            question2: null,
            question3: null,
            question4: null,
            question5: form['answer_id'] ?? "yes",
            answer5: true,
            question6: null,
            question7: null,
            question8: null,
          );
          model.ovcSubPopulations.childrenQuestions?.add(newChild);
          ovcChildren.add(form['ovc_cpims_id']);
        }
        break;
      case CparaRemoteQuestionIds.ovcQuestion6:
        if (ovcChildren.contains(form['ovc_cpims_id'])) {
          // Look for child
          for (CparaOvcChild child
              in model.ovcSubPopulations.childrenQuestions ?? []) {
            if (child.ovcId == form['ovc_cpims_id']) {
              child.question6 = form['answer_id'] ?? "";
              child.answer6 = true;
              break;
            }
          }
        } else {
          model.ovcSubPopulations.childrenQuestions ??= [];
          var newChild = CparaOvcChild(
            ovcId: form['ovc_cpims_id'] ?? "",
            name: await db.getFullChildNameFromOVCID(form['ovc_cpims_id']),
            question1: null,
            question2: null,
            question3: null,
            question4: null,
            question5: null,
            question6: form['answer_id'] ?? "yes",
            answer6: true,
            question7: null,
            question8: null,
          );
          model.ovcSubPopulations.childrenQuestions?.add(newChild);
          ovcChildren.add(form['ovc_cpims_id']);
        }
        break;
      case CparaRemoteQuestionIds.ovcQuestion7:
        if (ovcChildren.contains(form['ovc_cpims_id'])) {
          // Look for child
          for (CparaOvcChild child
              in model.ovcSubPopulations.childrenQuestions ?? []) {
            if (child.ovcId == form['ovc_cpims_id']) {
              child.question7 = form['answer_id'] ?? "";
              child.answer7 = true;
              break;
            }
          }
        } else {
          model.ovcSubPopulations.childrenQuestions ??= [];
          var newChild = CparaOvcChild(
            ovcId: form['ovc_cpims_id'] ?? "",
            name: await db.getFullChildNameFromOVCID(form['ovc_cpims_id']),
            question1: null,
            question2: null,
            question3: null,
            question4: null,
            question5: null,
            question6: null,
            question7: form['answer_id'] ?? "yes",
            answer7: true,
            question8: null,
          );
          model.ovcSubPopulations.childrenQuestions?.add(newChild);
          ovcChildren.add(form['ovc_cpims_id']);
        }
        break;
      case CparaRemoteQuestionIds.ovcQuestion8:
        if (ovcChildren.contains(form['ovc_cpims_id'])) {
          // Look for child
          for (CparaOvcChild child
              in model.ovcSubPopulations.childrenQuestions ?? []) {
            if (child.ovcId == form['ovc_cpims_id']) {
              child.question8 = form['answer_id'] ?? "";
              child.answer8 = true;
              break;
            }
          }
        } else {
          model.ovcSubPopulations.childrenQuestions ??= [];
          var newChild = CparaOvcChild(
            ovcId: form['ovc_cpims_id'] ?? "",
            name: await db.getFullChildNameFromOVCID(form['ovc_cpims_id']),
            question1: null,
            question2: null,
            question3: null,
            question4: null,
            question5: null,
            question6: null,
            question7: null,
            question8: form['answer_id'] ?? "",
            answer8: true,
          );
          model.ovcSubPopulations.childrenQuestions?.add(newChild);
          ovcChildren.add(form['ovc_cpims_id']);
        }
        break;

      // Health Children
      case CparaQuestionIds.healthGoal3ChildQuestion1:
        if (healthChildren.contains(form['ovc_cpims_id'])) {
          // Look for child
          for (HealthChild child in model.health.childrenQuestions ?? []) {
            if (child.id == form['ovc_cpims_id']) {
              child.question1 = form['answer_id'] ?? "";
              break;
            }
          }
        } else {
          model.health.childrenQuestions ??= [];
          var newChild = HealthChild(
              id: form['ovc_cpims_id'] ?? "",
              name: await db.getFullChildNameFromOVCID(form['ovc_cpims_id']),
              question1: form['answer_id'] ?? "",
              question2: "",
              question3: "");
          model.health.childrenQuestions?.add(newChild);
          healthChildren.add(form['ovc_cpims_id']);
        }
        break;
      case CparaQuestionIds.healthGoal3ChildQuestion2:
        if (healthChildren.contains(form['ovc_cpims_id'])) {
          // Look for child
          for (HealthChild child in model.health.childrenQuestions ?? []) {
            if (child.id == form['ovc_cpims_id']) {
              child.question2 = form['answer_id'] ?? "";
              break;
            }
          }
        } else {
          model.health.childrenQuestions ??= [];
          var newChild = HealthChild(
              id: form['ovc_cpims_id'] ?? "",
              name: await db.getFullChildNameFromOVCID(form['ovc_cpims_id']),
              question1: "",
              question2: form['answer_id'] ?? "",
              question3: "");
          model.health.childrenQuestions?.add(newChild);
          healthChildren.add(form['ovc_cpims_id']);
        }
        break;
      case CparaQuestionIds.healthGoal3ChildQuestion3:
        if (healthChildren.contains(form['ovc_cpims_id'])) {
          // Look for child
          for (HealthChild child in model.health.childrenQuestions ?? []) {
            if (child.id == form['ovc_cpims_id']) {
              child.question3 = form['answer_id'] ?? "";
              break;
            }
          }
        } else {
          model.health.childrenQuestions ??= [];
          var newChild = HealthChild(
              id: form['ovc_cpims_id'] ?? "",
              name: await db.getFullChildNameFromOVCID(form['ovc_cpims_id']),
              question1: "",
              question2: "",
              question3: form['answer_id'] ?? "");
          model.health.childrenQuestions?.add(newChild);
          healthChildren.add(form['ovc_cpims_id']);
        }
        break;

      // Health
      case CparaQuestionIds.healthQuestion1:
        model.health.question1 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthQuestion2:
        model.health.question2 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthQuestion3:
        model.health.question3 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthQuestion4:
        model.health.question4 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthQuestion5:
        model.health.question5 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthGoal2Question1:
        model.health.question6 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthGoal2Question9:
        model.health.question14 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthGoal2Question2:
        model.health.question7 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthGoal2Question3:
        model.health.question8 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthGoal2Question4:
        model.health.question9 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthGoal2Question5:
        model.health.question10 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthGoal2Question6:
        model.health.question11 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthGoal2Question7:
        model.health.question12 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthGoal2Question8:
        model.health.question13 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthGoal4Question1:
        model.health.question15 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthGoal4Question2:
        model.health.question16 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthGoal4Question3:
        model.health.question17 = form['answer_id'] ?? "";
        break;
      case CparaQuestionIds.healthGoal4Question4:
        model.health.question18 = form['answer_id'] ?? "";
        break;
    }
  }

  print(model);

  return model;
}

Future<UnapprovedCparaModel> fillCparaFromJson(
    UnapprovedCparaModel model, String ovcID, List<Question>? questions, List<IndividualQuestion>? individual_questions) async {
  List<String> healthChildren = [];
  List<String> safeChildren = [];
  List<String> ovcChildren = [];

  // Get instance of db
  var db = LocalDb.instance;

  if (questions != null) {
    for (Question question in questions) {
      switch (question.questionCode) {
      // Stable
        case CparaQuestionIds.stableQuestion1:
          model.stable.question1 = question.answerId ?? "";
          break;
        case CparaQuestionIds.stableQuestion2:
          model.stable.question2 = question.answerId ?? "";
          break;
        case CparaQuestionIds.stableQuestion3:
          model.stable.question2 = question.answerId ?? "";
          break;
      // Schooled
        case CparaQuestionIds.schooledQuestion1:
          model.schooled.question1 = question.answerId ?? "";
          break;
        case CparaQuestionIds.schooledQuestion2:
          model.schooled.question2 = question.answerId ?? "";
          break;
        case CparaQuestionIds.schooledQuestion3:
          model.schooled.question3 = question.answerId ?? "";
          break;
        case CparaQuestionIds.schooledQuestion4:
          model.schooled.question4 = question.answerId ?? "";
          break;
      // Detail
        case CparaQuestionIds.detailDateOfAssessment:
          model.detail.dateOfAssessment = question.answerId ?? "";
          break;
        case CparaQuestionIds.isThisFirstCasePlanAssessment:
          model.detail.isFirstAssessment = question.answerId ?? "";
          break;
        case CparaQuestionIds.previousCasePlanAssessment:
          model.detail.dateOfLastAssessment = question.answerId ?? "";
          break;
        case CparaQuestionIds.houseChildHeaded:
          model.detail.isChildHeaded = question.answerId ?? "";
          break;
        case CparaQuestionIds.houseHoldHavingHivExposedInfant:
          model.detail.hasHivExposedInfant = question.answerId ?? "";
          break;
        case CparaQuestionIds.houseHoldHavingPregnantWoman:
          model.detail.hasPregnantOrBreastfeedingWoman = question.answerId ?? "";
          break;

      // Safe
        case CparaQuestionIds.safeQuestion1:
          model.safe.question1 = question.answerId ?? "";
          break;
        case CparaQuestionIds.safeQuestion2:
          model.safe.question2 = question.answerId ?? "";
          break;
        case CparaQuestionIds.safeQuestion3:
          model.safe.question3 = question.answerId ?? "";
          break;
        case CparaQuestionIds.safeQuestion4:
          model.safe.question4 = question.answerId ?? "";
          break;
        case CparaQuestionIds.safeQuestion5:
          model.safe.question5 = question.answerId ?? "";
          break;
        case CparaQuestionIds.safeQuestion6:
          model.safe.question6 = question.answerId ?? "";
          break;
        case CparaQuestionIds.safeQuestion7:
          model.safe.question7 = question.answerId ?? "";
          break;
      // Health
        case CparaQuestionIds.healthQuestion1:
          model.health.question1 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthQuestion2:
          model.health.question2 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthQuestion3:
          model.health.question3 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthQuestion4:
          model.health.question4 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthQuestion5:
          model.health.question5 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthGoal2Question1:
          model.health.question6 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthGoal2Question9:
          model.health.question14 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthGoal2Question2:
          model.health.question7 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthGoal2Question3:
          model.health.question8 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthGoal2Question4:
          model.health.question9 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthGoal2Question5:
          model.health.question10 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthGoal2Question6:
          model.health.question11 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthGoal2Question7:
          model.health.question12 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthGoal2Question8:
          model.health.question13 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthGoal4Question1:
          model.health.question15 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthGoal4Question2:
          model.health.question16 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthGoal4Question3:
          model.health.question17 = question.answerId ?? "";
          break;
        case CparaQuestionIds.healthGoal4Question4:
          model.health.question18 = question.answerId ?? "";
          break;
        default:
          break;
      }
    }
  } else if (individual_questions != null) {
    for (IndividualQuestion question in individual_questions) {
      switch (question.questionCode) {
      // Safe children
        case CparaQuestionIds.safeChildQuestion1:
          if (safeChildren.contains(question.ovcCpimsId)) {
            // Look for child
            for (SafeChild child in model.safe.childrenQuestions ?? []) {
              if (child.ovcId == question.ovcCpimsId) {
                child.question1 = question.answerId ?? "";
                break;
              }
            }
          } else {
            model.safe.childrenQuestions ??= [];
            var newChild = SafeChild(
                ovcId: question.ovcCpimsId ?? "",
                name: await db.getFullChildNameFromOVCID(question.ovcCpimsId),
                question1: question.answerId ?? "");
            model.safe.childrenQuestions?.add(newChild);
            safeChildren.add(question.ovcCpimsId);
          }
          break;

      // OVC Children
        case "ovc_q1":
          if (ovcChildren.contains(question.ovcCpimsId)) {
            // Look for child
            for (CparaOvcChild child
            in model.ovcSubPopulations.childrenQuestions ?? []) {
              if (child.ovcId == question.ovcCpimsId) {
                child.question1 = question.answerId ?? "";
                child.answer1 = true;
                break;
              }
            }
          } else {
            model.ovcSubPopulations.childrenQuestions ??= [];
            var newChild = CparaOvcChild(
              ovcId: question.ovcCpimsId ?? "",
              name: await db.getFullChildNameFromOVCID(question.ovcCpimsId),
              question1: question.answerId ?? "",
              answer1: true,
              question2: null,
              question3: null,
              question4: null,
              question5: null,
              question6: null,
              question7: null,
              question8: null,
            );
            model.ovcSubPopulations.childrenQuestions?.add(newChild);
            ovcChildren.add(question.ovcCpimsId);
          }
          break;
        case "ovc_q2":
          if (ovcChildren.contains(question.ovcCpimsId)) {
            // Look for child
            for (CparaOvcChild child
            in model.ovcSubPopulations.childrenQuestions ?? []) {
              if (child.ovcId == question.ovcCpimsId) {
                child.question2 = question.answerId ?? "";
                child.answer2 = true;
                break;
              }
            }
          } else {
            model.ovcSubPopulations.childrenQuestions ??= [];
            var newChild = CparaOvcChild(
              ovcId: question.ovcCpimsId ?? "",
              name: await db.getFullChildNameFromOVCID(question.ovcCpimsId),
              question1: null,
              question2: question.answerId ?? 'yes',
              answer2: true,
              question3: null,
              question4: null,
              question5: null,
              question6: null,
              question7: null,
              question8: null,
            );
            model.ovcSubPopulations.childrenQuestions?.add(newChild);
            ovcChildren.add(question.ovcCpimsId);
          }
          break;
        case "ovc_q3":
          if (ovcChildren.contains(question.ovcCpimsId)) {
            // Look for child
            for (CparaOvcChild child
            in model.ovcSubPopulations.childrenQuestions ?? []) {
              if (child.ovcId == question.ovcCpimsId) {
                child.question3 = question.answerId ?? "";
                child.answer3 = true;
                break;
              }
            }
          } else {
            model.ovcSubPopulations.childrenQuestions ??= [];
            var newChild = CparaOvcChild(
              ovcId: question.ovcCpimsId ?? "",
              name: await db.getFullChildNameFromOVCID(question.ovcCpimsId),
              question1: null,
              question2: null,
              question3: question.answerId ?? "yes",
              answer3: true,
              question4: null,
              question5: null,
              question6: null,
              question7: null,
              question8: null,
            );
            model.ovcSubPopulations.childrenQuestions?.add(newChild);
            ovcChildren.add(question.ovcCpimsId);
          }
          break;
        case "ovc_q4":
          if (ovcChildren.contains(question.ovcCpimsId)) {
            // Look for child
            for (CparaOvcChild child
            in model.ovcSubPopulations.childrenQuestions ?? []) {
              if (child.ovcId == question.ovcCpimsId) {
                child.question4 = question.answerId ?? "";
                child.answer4 = true;
                break;
              }
            }
          } else {
            model.ovcSubPopulations.childrenQuestions ??= [];
            var newChild = CparaOvcChild(
              ovcId: question.ovcCpimsId ?? "",
              name: await db.getFullChildNameFromOVCID(question.ovcCpimsId),
              question1: null,
              question2: null,
              question3: null,
              question4: question.answerId ?? "yes",
              answer4: true,
              question5: null,
              question6: null,
              question7: null,
              question8: null,
            );
            model.ovcSubPopulations.childrenQuestions?.add(newChild);
            ovcChildren.add(question.ovcCpimsId);
          }
          break;
        case "ovc_q5":
          if (ovcChildren.contains(question.ovcCpimsId)) {
            // Look for child
            for (CparaOvcChild child
            in model.ovcSubPopulations.childrenQuestions ?? []) {
              if (child.ovcId == question.ovcCpimsId) {
                child.question5 = question.answerId ?? "";
                child.answer5 = true;
                break;
              }
            }
          } else {
            model.ovcSubPopulations.childrenQuestions ??= [];
            var newChild = CparaOvcChild(
              ovcId: question.ovcCpimsId ?? "",
              name: await db.getFullChildNameFromOVCID(question.ovcCpimsId),
              question1: null,
              question2: null,
              question3: null,
              question4: null,
              question5: question.answerId ?? "yes",
              answer5: true,
              question6: null,
              question7: null,
              question8: null,
            );
            model.ovcSubPopulations.childrenQuestions?.add(newChild);
            ovcChildren.add(question.ovcCpimsId);
          }
          break;
        case "ovc_q6":
          if (ovcChildren.contains(question.ovcCpimsId)) {
            // Look for child
            for (CparaOvcChild child
            in model.ovcSubPopulations.childrenQuestions ?? []) {
              if (child.ovcId == question.ovcCpimsId) {
                child.question6 = question.answerId ?? "";
                child.answer6 = true;
                break;
              }
            }
          } else {
            model.ovcSubPopulations.childrenQuestions ??= [];
            var newChild = CparaOvcChild(
              ovcId: question.ovcCpimsId ?? "",
              name: await db.getFullChildNameFromOVCID(question.ovcCpimsId),
              question1: null,
              question2: null,
              question3: null,
              question4: null,
              question5: null,
              question6: question.answerId ?? "yes",
              answer6: true,
              question7: null,
              question8: null,
            );
            model.ovcSubPopulations.childrenQuestions?.add(newChild);
            ovcChildren.add(question.ovcCpimsId);
          }
          break;
        case "ovc_q7":
          if (ovcChildren.contains(question.ovcCpimsId)) {
            // Look for child
            for (CparaOvcChild child
            in model.ovcSubPopulations.childrenQuestions ?? []) {
              if (child.ovcId == question.ovcCpimsId) {
                child.question7 = question.answerId ?? "";
                child.answer7 = true;
                break;
              }
            }
          } else {
            model.ovcSubPopulations.childrenQuestions ??= [];
            var newChild = CparaOvcChild(
              ovcId: question.ovcCpimsId ?? "",
              name: await db.getFullChildNameFromOVCID(question.ovcCpimsId),
              question1: null,
              question2: null,
              question3: null,
              question4: null,
              question5: null,
              question6: null,
              question7: question.answerId ?? "yes",
              answer7: true,
              question8: null,
            );
            model.ovcSubPopulations.childrenQuestions?.add(newChild);
            ovcChildren.add(question.ovcCpimsId);
          }
          break;
        case "ovc_q8":
          if (ovcChildren.contains(question.ovcCpimsId)) {
            // Look for child
            for (CparaOvcChild child
            in model.ovcSubPopulations.childrenQuestions ?? []) {
              if (child.ovcId == question.ovcCpimsId) {
                child.question8 = question.answerId ?? "";
                child.answer8 = true;
                break;
              }
            }
          } else {
            model.ovcSubPopulations.childrenQuestions ??= [];
            var newChild = CparaOvcChild(
              ovcId: question.ovcCpimsId ?? "",
              name: await db.getFullChildNameFromOVCID(question.ovcCpimsId),
              question1: null,
              question2: null,
              question3: null,
              question4: null,
              question5: null,
              question6: null,
              question7: null,
              question8: question.answerId ?? "",
              answer8: true,
            );
            model.ovcSubPopulations.childrenQuestions?.add(newChild);
            ovcChildren.add(question.ovcCpimsId);
          }
          break;

      // Health Children
        case CparaQuestionIds.healthGoal3ChildQuestion1:
          if (healthChildren.contains(question.ovcCpimsId)) {
            // Look for child
            for (HealthChild child in model.health.childrenQuestions ?? []) {
              if (child.id == question.ovcCpimsId) {
                child.question1 = question.answerId ?? "";
                break;
              }
            }
          } else {
            model.health.childrenQuestions ??= [];
            var newChild = HealthChild(
                id: question.ovcCpimsId ?? "",
                name: await db.getFullChildNameFromOVCID(question.ovcCpimsId),
                question1: question.answerId ?? "",
                question2: "",
                question3: "");
            model.health.childrenQuestions?.add(newChild);
            healthChildren.add(question.ovcCpimsId);
          }
          break;
        case CparaQuestionIds.healthGoal3ChildQuestion2:
          if (healthChildren.contains(question.ovcCpimsId)) {
            // Look for child
            for (HealthChild child in model.health.childrenQuestions ?? []) {
              if (child.id == question.ovcCpimsId) {
                child.question2 = question.answerId ?? "";
                break;
              }
            }
          } else {
            model.health.childrenQuestions ??= [];
            var newChild = HealthChild(
                id: question.ovcCpimsId ?? "",
                name: await db.getFullChildNameFromOVCID(question.ovcCpimsId),
                question1: "",
                question2: question.answerId ?? "",
                question3: "");
            model.health.childrenQuestions?.add(newChild);
            healthChildren.add(question.ovcCpimsId);
          }
          break;
        case CparaQuestionIds.healthGoal3ChildQuestion3:
          if (healthChildren.contains(question.ovcCpimsId)) {
            // Look for child
            for (HealthChild child in model.health.childrenQuestions ?? []) {
              if (child.id == question.ovcCpimsId) {
                child.question3 = question.answerId ?? "";
                break;
              }
            }
          } else {
            model.health.childrenQuestions ??= [];
            var newChild = HealthChild(
                id: question.ovcCpimsId ?? "",
                name: await db.getFullChildNameFromOVCID(question.ovcCpimsId),
                question1: "",
                question2: "",
                question3: question.answerId ?? "");
            model.health.childrenQuestions?.add(newChild);
            healthChildren.add(question.ovcCpimsId);
          }
          break;
      }
    }
  }

  print(model.ovcSubPopulations);

  return model;
}
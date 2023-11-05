import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/screens/cpara/model/cpara_question_ids.dart';

import '../widgets/ovc_sub_population_form.dart';

class SubOvcModel{
  final CaseLoadModel caseLoadModel;
  final List<CheckboxQuestion> childQuestions;

  const SubOvcModel({required this.caseLoadModel, required this.childQuestions});

  SubOvcModel copyWith({CaseLoadModel? caseLoadModel, List<CheckboxQuestion>? childQuestions }){
    return SubOvcModel(
        caseLoadModel: caseLoadModel ?? this.caseLoadModel,
        childQuestions: childQuestions ?? this.childQuestions);
  }
}

class CparaOvcSubPopulation {
  final List<CparaOvcChild>? childrenQuestions;

  CparaOvcSubPopulation({
    this.childrenQuestions,
  });

  factory CparaOvcSubPopulation.fromJson(Map<String, dynamic> json) {
    return CparaOvcSubPopulation(

      childrenQuestions: json["childrenQuestions"] == null
          ? []
          : List<CparaOvcChild>.from(
          json["childrenQuestions"]!.map((x) => CparaOvcChild.fromJson(x))),
    );
  }

  @override
  String toString() {
    return 'CparaOvcSubPopulation {\n'
        '  childrenQuestions: $childrenQuestions,\n'
        '}';
  }

  Map<String, dynamic> toJSON() {
    return {
      "children": childrenQuestions?.map((e) => e.toJSON()).toList() ?? []
    };
  }

  CparaOvcSubPopulation copyWith({
    List<CparaOvcChild>? childrenQuestions,
  }) {
    return CparaOvcSubPopulation(
      childrenQuestions: childrenQuestions ?? this.childrenQuestions,
    );
  }
}

class CparaOvcChild {
  final String?  ovcId;
  final String? name;
  final String? question1;
  final String? question2;
  final String? question3;
  final String? question4;
  final String? question5;
  final String? question6;
  final String? question7;
  final String? question8;
  final bool? answer1;
  final bool? answer2;
  final bool? answer3;
  final bool? answer4;
  final bool? answer5;
  final bool? answer6;
  final bool? answer7;
  final bool? answer8;


  CparaOvcChild({
    this.ovcId,
    this.name,
    this.question1,
    this.question2,
    this.question3,
    this.question4,
   this.question5,
    this.question6,
    this.question7,
    this.question8,
    this.answer1,
    this.answer2,
    this.answer3,
    this.answer4,
    this.answer5,
    this.answer6,
    this.answer7,
     this.answer8
  });

  factory CparaOvcChild.fromJson(Map<String, dynamic> json) {
    return CparaOvcChild(
      question1: json['question1'],
      question2: json['question2'],
      answer1: json['answer1'],
      answer2: json['answer2'],
      name: json['name'],
      ovcId: json['id'],
    );
  }

  CparaOvcChild copyWith({
    String? ovcId,
    String? name,
    String? question1,
    String? question2,
    String? question3,
    String? question4,
    String? question5,
    String? question6,
    String? question7,
    String? question8,
    bool? answer1,
    bool? answer2,
    bool? answer3,
    bool? answer4,
    bool? answer5,
    bool? answer6,
    bool? answer7,
    bool? answer8,
}){
    return CparaOvcChild(
        ovcId: ovcId ?? this.ovcId,
        name: name ?? this.name,
        question1: question1 ?? this.question1,
        question2: question2 ?? this.question2,
        question3: question3 ?? this.question3,
        question4: question4 ?? this.question4,
        question5: question5 ?? this.question5,
        question6: question6 ?? this.question6,
        question7: question7 ?? this.question7,
        question8: question8 ?? this.question8,
        answer1: answer1 ?? this.answer1,
        answer2: answer2 ?? this.answer2,
      answer3: answer3 ?? this.answer3,
      answer4: answer4 ?? this.answer4,
      answer5: answer5 ?? this.answer5,
      answer6: answer6 ?? this.answer6,
      answer7: answer7 ?? this.answer7,
      answer8: answer8 ?? this.answer8,
    );
}

  Map<String, dynamic> toJSON() {
    return {"id": ovcId, CparaQuestionIds.safeChildQuestion1: question1};
  }

  @override
  String toString() {
    return 'SafeChild {\n'
        '  ovcId: $ovcId,\n'
        '  name: $name,\n'
        '  question1: $question1,\n'
        '}';
  }
}
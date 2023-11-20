import 'package:cpims_mobile/screens/cpara/model/cpara_question_ids.dart';

class StableModel {
  String? question1;
  String? question2;
  String? question3;

  StableModel({
    this.question1,
    this.question2,
    this.question3,
  });

  factory StableModel.fromJson(Map<String, dynamic> json) {
    return StableModel(
      question1: json['question1'],
      question2: json['question2'],
      question3: json['question3'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      CparaQuestionIds.stableQuestion1: question1,
      CparaQuestionIds.stableQuestion2: question2,
      CparaQuestionIds.stableQuestion3: question3,
    };
  }

  StableModel copyWith({
    String? question1,
    String? question2,
    String? question3,
  }) {
    return StableModel(
      question1: question1 ?? this.question1,
      question2: question2 ?? this.question2,
      question3: question3 ?? this.question3,
    );
  }

  @override
  String toString() {
    return 'StableModel {\n'
        '  question1: $question1,\n'
        '  question2: $question2,\n'
        '  question3: $question3,\n'
        '}';
  }
}

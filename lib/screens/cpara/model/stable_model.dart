class StableModel {
  final String? question1;
  final String? question2;
  final String? question3;

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
      "q36": question1,
      "q37": question2,
      "q38": question3,
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
}

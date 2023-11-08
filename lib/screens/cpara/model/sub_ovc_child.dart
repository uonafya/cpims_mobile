class SubOvcChild{
  String? cpimsId;
  String? questionId;
  String? answer;

  SubOvcChild({this.cpimsId, this.questionId, this.answer});

  Map <String, dynamic> toJson(){
    return {
      "ovc_cpims_id": "$cpimsId",
      "criteria": "$questionId",
      "answer_id": "$answer",
    };
  }
}
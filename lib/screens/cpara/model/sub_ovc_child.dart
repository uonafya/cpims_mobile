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

  static SubOvcChild fromJson(Map<String, dynamic> json){
    return SubOvcChild(
      cpimsId: "${json["ovc_cpims_id"]}",
      questionId: "${json["criteria"]}",
      answer: "${json["answer_id"]}"
    );
  }
}
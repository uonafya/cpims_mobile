class CaseLoadModel {
  int? cpimsId;
  String? name;
  String? dateOfBirth;
  String? registrationDate;

  CaseLoadModel(
      {this.cpimsId, this.name, this.dateOfBirth, this.registrationDate});

  CaseLoadModel.fromJson(Map<String, dynamic> json) {
    cpimsId = json['cpims_id'];
    name = json['name'];
    dateOfBirth = json['date_of_birth'];
    registrationDate = json['registration_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cpims_id'] = this.cpimsId;
    data['name'] = this.name;
    data['date_of_birth'] = this.dateOfBirth;
    data['registration_date'] = this.registrationDate;
    return data;
  }
}

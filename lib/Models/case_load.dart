class CaseLoadModel {
  String? cpimsId;
  String? ovc_first_name;
  String? ovc_surname;
  String? date_of_birth;
  String? registration_date;
  String? caregiver_names;
  String? sex;

  CaseLoadModel({
    this.cpimsId,
    this.ovc_first_name,
    this.ovc_surname,
    this.date_of_birth,
    this.registration_date,
    this.caregiver_names,
    this.sex,
  });

  CaseLoadModel.fromJson(Map<String, dynamic> json) {
    cpimsId = json['cbo_id'];
    ovc_first_name = json['ovc_first_name'];
    ovc_surname = json['ovc_surname'];
    date_of_birth = json['date_of_birth'];
    registration_date = json['registration_date'];
    caregiver_names = json['caregiver_names'];
    sex = json['sex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cbo_id'] = cpimsId;
    data['ovc_first_name'] = ovc_first_name;
    data['ovc_surname'] = ovc_surname;
    data['date_of_birth'] = date_of_birth;
    data['registration_date'] = registration_date;
    data['caregiver_names'] = caregiver_names;
    data['sex'] = sex;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'cbo_id': cpimsId,
      'ovc_first_name': ovc_first_name,
      'ovc_surname': ovc_surname,
      'date_of_birth': date_of_birth,
      'registration_date': registration_date,
      'caregiver_names': caregiver_names,
      'sex': sex
    };
  }

  factory CaseLoadModel.fromMap(Map<String, dynamic> map) {
    return CaseLoadModel(
        cpimsId: map['cbo_id'],
        ovc_first_name: map['ovc_first_name'],
        ovc_surname: map['ovc_surname'],
        date_of_birth: map['date_of_birth'],
        registration_date: map['registration_date'],
        caregiver_names: map['caregiver_names'],
        sex: map['sex']);
  }
}

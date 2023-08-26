class CaseLoadModel {
  String? cpimsId;
  String? ovcFirstName;
  String? ovcSurname;
  String? dateOfBirth;
  String? registrationDate;
  String? caregiverNames;
  String? sex;

  CaseLoadModel({
    this.cpimsId,
    this.ovcFirstName,
    this.ovcSurname,
    this.dateOfBirth,
    this.registrationDate,
    this.caregiverNames,
    this.sex,
  });

  CaseLoadModel.fromJson(Map<String, dynamic> json) {
    cpimsId = json['cbo_id'].toString();
    ovcFirstName = json['ovc_first_name'];
    ovcSurname = json['ovc_surname'];
    dateOfBirth = json['date_of_birth'];
    registrationDate = json['registration_date'];
    caregiverNames = json['caregiver_names'];
    sex = json['sex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cbo_id'] = cpimsId;
    data['ovc_first_name'] = ovcFirstName;
    data['ovc_surname'] = ovcSurname;
    data['date_of_birth'] = dateOfBirth;
    data['registration_date'] = registrationDate;
    data['caregiver_names'] = caregiverNames;
    data['sex'] = sex;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'cbo_id': cpimsId,
      'ovc_first_name': ovcFirstName,
      'ovc_surname': ovcSurname,
      'date_of_birth': dateOfBirth,
      'registration_date': registrationDate,
      'caregiver_names': caregiverNames,
      'sex': sex
    };
  }

  factory CaseLoadModel.fromMap(Map<String, dynamic> map) {
    return CaseLoadModel(
        cpimsId: map['cbo_id'],
        ovcFirstName: map['ovc_first_name'],
        ovcSurname: map['ovc_surname'],
        dateOfBirth: map['date_of_birth'],
        registrationDate: map['registration_date'],
        caregiverNames: map['caregiver_names'],
        sex: map['sex']);
  }
}

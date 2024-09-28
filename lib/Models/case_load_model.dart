import 'dart:convert';

import 'package:cpims_mobile/Models/unnaproved_cpara_data.dart';

class CaseLoadModel {
  String? cpimsId;
  String? ovcFirstName;
  String? ovcSurname;
  String? dateOfBirth;
  String? registrationDate;
  String? caregiverNames;
  String? sex;
  String? caregiverCpimsId;
  String? chvCpimsId;
  String? ovchivstatus;
  int? age;
  List<Scores>? benchmarks;
  int? benchmarksScore;
  String? benchmarksPathway;

  CaseLoadModel({
    this.cpimsId,
    this.ovcFirstName,
    this.ovcSurname,
    this.dateOfBirth,
    this.registrationDate,
    this.caregiverNames,
    this.sex,
    this.caregiverCpimsId,
    this.chvCpimsId,
    this.ovchivstatus,
    this.age,
    this.benchmarks,
    this.benchmarksScore,
    this.benchmarksPathway,
  });

  factory CaseLoadModel.fromJson(Map<String, dynamic> json) {
    return CaseLoadModel(
      cpimsId: json['ovc_cpims_id'].toString(),
      ovcFirstName: json['ovc_first_name'],
      ovcSurname: json['ovc_surname'],
      dateOfBirth: json['date_of_birth'],
      registrationDate: json['registration_date'],
      caregiverNames: json['caregiver_names'],
      sex: json['sex'],
      age: json['age'],
      caregiverCpimsId: json['caregiver_cpims_id'].toString(),
      chvCpimsId: json['chv_cpims_id'].toString(),
      ovchivstatus: json['ovchivstatus'].toString(),
      // Parse benchmarks
      benchmarks: _parseBenchmarks(json['benchmarks']),
      benchmarksScore: json['benchmarks_score'],
      benchmarksPathway: json['benchmarks_pathway'],
    );
  }

  static List<Scores> _parseBenchmarks(dynamic benchmarksData) {
    if (benchmarksData is String) {
      try {
        final List<dynamic> parsedList = json.decode(benchmarksData);
        return parsedList.map((b) => Scores.fromJson(b)).toList();
      } catch (e) {
        print('Error parsing benchmarks: $e');
        return [];
      }
    } else if (benchmarksData is List) {
      return benchmarksData.map((b) => Scores.fromJson(b)).toList();
    }
    return [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ovc_cpims_id'] = cpimsId;
    data['ovc_first_name'] = ovcFirstName;
    data['ovc_surname'] = ovcSurname;
    data['date_of_birth'] = dateOfBirth;
    data['registration_date'] = registrationDate;
    data['caregiver_names'] = caregiverNames;
    data['sex'] = sex;
    data['age'] = age;
    data['caregiver_cpims_id'] = caregiverCpimsId;
    data['chv_cpims_id'] = chvCpimsId;
    data['ovchivstatus'] = ovchivstatus;
    data['benchmarks'] = benchmarks;
    data['benchmarks_score'] = benchmarksScore;
    data['benchmarks_pathway'] = benchmarksPathway;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'ovc_cpims_id': cpimsId,
      'ovc_first_name': ovcFirstName,
      'ovc_surname': ovcSurname,
      'date_of_birth': dateOfBirth,
      'registration_date': registrationDate,
      'caregiver_names': caregiverNames,
      'sex': sex,
      'age': age,
      'caregiver_cpims_id': caregiverCpimsId,
      'chv_cpims_id': chvCpimsId,
      'ovchivstatus': ovchivstatus,
      'benchmarks': benchmarks != null && benchmarks!.isNotEmpty
          ? json.encode(benchmarks!.map((s) => s.toJson()).toList())
          : json.encode([Scores().toJson()]),
      'benchmarks_score': benchmarksScore,
      'benchmarks_pathway': benchmarksPathway,
    };
  }

  factory CaseLoadModel.fromMap(Map<String, dynamic> map) {
    return CaseLoadModel(
      cpimsId: map['ovc_cpims_id'],
      ovcFirstName: map['ovc_first_name'],
      ovcSurname: map['ovc_surname'],
      dateOfBirth: map['date_of_birth'],
      registrationDate: map['registration_date'],
      caregiverNames: map['caregiver_names'],
      sex: map['sex'],
      age: map['age'],
      caregiverCpimsId: map['caregiver_cpims_id'],
      chvCpimsId: map['chv_cpims_id'],
      ovchivstatus: map['h_status'],
      benchmarks: _parseBenchmarks(map['benchmarks']),
      benchmarksScore: map['benchmarks_score'],
      benchmarksPathway: map['benchmarks_pathway'],
    );
  }

  @override
  String toString() {
    return 'CaseLoadModel{cpimsId: $cpimsId, ovcFirstName: $ovcFirstName, ovcSurname: $ovcSurname, dateofBirth: $dateOfBirth, registrationDate: $registrationDate, $benchmarks, benchmarksScore: $benchmarksScore, benchmarksPathway: $benchmarksPathway}';
  }
}

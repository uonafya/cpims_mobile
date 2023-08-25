class SummaryDataModel {
  final int children;
  final int caregivers;
  final int government;
  final int ngo;
  final int caseRecords;
  final int pendingCases;
  final int orgUnits;
  final int workforceMembers;
  final int household;
  final int childrenAll;
  final OvcSummary ovcSummary;
  final List<dynamic> ovcRegs;
  final List<dynamic> caseRegs;
  final Map<String, dynamic> caseCats;
  final Map<String, dynamic> criteria;
  final String orgUnit;
  final int orgUnitId;
  final String details;

  SummaryDataModel({
    required this.children,
    required this.caregivers,
    required this.government,
    required this.ngo,
    required this.caseRecords,
    required this.pendingCases,
    required this.orgUnits,
    required this.workforceMembers,
    required this.household,
    required this.childrenAll,
    required this.ovcSummary,
    required this.ovcRegs,
    required this.caseRegs,
    required this.caseCats,
    required this.criteria,
    required this.orgUnit,
    required this.orgUnitId,
    required this.details,
  });

  factory SummaryDataModel.fromJson(Map<String, dynamic> json) {
    return SummaryDataModel(
      children: json['children'],
      caregivers: json['caregivers'],
      government: json['government'],
      ngo: json['ngo'],
      caseRecords: json['case_records'],
      pendingCases: json['pending_cases'],
      orgUnits: json['org_units'],
      workforceMembers: json['workforce_members'],
      household: json['household'],
      childrenAll: json['children_all'],
      ovcSummary: OvcSummary.fromJson(json['ovc_summary']),
      ovcRegs: json['ovc_regs'],
      caseRegs: json['case_regs'],
      caseCats: json['case_cats'],
      criteria: json['criteria'],
      orgUnit: json['org_unit'],
      orgUnitId: json['org_unit_id'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'children': children,
      'caregivers': caregivers,
      'government': government,
      'ngo': ngo,
      'case_records': caseRecords,
      'pending_cases': pendingCases,
      'org_units': orgUnits,
      'workforce_members': workforceMembers,
      'household': household,
      'children_all': childrenAll,
      'ovc_summary': ovcSummary.toJson(),
      'ovc_regs': ovcRegs,
      'case_regs': caseRegs,
      'case_cats': caseCats,
      'criteria': criteria,
      'org_unit': orgUnit,
      'org_unit_id': orgUnitId,
      'details': details,
    };
  }
}

class OvcSummary {
  final int m0;
  final int m1;
  final int m2;
  final int m3;
  final int m4;
  final int f0;
  final int f1;
  final int f2;
  final int f3;
  final int f4;

  OvcSummary({
    required this.m0,
    required this.m1,
    required this.m2,
    required this.m3,
    required this.m4,
    required this.f0,
    required this.f1,
    required this.f2,
    required this.f3,
    required this.f4,
  });

  factory OvcSummary.fromJson(Map<String, dynamic> json) {
    return OvcSummary(
      m0: json['m0'],
      m1: json['m1'],
      m2: json['m2'],
      m3: json['m3'],
      m4: json['m4'],
      f0: json['f0'],
      f1: json['f1'],
      f2: json['f2'],
      f3: json['f3'],
      f4: json['f4'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'm0': m0,
      'm1': m1,
      'm2': m2,
      'm3': m3,
      'm4': m4,
      'f0': f0,
      'f1': f1,
      'f2': f2,
      'f3': f3,
      'f4': f4,
    };
  }
}

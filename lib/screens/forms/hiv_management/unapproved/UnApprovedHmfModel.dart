import '../../../../utils/app_form_metadata.dart';
import '../models/hiv_management_form_model.dart';

class UnApprovedHivManagementForm {
  String? adherenceId;
  int? ovcCpimsId;
  String? hivMgmt1A;
  String? hivMgmt1B;
  String? hivMgmt1C;
  String? hivMgmt1D;
  bool? hivMgmt1E;
  String? hivMgmt1EDate;
  bool? hivMgmt1F;
  String? hivMgmt1FDate;
  bool? hivMgmt1G;
  String? hivMgmt1GDate;
  String? hivMgmt2A;
  String? hivMgmt2B;
  String? hivMgmt2C;
  dynamic hivMgmt2D;
  String? hivMgmt2E;
  String? hivMgmt2F;
  String? hivMgmt2G;
  String? hivMgmt2H2;
  dynamic hivMgmt2H1;
  String? hivMgmt2H3;
  String? hivMgmt2H4;
  String? hivMgmt2H5;
  String? hivMgmt2I1;
  String? hivMgmt2IDate;
  String? hivMgmt2J;
  String? hivMgmt2K;
  String? hivMgmt2L1;
  String? hivMgmt2L2;
  List<String?>? hivMgmt2M;
  String? hivMgmt2N;
  bool? hivMgmt2O1;
  String? hivMgmt2O2;
  String? hivMgmt2P;
  String? hivMgmt2Q;
  String? hivMgmt2R;
  String? hivMgmt2S;
  AppFormMetaData? appFormMetadata;
  String? message;

  UnApprovedHivManagementForm({
    this.adherenceId,
    this.ovcCpimsId,
    this.hivMgmt1A,
    this.hivMgmt1B,
    this.hivMgmt1C,
    this.hivMgmt1D,
    this.hivMgmt1E,
    this.hivMgmt1EDate,
    this.hivMgmt1F,
    this.hivMgmt1FDate,
    this.hivMgmt1G,
    this.hivMgmt1GDate,
    this.hivMgmt2A,
    this.hivMgmt2B,
    this.hivMgmt2C,
    this.hivMgmt2D,
    this.hivMgmt2E,
    this.hivMgmt2F,
    this.hivMgmt2G,
    this.hivMgmt2H2,
    this.hivMgmt2H1,
    this.hivMgmt2H3,
    this.hivMgmt2H4,
    this.hivMgmt2H5,
    this.hivMgmt2I1,
    this.hivMgmt2IDate,
    this.hivMgmt2J,
    this.hivMgmt2K,
    this.hivMgmt2L1,
    this.hivMgmt2L2,
    this.hivMgmt2M,
    this.hivMgmt2N,
    this.hivMgmt2O1,
    this.hivMgmt2O2,
    this.hivMgmt2P,
    this.hivMgmt2Q,
    this.hivMgmt2R,
    this.hivMgmt2S,
    this.appFormMetadata,
    this.message,
  });

  factory UnApprovedHivManagementForm.fromJson(Map<String, dynamic> json) {
    return UnApprovedHivManagementForm(
      adherenceId: json['adherence_id'] ?? '',
      ovcCpimsId: json['ovc_cpims_id'] ?? 0,
      hivMgmt1A: json['HIV_MGMT_1_A'] ?? '',
      hivMgmt1B: json['HIV_MGMT_1_B'] ?? '',
      hivMgmt1C: json['HIV_MGMT_1_C'] ?? '',
      hivMgmt1D: json['HIV_MGMT_1_D'] ?? '',
      hivMgmt1E: json['HIV_MGMT_1_E'],
      hivMgmt1EDate: json['HIV_MGMT_1_E_DATE'] ?? '',
      hivMgmt1F: json['HIV_MGMT_1_F'],
      hivMgmt1FDate: json['HIV_MGMT_1_F_DATE'] ?? '',
      hivMgmt1G: json['HIV_MGMT_1_G'] ?? '',
      hivMgmt1GDate: json['HIV_MGMT_1_G_DATE'] ?? '',
      hivMgmt2A: json['HIV_MGMT_2_A'],
      hivMgmt2B: json['HIV_MGMT_2_B'],
      hivMgmt2C: json['HIV_MGMT_2_C'],
      hivMgmt2D: json['HIV_MGMT_2_D'] ?? '',
      hivMgmt2E: json['HIV_MGMT_2_E'] ?? '',
      hivMgmt2F: json['HIV_MGMT_2_F'] ?? '',
      hivMgmt2G: json['HIV_MGMT_2_G'] ?? '',
      hivMgmt2H2: json['HIV_MGMT_2_H_2'] ?? '',
      hivMgmt2H1: json['HIV_MGMT_2_H_1'] ?? '',
      hivMgmt2H3: json['HIV_MGMT_2_H_3'] ?? '',
      hivMgmt2H4: json['HIV_MGMT_2_H_4'],
      hivMgmt2H5: json['HIV_MGMT_2_H_5'] ?? '',
      hivMgmt2I1: json['HIV_MGMT_2_I_1'],
      hivMgmt2IDate: json['HIV_MGMT_2_I_DATE'] ?? '',
      hivMgmt2J: json['HIV_MGMT_2_J'] ?? '',
      hivMgmt2K: json['HIV_MGMT_2_K'] ?? '',
      hivMgmt2L1: json['HIV_MGMT_2_L_1'] ?? '',
      hivMgmt2L2: json['HIV_MGMT_2_L_2'] ?? '',
      hivMgmt2M: List<String>.from(json['HIV_MGMT_2_M']
          .replaceAll(r"\'", "")
          .replaceAll(r"\[", "")
          .replaceAll(r"\]", "")
          .split(", ")),
      hivMgmt2N: json['HIV_MGMT_2_N'] ?? '',
      hivMgmt2O1: json['HIV_MGMT_2_O_1'],
      hivMgmt2O2: json['HIV_MGMT_2_O_2'],
      hivMgmt2P: json['HIV_MGMT_2_P'],
      hivMgmt2Q: json['HIV_MGMT_2_Q'],
      hivMgmt2R: json['HIV_MGMT_2_R'],
      hivMgmt2S: json['HIV_MGMT_2_S'],
      appFormMetadata: AppFormMetaData.fromJson(json['app_form_metadata']),
      message: json['message'],
    );
  }

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'adherence_id': adherenceId,
      'ovc_cpims_id': ovcCpimsId,
      'HIV_MGMT_1_A': hivMgmt1A,
      'HIV_MGMT_1_B': hivMgmt1B,
      'HIV_MGMT_1_C': hivMgmt1C,
      'HIV_MGMT_1_D': hivMgmt1D,
      'HIV_MGMT_1_E': hivMgmt1E,
      'HIV_MGMT_1_E_DATE': hivMgmt1EDate,
      'HIV_MGMT_1_F': hivMgmt1F,
      'HIV_MGMT_1_F_DATE': hivMgmt1FDate,
      'HIV_MGMT_1_G': hivMgmt1G,
      'HIV_MGMT_1_G_DATE': hivMgmt1GDate,
      'HIV_MGMT_2_A': hivMgmt2A,
      'HIV_MGMT_2_B': hivMgmt2B,
      'HIV_MGMT_2_C': hivMgmt2C,
      'HIV_MGMT_2_D': hivMgmt2D,
      'HIV_MGMT_2_E': hivMgmt2E,
      'HIV_MGMT_2_F': hivMgmt2F,
      'HIV_MGMT_2_G': hivMgmt2G,
      'HIV_MGMT_2_H_2': hivMgmt2H2,
      'HIV_MGMT_2_H_1': hivMgmt2H1,
      'HIV_MGMT_2_H_3': hivMgmt2H3,
      'HIV_MGMT_2_H_4': hivMgmt2H4,
      'HIV_MGMT_2_H_5': hivMgmt2H5,
      'HIV_MGMT_2_I_1': hivMgmt2I1,
      'HIV_MGMT_2_I_DATE': hivMgmt2IDate,
      'HIV_MGMT_2_J': hivMgmt2J,
      'HIV_MGMT_2_K': hivMgmt2K,
      'HIV_MGMT_2_L_1': hivMgmt2L1,
      'HIV_MGMT_2_L_2': hivMgmt2L2,
      'HIV_MGMT_2_M': '["${hivMgmt2M?.join('", "')}"]',
      'HIV_MGMT_2_N': hivMgmt2N,
      'HIV_MGMT_2_O_1': hivMgmt2O1,
      'HIV_MGMT_2_O_2': hivMgmt2O2,
      'HIV_MGMT_2_P': hivMgmt2P,
      'HIV_MGMT_2_Q': hivMgmt2Q,
      'HIV_MGMT_2_R': hivMgmt2R,
      'HIV_MGMT_2_S': hivMgmt2S,
      'app_form_metadata': appFormMetadata?.toJson(),
      'message': message,
    };
  }

  @override
  String toString() {
    return 'HivManagementForm('
        'adherenceId: $adherenceId, '
        'ovcCpimsId: $ovcCpimsId, '
        'hivMgmt1A: $hivMgmt1A, '
        'hivMgmt1B: $hivMgmt1B, '
        'hivMgmt1C: $hivMgmt1C, '
        'hivMgmt1D: $hivMgmt1D, '
        'hivMgmt1E: $hivMgmt1E, '
        'hivMgmt1EDate: $hivMgmt1EDate, '
        'hivMgmt1F: $hivMgmt1F, '
        'hivMgmt1FDate: $hivMgmt1FDate, '
        'hivMgmt1G: $hivMgmt1G, '
        'hivMgmt1GDate: $hivMgmt1GDate, '
        'hivMgmt2A: $hivMgmt2A, '
        'hivMgmt2B: $hivMgmt2B, '
        'hivMgmt2C: $hivMgmt2C, '
        'hivMgmt2D: $hivMgmt2D, '
        'hivMgmt2E: $hivMgmt2E, '
        'hivMgmt2F: $hivMgmt2F, '
        'hivMgmt2G: $hivMgmt2G, '
        'hivMgmt2H2: $hivMgmt2H2, '
        'hivMgmt2H1: $hivMgmt2H1, '
        'hivMgmt2H3: $hivMgmt2H3, '
        'hivMgmt2H4: $hivMgmt2H4, '
        'hivMgmt2H5: $hivMgmt2H5, '
        'hivMgmt2I1: $hivMgmt2I1, '
        'hivMgmt2IDate: $hivMgmt2IDate, '
        'hivMgmt2J: $hivMgmt2J, '
        'hivMgmt2K: $hivMgmt2K, '
        'hivMgmt2L1: $hivMgmt2L1, '
        'hivMgmt2L2: $hivMgmt2L2, '
        'hivMgmt2M: $hivMgmt2M, '
        'hivMgmt2N: $hivMgmt2N, '
        'hivMgmt2O1: $hivMgmt2O1, '
        'hivMgmt2O2: $hivMgmt2O2, '
        'hivMgmt2P: $hivMgmt2P, '
        'hivMgmt2Q: $hivMgmt2Q, '
        'hivMgmt2R: $hivMgmt2R, '
        'hivMgmt2S: $hivMgmt2S, '
        'appFormMetadata: $appFormMetadata, '
        'message: $message)';
  }
}

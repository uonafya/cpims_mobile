import 'dart:convert';
import 'dart:ffi';
import 'package:cpims_mobile/Models/unapproved_form_1_model.dart';
import 'package:cpims_mobile/Models/unnaproved_cpara_data.dart';
import 'package:cpims_mobile/providers/cpara/fill_cpara_records_from_questions.dart';
import 'package:cpims_mobile/providers/cpara/unapproved_cpara_database.dart';
import 'package:cpims_mobile/providers/cpara/unapproved_cpara_service.dart';
import 'package:cpims_mobile/screens/cpara/cpara_util.dart';
import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:cpims_mobile/screens/cpara/model/health_model.dart';
import 'package:cpims_mobile/screens/cpara/model/ovc_model.dart';
import 'package:cpims_mobile/screens/cpara/model/safe_model.dart';
import 'package:cpims_mobile/screens/cpara/model/schooled_model.dart';
import 'package:cpims_mobile/screens/cpara/model/stable_model.dart';
import 'package:cpims_mobile/screens/cpara/model/unnaproved_cpara_database_model.dart';
import 'package:cpims_mobile/utils/app_form_metadata.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../constants.dart';
import '../providers/db_provider.dart';
import '../screens/cpara/model/cpara_model.dart';
import '../screens/cpara/widgets/cpara_details_widget.dart';

const String _formType1A = "form1a";
const String _formType1B = "form1b";

class UnapprovedDataService {
  static Future<void> fetchRemoteUnapprovedData(access) async {
    var endpoints = [
      "mobile/unaccepted_records/F1A/",
      "mobile/unaccepted_records/F1B/",
      "mobile/unaccepted_records/caseplan/",
      "mobile/unaccepted_records/cpara/"
    ];

    List<Future<void>> futures = endpoints.map((endpoint) async {
      // var response = await ApiService().getSecureData(endpoint, access);
      var jsonData = json.decode(
          '[{"ovc_cpims_id": "3799369", "date_of_event": "2023-10-28", "questions": [{"question_code": "CP1d", "answer_id": "AYES"}, {"question_code": "CP3d", "answer_id": "AYES"}, {"question_code": "CP4d", "answer_id": "AYES"}, {"question_code": "CP5d", "answer_id": "AYES"}, {"question_code": "qd1", "answer_id": "AYES"}, {"question_code": "qd3", "answer_id": "AYES"}, {"question_code": "CP1q", "answer_id": "AYES"}, {"question_code": "CP2q", "answer_id": "AYES"}, {"question_code": "CP3q", "answer_id": "AYES"}, {"question_code": "CP4q", "answer_id": "AYES"}, {"question_code": "CP5q", "answer_id": "AYES"}, {"question_code": "CP6q", "answer_id": "AYES"}, {"question_code": "CP7q", "answer_id": "AYES"}, {"question_code": "CP8q", "answer_id": "AYES"}, {"question_code": "CP9q", "answer_id": "AYES"}, {"question_code": "CP10q", "answer_id": "AYES"}, {"question_code": "CP11q", "answer_id": "AYES"}, {"question_code": "CP12q", "answer_id": "AYES"}, {"question_code": "CP13q", "answer_id": "AYES"}, {"question_code": "CP14q", "answer_id": "AYES"}, {"question_code": "CP18q", "answer_id": "AYES"}, {"question_code": "CP19q", "answer_id": "AYES"}, {"question_code": "CP20q", "answer_id": "AYES"}, {"question_code": "CP21q", "answer_id": "AYES"}, {"question_code": "CP25q", "answer_id": "AYES"}, {"question_code": "CP26q", "answer_id": "AYES"}, {"question_code": "CP28q", "answer_id": "AYES"}, {"question_code": "CP29q", "answer_id": "AYES"}, {"question_code": "CP30q", "answer_id": "AYES"}, {"question_code": "CP31q", "answer_id": "AYES"}, {"question_code": "CP32q", "answer_id": "AYES"}, {"question_code": "CP33q", "answer_id": "AYES"}, {"question_code": "CP34q", "answer_id": "AYES"}, {"question_code": "CP35q", "answer_id": "AYES"}, {"question_code": "CP36q", "answer_id": "AYES"}, {"question_code": "CP22q", "answer_id": "AYES"}, {"question_code": "CP23q", "answer_id": "AYES"}, {"question_code": "CP24q", "answer_id": "AYES"}], "individual_questions": [{"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3799369"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3799369"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3799369"}, {"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3437286"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3437286"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3437286"}, {"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3437297"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3437297"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3437297"}, {"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3437278"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3437278"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3437278"}, {"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3437238"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3437238"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3437238"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3799369"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3437286"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3437297"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3437278"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3437238"}], "scores": {"b1": "1", "b2": "1", "b3": "1", "b4": "1", "b5": "1", "b6": "1", "b7": "1", "b8": "1", "b9": "1"}}]');
      // if (endpoint == endpoints[0]) {
      //   final db = LocalDb.instance;
      //   for (var map in jsonData) {
      //     final unapprovedForm1A = UnapprovedForm1DataModel.fromJson(map);
      //     db.insertUnapprovedForm1Data(_formType1A, unapprovedForm1A,
      //         unapprovedForm1A.appFormMetaData, unapprovedForm1A.uuid);
      //   }
      // } else

      //   if (endpoint == endpoints[1]) {
      //   final db = LocalDb.instance;
      //   for (var map in jsonData) {
      //     final unapprovedForm1B = UnapprovedForm1DataModel.fromJson(map);
      //     db.insertUnapprovedForm1Data(_formType1B, unapprovedForm1B,
      //         unapprovedForm1B.appFormMetaData, unapprovedForm1B.uuid);
      //   }
      // }
      //   else if (endpoint == endpoints[2]) {
      //   // Handle CasePlan template
      // }
      //   else
      if (endpoint == endpoints[3]) {
//         // Handle CPara
//         List<UnaprovedRemoteData> list = unaprovedRemoteDataFromJson(
//             '[{"ovc_cpims_id": "3799369", "date_of_event": "2023-10-28", "questions": [{"question_code": "CP1d", "answer_id": "AYES"}, {"question_code": "CP3d", "answer_id": "AYES"}, {"question_code": "CP4d", "answer_id": "AYES"}, {"question_code": "CP5d", "answer_id": "AYES"}, {"question_code": "qd1", "answer_id": "AYES"}, {"question_code": "qd3", "answer_id": "AYES"}, {"question_code": "CP1q", "answer_id": "AYES"}, {"question_code": "CP2q", "answer_id": "AYES"}, {"question_code": "CP3q", "answer_id": "AYES"}, {"question_code": "CP4q", "answer_id": "AYES"}, {"question_code": "CP5q", "answer_id": "AYES"}, {"question_code": "CP6q", "answer_id": "AYES"}, {"question_code": "CP7q", "answer_id": "AYES"}, {"question_code": "CP8q", "answer_id": "AYES"}, {"question_code": "CP9q", "answer_id": "AYES"}, {"question_code": "CP10q", "answer_id": "AYES"}, {"question_code": "CP11q", "answer_id": "AYES"}, {"question_code": "CP12q", "answer_id": "AYES"}, {"question_code": "CP13q", "answer_id": "AYES"}, {"question_code": "CP14q", "answer_id": "AYES"}, {"question_code": "CP18q", "answer_id": "AYES"}, {"question_code": "CP19q", "answer_id": "AYES"}, {"question_code": "CP20q", "answer_id": "AYES"}, {"question_code": "CP21q", "answer_id": "AYES"}, {"question_code": "CP25q", "answer_id": "AYES"}, {"question_code": "CP26q", "answer_id": "AYES"}, {"question_code": "CP28q", "answer_id": "AYES"}, {"question_code": "CP29q", "answer_id": "AYES"}, {"question_code": "CP30q", "answer_id": "AYES"}, {"question_code": "CP31q", "answer_id": "AYES"}, {"question_code": "CP32q", "answer_id": "AYES"}, {"question_code": "CP33q", "answer_id": "AYES"}, {"question_code": "CP34q", "answer_id": "AYES"}, {"question_code": "CP35q", "answer_id": "AYES"}, {"question_code": "CP36q", "answer_id": "AYES"}, {"question_code": "CP22q", "answer_id": "AYES"}, {"question_code": "CP23q", "answer_id": "AYES"}, {"question_code": "CP24q", "answer_id": "AYES"}], "individual_questions": [{"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3799369"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3799369"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3799369"}, {"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3437286"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3437286"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3437286"}, {"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3437297"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3437297"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3437297"}, {"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3437278"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3437278"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3437278"}, {"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3437238"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3437238"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3437238"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3799369"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3437286"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3437297"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3437278"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3437238"}], "scores": {"b1": "1", "b2": "1", "b3": "1", "b4": "1", "b5": "1", "b6": "1", "b7": "1", "b8": "1", "b9": "1"}}]');
        var info = await fetchRemoteUnapprovedCparaData(baseUrl: endpoint);
        // var rawData = '[{"ovc_cpims_id": "3799369", "date_of_event": "2023-10-28", "questions": [{"question_code": "CP1d", "answer_id": "AYES"}, {"question_code": "CP3d", "answer_id": "AYES"}, {"question_code": "CP4d", "answer_id": "AYES"}, {"question_code": "CP5d", "answer_id": "AYES"}, {"question_code": "qd1", "answer_id": "AYES"}, {"question_code": "qd3", "answer_id": "AYES"}, {"question_code": "CP1q", "answer_id": "AYES"}, {"question_code": "CP2q", "answer_id": "AYES"}, {"question_code": "CP3q", "answer_id": "AYES"}, {"question_code": "CP4q", "answer_id": "AYES"}, {"question_code": "CP5q", "answer_id": "AYES"}, {"question_code": "CP6q", "answer_id": "AYES"}, {"question_code": "CP7q", "answer_id": "AYES"}, {"question_code": "CP8q", "answer_id": "AYES"}, {"question_code": "CP9q", "answer_id": "AYES"}, {"question_code": "CP10q", "answer_id": "AYES"}, {"question_code": "CP11q", "answer_id": "AYES"}, {"question_code": "CP12q", "answer_id": "AYES"}, {"question_code": "CP13q", "answer_id": "AYES"}, {"question_code": "CP14q", "answer_id": "AYES"}, {"question_code": "CP18q", "answer_id": "AYES"}, {"question_code": "CP19q", "answer_id": "AYES"}, {"question_code": "CP20q", "answer_id": "AYES"}, {"question_code": "CP21q", "answer_id": "AYES"}, {"question_code": "CP25q", "answer_id": "AYES"}, {"question_code": "CP26q", "answer_id": "AYES"}, {"question_code": "CP28q", "answer_id": "AYES"}, {"question_code": "CP29q", "answer_id": "AYES"}, {"question_code": "CP30q", "answer_id": "AYES"}, {"question_code": "CP31q", "answer_id": "AYES"}, {"question_code": "CP32q", "answer_id": "AYES"}, {"question_code": "CP33q", "answer_id": "AYES"}, {"question_code": "CP34q", "answer_id": "AYES"}, {"question_code": "CP35q", "answer_id": "AYES"}, {"question_code": "CP36q", "answer_id": "AYES"}, {"question_code": "CP22q", "answer_id": "AYES"}, {"question_code": "CP23q", "answer_id": "AYES"}, {"question_code": "CP24q", "answer_id": "AYES"}], "individual_questions": [{"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3799369"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3799369"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3799369"}, {"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3437286"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3437286"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3437286"}, {"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3437297"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3437297"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3437297"}, {"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3437278"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3437278"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3437278"}, {"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3437238"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3437238"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3437238"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3799369"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3437286"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3437297"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3437278"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3437238"}], "scores": {"b1": "1", "b2": "1", "b3": "1", "b4": "1", "b5": "1", "b6": "1", "b7": "1", "b8": "1", "b9": "1"}}]';
        // var list  = jsonDecode(rawData);
        List<UnapprovedCparaDatabase> listOfUnaprovedCparas =
            listOfUnapprovedCparas(remoteData: info);

        // Expects a map i.e decoded JSON
        // List<UnapprovedCparaDatabase> listOfUnaprovedCparas =
        //     listOfUnapprovedCparas(remoteData: list);
        // listOfUnaprovedCparas = [listOfUnaprovedCparas.last];
        for (UnapprovedCparaDatabase unapprovedCpara in listOfUnaprovedCparas) {
          UnapprovedCparaModel model =
              fetchUnaprovedCpara(cparaDatabase: unapprovedCpara);

          // Insert UnapprovedCparaModel
          final db = LocalDb.instance;
          var localDB = await db.database;

          // Store metadata
          db.insertUnapprovedAppFormMetaData(
              model.uuid, model.appFormMetaData, 'cpara');

          final storeInDB = await UnapprovedCparaService.storeInDB(
            localDB,
            model,
          );
        }
      }
      return;
    }).toList();
//
    await Future.wait(futures);
    return;
  }

  static Future<List<UnapprovedForm1DataModel>>
      fetchLocalUnapprovedForm1AData() async {
    final db = LocalDb.instance;
    List<Map<String, dynamic>> maps =
        await db.queryAllUnapprovedForm1Rows(_formType1A);
    List<UnapprovedForm1DataModel> unapprovedForm1Data = [];
    for (var map in maps) {
      unapprovedForm1Data.add(UnapprovedForm1DataModel.fromJson(map));
    }
    return unapprovedForm1Data;
  }

  static Future<List<UnapprovedForm1DataModel>>
      fetchLocalUnapprovedForm1BData() async {
    final db = LocalDb.instance;
    List<Map<String, dynamic>> maps =
        await db.queryAllUnapprovedForm1Rows(_formType1B);
    List<UnapprovedForm1DataModel> unapprovedForm1Data = [];
    for (var map in maps) {
      unapprovedForm1Data.add(UnapprovedForm1DataModel.fromJson(map));
    }
    return unapprovedForm1Data;
  }

  static Future<List<UnapprovedCparaDatabase>>
      fetchLocalUnapprovedCparaData() async {
    final db = LocalDb.instance;
    return await UnapprovedDataService.fetchLocalUnapprovedCparaData();
  }

  static Future<dynamic> fetchRemoteUnapprovedCparaData({
    required String baseUrl,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('access');
    String bearerAuth = "Bearer $accessToken";
    var response = await dio.get("$cpimsApiUrl$baseUrl",
        options: Options(headers: {"Authorization": bearerAuth}));

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw ("Could not fetch unapproved cparas");
    }
  }
}

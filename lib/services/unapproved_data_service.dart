import 'dart:convert';
import 'dart:ffi';
import 'package:cpims_mobile/Models/unapproved_caseplan_form_model.dart';
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
import '../providers/unapproved_cpt_provider.dart';

const String _formType1A = "form1a";
const String _formType1B = "form1b";

var dio = Dio();

class UnapprovedDataService {
  static Future<void> fetchRemoteUnapprovedData(access) async {
    var endpoints = [
      "mobile/unaccepted_records/F1A/",
      "mobile/unaccepted_records/F1B/",
      "mobile/unaccepted_records/caseplan/",
      "mobile/unaccepted_records/cpara/"
    ];

    List<Future<void>> futures = endpoints.map((endpoint) async {
      final db = LocalDb.instance;
      // var response = await ApiService().getSecureData(endpoint, access);
      // final List<Map<String, dynamic>> jsonData = json.decode(response.body);
      var jsonData = json.decode(
          '[{"ovc_cpims_id":"4027465","uuid":"7ec23585-8e56-44bc-8a92-d68c490421ca","date_of_event":"2023-11-05", "services":[{"domain_id":"DHNU","service_id":"CP12HEs"},{"domain_id":"DHNU","service_id":"CP14HEs"},{"domain_id":"DHES","service_id":"C 55STs"},{"domain_id":"DHES","service_id":"CP57aSTs"},{"domain_id":"DHES","service_id":"CP53aSTs"},{"domain_id":"DPRO","service_id":"CP63aSAs"},{"domain_id":"DPRO","service_id":"CP63bSAs"},{"domain_id":"DPRO","service_id":"CP61SAs"},{"domain_id":"DEDU","service_id":"CP93SCs"},{"domain_id":"DEDU","service_id":"CP94aSCs"}],"critical_events":[{"event_id":"CEOCE3","event_date":"2023-11-07"},{"event_id":"CEOCE2","event_date":"2023-11-07"},{"event_id":"CEOCE4","event_date":"2023-11-07"},{"event_id":"CEOCE5","event_date":"2023-11-07"}], "app_form_metadata":{"form_id":"7ec23585-8e56-44bc-8a92-d68c490421ca","location_lat":"-1.3093283","location_long":"36.81252","start_of_interview":"2023-11-07 15:53:54.935785","end_of_interview":"2023-11-07T15:54:29.973195","form_type":"form1a"}, "message" : "Reason for rejection"}]');
      var cptJsonData = json.decode(
          "[{\"id\":1,\"ovc_cpims_id\":\"3437286\",\"date_of_event\":\"2023-11-08T12:15:08.131838\",\"message\":\"Reasonforunapproval\",\"services\":[{\"domain_id\":\"DHNU\",\"service_id\":[\"CP14HE\"],\"goal_id\":\"GH2HE\",\"gap_id\":\"GN12HE\",\"priority_id\":\"P13HE\",\"responsible_id\":[\"RCHV\"],\"results_id\":\"AC\",\"reason_id\":\"Reasons\",\"completion_date\":\"2023-11-08T00:00:00.000\"},{\"domain_id\":\"DPRO\",\"service_id\":[\"CP62SA\",\"CP64SA\"],\"goal_id\":\"GH6SA\",\"gap_id\":\"GN63SA\",\"priority_id\":\"P63SA\",\"responsible_id\":[\"RCHV\",\"RDCS\",\"RHHM\"],\"results_id\":\"AC\",\"reason_id\":\"Reasons\",\"completion_date\":\"\"},{\"domain_id\":\"DHES\",\"service_id\":[\"CP51ST\",\"CP53ST\"],\"goal_id\":\"GH5ST\",\"gap_id\":\"GN51ST\",\"priority_id\":\"P52ST\",\"responsible_id\":[\"RCHV\"],\"results_id\":\"NA\",\"reason_id\":\"Reasonslast\",\"completion_date\":\"\"},{\"domain_id\":\"DEDU\",\"service_id\":[\"CP93SC\",\"CP94SC\",\"CP91SC\"],\"goal_id\":\"GH9SC\",\"gap_id\":\"GN93SC\",\"priority_id\":\"P92SC\",\"responsible_id\":[\"RCHV\",\"RNGO\"],\"results_id\":\"NA\",\"reason_id\":\"Reasons\",\"completion_date\":\"2023-11-08T00:00:00.000\"}]}]");
          var cparaJsonData = json.decode(
      '[{"ovc_cpims_id": "3799369", "date_of_event": "2023-10-28", "questions": [{"question_code": "CP1d", "answer_id": "AYES"}, {"question_code": "CP3d", "answer_id": "AYES"}, {"question_code": "CP4d", "answer_id": "AYES"}, {"question_code": "CP5d", "answer_id": "AYES"}, {"question_code": "qd1", "answer_id": "AYES"}, {"question_code": "qd3", "answer_id": "AYES"}, {"question_code": "CP1q", "answer_id": "AYES"}, {"question_code": "CP2q", "answer_id": "AYES"}, {"question_code": "CP3q", "answer_id": "AYES"}, {"question_code": "CP4q", "answer_id": "AYES"}, {"question_code": "CP5q", "answer_id": "AYES"}, {"question_code": "CP6q", "answer_id": "AYES"}, {"question_code": "CP7q", "answer_id": "AYES"}, {"question_code": "CP8q", "answer_id": "AYES"}, {"question_code": "CP9q", "answer_id": "AYES"}, {"question_code": "CP10q", "answer_id": "AYES"}, {"question_code": "CP11q", "answer_id": "AYES"}, {"question_code": "CP12q", "answer_id": "AYES"}, {"question_code": "CP13q", "answer_id": "AYES"}, {"question_code": "CP14q", "answer_id": "AYES"}, {"question_code": "CP18q", "answer_id": "AYES"}, {"question_code": "CP19q", "answer_id": "AYES"}, {"question_code": "CP20q", "answer_id": "AYES"}, {"question_code": "CP21q", "answer_id": "AYES"}, {"question_code": "CP25q", "answer_id": "AYES"}, {"question_code": "CP26q", "answer_id": "AYES"}, {"question_code": "CP28q", "answer_id": "AYES"}, {"question_code": "CP29q", "answer_id": "AYES"}, {"question_code": "CP30q", "answer_id": "AYES"}, {"question_code": "CP31q", "answer_id": "AYES"}, {"question_code": "CP32q", "answer_id": "AYES"}, {"question_code": "CP33q", "answer_id": "AYES"}, {"question_code": "CP34q", "answer_id": "AYES"}, {"question_code": "CP35q", "answer_id": "AYES"}, {"question_code": "CP36q", "answer_id": "AYES"}, {"question_code": "CP22q", "answer_id": "AYES"}, {"question_code": "CP23q", "answer_id": "AYES"}, {"question_code": "CP24q", "answer_id": "AYES"}], "individual_questions": [{"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3799369"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3799369"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3799369"}, {"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3437286"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3437286"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3437286"}, {"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3437297"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3437297"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3437297"}, {"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3437278"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3437278"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3437278"}, {"question_code": "CP15q", "answer_id": "AYES", "ovc_cpims_id": "3437238"}, {"question_code": "CP16q", "answer_id": "AYES", "ovc_cpims_id": "3437238"}, {"question_code": "CP17q", "answer_id": "AYES", "ovc_cpims_id": "3437238"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3799369"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3437286"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3437297"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3437278"}, {"question_code": "CP27q", "answer_id": "AYES", "ovc_cpims_id": "3437238"}], "scores": {"b1": "1", "b2": "1", "b3": "1", "b4": "1", "b5": "1", "b6": "1", "b7": "1", "b8": "1", "b9": "1"}}]');

      if (endpoint == endpoints[0]) {
        for (var map in jsonData) {
          final unapprovedForm1A = UnapprovedForm1DataModel.fromJson(map);
          db.insertUnapprovedForm1Data(_formType1A, unapprovedForm1A,
              unapprovedForm1A.appFormMetaData, unapprovedForm1A.uuid);
        }
      } else if (endpoint == endpoints[1]) {
        for (var map in jsonData) {
          final unapprovedForm1B = UnapprovedForm1DataModel.fromJson(map);
          db.insertUnapprovedForm1Data(_formType1B, unapprovedForm1B,
              unapprovedForm1B.appFormMetaData, unapprovedForm1B.uuid);
        }
      } else if (endpoint == endpoints[2]) {
        for (var map in cptJsonData) {
          final unapprovedCptData = UnapprovedCasePlanModel.fromJson(map);
          final unapprovedCpt = UnapprovedCptProvider();
          var localdb = await db.database;
          unapprovedCpt.insertUnapprovedCasePlanData(
              localdb, unapprovedCptData);
        }
      } else if (endpoint == endpoints[3]) {
        // Handle CPara
        var info = await fetchRemoteUnapprovedCparaData(baseUrl: endpoint);
      List<UnapprovedCparaDatabase> listOfUnaprovedCparas =
      listOfUnapprovedCparas(remoteData: info);
      // // todo: remove after testing
      // listOfUnaprovedCparas = [listOfUnaprovedCparas.elementAt(4)];

      // Expects a map i.e decoded JSON
      for (UnapprovedCparaDatabase unapprovedCpara in listOfUnaprovedCparas) {
      UnapprovedCparaModel model =
      fetchUnaprovedCpara(cparaDatabase: unapprovedCpara);

      // Insert UnapprovedCparaModel
      var localDB = await db.database;

      // Check if form has already been stored in db
      var fetchResult = await localDB.rawQuery(
      "SELECT * FROM UnapprovedCPARA WHERE id = ?", [model.uuid]
      );

      if (fetchResult == null || fetchResult.isEmpty) {
      try {
      await UnapprovedCparaService.storeInDB(
      localDB,
      model,
      );
      } catch(e) {
      UnapprovedCparaService.informUpstreamOfStoredUnapproved(model.uuid, false);
      }
      }
      // Tell Upstream that I have stored the form
      UnapprovedCparaService.informUpstreamOfStoredUnapproved(model.uuid, true);
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

  static Future<List<UnapprovedCasePlanModel>>
      fetchLocalUnapprovedCasePlanData() async {
    final db = LocalDb.instance;
    final unapprovedCpt = UnapprovedCptProvider();
    var localdb = await db.database;
    List<UnapprovedCasePlanModel> unapprovedCptList =
        await unapprovedCpt.getAllUnapprovedCasePlanData(localdb);
    return unapprovedCptList;
  }

  static Future<bool> deleteUnapprovedForm1(int id) async {
    final db = LocalDb.instance;
    return await db.deleteUnApprovedForm1Data(id);
  }

  static Future<bool> deleteUnapprovedCpt(int id) async {
    final db = LocalDb.instance;
    final unapprovedCpt = UnapprovedCptProvider();
    var localdb = await db.database;
    return await unapprovedCpt.deleteUnapprovedCasePlanData(localdb, id);
  }
}

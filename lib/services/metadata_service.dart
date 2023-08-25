import 'dart:convert';
import 'package:cpims_mobile/Models/form_metadata_model.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MetadataService {
  // send form to server
  static Future<bool> fetchMetadata() async {
    const urlEndpoint = "metadata/";
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access');
    String? valueToken = "$token";
    print("bearer>>>>>>>>>>>>>>>>>>>>>> $valueToken");
    try {
      final response = await ApiService().getSecureData(
          urlEndpoint, valueToken);
      print(response.body);
      var responseData = await jsonDecode(response.body);
      print("$responseData");
      final  db = LocalDb.instance;
      for (var data in responseData) {
        print(">>>>>>>>>>>>>>data: $data");
        Metadata metadata = Metadata.fromJson(data);
        await db.insertMetadata(metadata);
        print(metadata);
      }
      return true;
    } catch (e) {
      print("Error fetching metadata: $e");
      rethrow; // Re-throw the caught exception
    }
  }

  // get all metadata
  Future<List<Map<String, dynamic>>> getAllMetadataFromLocal() async {
    final  db = await LocalDb.instance;
    return db.queryAllMetadataRows();
  }

  // get specific metadata with field_name
  Future<List<Map<String, dynamic>>> getAllFieldItemsFromLocal(String fieldName) async {
    final  db = LocalDb.instance;
    return db.querySpecificFieldItems(fieldName);
  }

}
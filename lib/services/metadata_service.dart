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
    try {
      final response =
          await ApiService().getSecureData(urlEndpoint, valueToken);
      var responseData = await jsonDecode(response.body);
      final db = LocalDb.instance;
      for (var data in responseData) {
        Metadata metadata = Metadata.fromJson(data);
        await db.insertMetadata(metadata);
      }
      return true;
    } catch (e) {
      print("Error fetching metadata: $e");
      rethrow; // Re-throw the caught exception
    }
  }

  // get all metadata
  static Future<List<Map<String, dynamic>>> getAllMetadataFromLocal() async {
    final db = LocalDb.instance;
    return db.queryAllMetadataRows();
  }

  // get specific metadata with field_name
  static Future<List<Map<String, dynamic>>> getAllFieldItemsFromLocal(
      String fieldName) async {
    final db = LocalDb.instance;
    return db.querySpecificMetadataFieldItems(fieldName);
  }
}

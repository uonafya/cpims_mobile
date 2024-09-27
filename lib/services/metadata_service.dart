import 'dart:convert';
import 'package:cpims_mobile/Models/form_metadata_model.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:cpims_mobile/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';


class MetadataService {
  // send form to server
  static Future<bool> fetchMetadata() async {
    const urlEndpoint = "api/metadata/";
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

  Future<void> saveMetadata() async {
  const urlEndpoint = "api/metadata/";
  final prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('access');
  String? valueToken = "$token";

  try {
    var db = await LocalDb.instance.database;
    final response = await ApiService().getSecureData(urlEndpoint, valueToken);
    var responseData = jsonDecode(response.body);

    List<Metadata> metadataList = responseData.map<Metadata>((data) {
      return Metadata.fromJson(data);
    }).toList();

    await saveMetadataInDB(db, metadataList); // Pass the list of Metadata to the DB
  } catch (err) {
    throw "Could Not Get Metadata";
  }
}


Future<List<Metadata>> getMetadata(MetadataTypes type) async {
  try {
    var db = await LocalDb.instance.database;
    var results = await db.query(tableFormMetadata,
        distinct: true,
        where: "field_name = ?",
        columns: ['item_description', 'item_id'],
        whereArgs: [type.value]);
    return results
        .map((e) =>
            Metadata(itemDescription: e['item_description'].toString(), itemId: e['item_id'].toString(), itemName: e['itemName'].toString(), itemSubCategory: e['itemSubCategory'].toString(), itemTheOrder: 0))
        .toList();
  } catch (err) {
    throw "Could Not Get Metadata";
  }
}

Future<void> saveMetadataInDB(Database db, List<Metadata> metadataList) async {
  try {
    var batch = db.batch();

    for (var meta in metadataList) {
      batch.insert(
        'tableFormMetadata', // Replace with your actual table name
        {
          "item_id": meta.itemId,
          "field_name": meta.itemName,
          "item_description": meta.itemDescription,
          "item_sub_Category": meta.itemSubCategory,
          "the_order": meta.itemTheOrder,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();
  } catch (err) {
    throw "Could Not Save Metadata in DB";
  }
}

  Future<void> testGetMetadata() async {
    try {
      // Call getMetadata function and pass the required MetadataTypes argument
      List<Metadata> metadataList = await getMetadata(MetadataTypes.item_id); // Replace with actual MetadataTypes value

      if (metadataList.isNotEmpty) {
        // Print the first metadata item
        print("First Metadata: ${metadataList[0].itemName}, ${metadataList[0].itemId}, ${metadataList[0].itemDescription}");
      } else {
        print("No metadata found.");
      }
    } catch (err) {
      print("Error: $err");
    }
  }
}

enum MetadataTypes {
  item_id,
  field_name,
  item_description,
  item_sub_Category,
  the_order,
}

extension MetadataValues on MetadataTypes {
  String get value {
    switch (this) {
      case MetadataTypes.item_id:
        return "item_id";
      case MetadataTypes.field_name:
        return "field_name_id";
      case MetadataTypes.item_description:
        return "item_description_id";
      case MetadataTypes.item_sub_Category:
        return "item_sub_Category_id";
      case MetadataTypes.the_order:
        return "the_order_id";
      default:
        throw "Unsupported Type";
    }
  }
}

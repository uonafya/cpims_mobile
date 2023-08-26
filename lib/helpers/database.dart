import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Models/case_plan_form.dart';
import '../Models/form_metadata.dart';

class DatabaseHelper {
  static const _databaseName = 'cpims6.db';
  static const _databaseVersion = 1;

  static const tableForm1A = 'form1a';
  static const childTableServices1A = 'services_1a';
  static const childTableCriticalEvents = 'critical_events';

  static const tableCasePlan = 'case_plan_form';
  static const childTableCasePlanServices = 'case_plan_services';


  static const childTableCasePlanServiceIds = 'case_plan_service_ids';
  static const childTableCasePlanResponsibleIds = 'case_plan_responsible_ids';

  static const columnGoalId = 'goal_id';
  static const columnPriorityId = 'priority_id';
  static const columnResultsId = 'results_id';
  static const columnReasonId = 'reason_id';
  static const columnGapId = 'gap_id';
  static const columnCompletionDate = 'completion_date';

  static const tableForm1B = 'form1b';
  static const childTableServices1B = 'services_1b';

  // shared column names
  static const columnId = '_id';
  static const columnOvcCpimsId = 'ovc_cpims_id';
  static const columnDateOfEvent = 'date_of_event';
  static const columnEventId = 'event_id';
  static const columnEventDate = 'event_date';

  // form metadata table
  static const tableFormMetaData = 'form_metadata';
  static const columnFieldName = 'field_name';
  static const columnItemId = 'item_id';
  static const columnItemDescription = 'item_description';
  static const columnItemSubCategory = 'item_sub_Category';
  static const columnTheOrder = 'the_order';

  late Database _db;

  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  //Delete the database
  Future deleteDB() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, _databaseName);
    await deleteDatabase(path);
  }

  //Close the database
  Future closeDB() async => _db.close();

  //SQL code to create the database table
  Future _onCreate(Database db, int version) async {

    await db.execute('''
        CREATE TABLE $tableFormMetaData (
          id INTEGER PRIMARY KEY,
          $columnItemId INTEGER,
          $columnFieldName TEXT NOT NULL,
          $columnItemDescription TEXT NOT NULL,
          $columnItemSubCategory TEXT
        )
        ''');

    await db.execute('''
      CREATE TABLE $tableCasePlan (
        $columnId INTEGER PRIMARY KEY,
        $columnOvcCpimsId TEXT NOT NULL,
        $columnDateOfEvent TEXT NOT NULL
      )
      ''');

    await db.execute('''
        CREATE TABLE $childTableCasePlanServices (
          id INTEGER PRIMARY KEY,
          form_id INTEGER NOT NULL,
          domain_id TEXT,
          $columnGoalId TEXT,
          $columnGapId TEXT,
          $columnPriorityId TEXT,
          $columnResultsId TEXT,
          $columnReasonId TEXT,
          $columnCompletionDate TEXT,
          FOREIGN KEY (form_id) REFERENCES $tableCasePlan($columnId)
        )
        ''');

    await db.execute('''
      CREATE TABLE $childTableCasePlanServiceIds (
        $columnId INTEGER PRIMARY KEY,
        'parent_id' INTEGER NOT NULL,
        'service_id' TEXT, 
        FOREIGN KEY (parent_id) REFERENCES $childTableCasePlanServices($columnId)
      )
      ''');
    await db.execute('''
      CREATE TABLE $childTableCasePlanResponsibleIds (
        $columnId INTEGER PRIMARY KEY,
        'parent_id' INTEGER NOT NULL,
        'responsible_id' TEXT, 
        FOREIGN KEY (parent_id) REFERENCES $childTableCasePlanServices($columnId)
      )
      ''');

    await db.execute('''
      CREATE TABLE $tableForm1A (
        $columnId INTEGER PRIMARY KEY,
        $columnOvcCpimsId TEXT NOT NULL,
        $columnDateOfEvent TEXT NOT NULL
      )
      ''');

    await db.execute('''
        CREATE TABLE $childTableServices1A (
          id INTEGER PRIMARY KEY,
          form_id INTEGER NOT NULL,
          domain_id TEXT NOT NULL,
          service_id TEXT NOT NULL,
          FOREIGN KEY (form_id) REFERENCES $tableForm1A($columnId)
        )
        ''');

    await db.execute('''
        CREATE TABLE $childTableCriticalEvents (
          id INTEGER PRIMARY KEY,
          form_id INTEGER NOT NULL,
          $columnEventId TEXT,
          $columnEventDate TEXT,
          FOREIGN KEY (form_id) REFERENCES $tableForm1A($columnId)
        )

        ''');

    await db.execute('''
      CREATE TABLE $tableForm1B (
        $columnId INTEGER PRIMARY KEY,
        $columnOvcCpimsId TEXT NOT NULL,
        $columnDateOfEvent TEXT NOT NULL
      )
      ''');

    await db.execute('''
        CREATE TABLE $childTableServices1B (
          id INTEGER PRIMARY KEY,
          form_id INTEGER NOT NULL,
          domain_id TEXT NOT NULL,
          service_id TEXT NOT NULL,
          FOREIGN KEY (form_id) REFERENCES $tableForm1B($columnId)
        )
        ''');
  }

  // insert formData(either form1a or form1b)
  Future<void> insertForm1Data(String table, formData) async {
    final formId = await _db.insert(
      table,
      {
        'ovc_cpims_id': formData.ovcCpimsId,
        'date_of_event': formData.dateOfEvent,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // insert critical events
    if (table == "form1a") {
      // insert services
    for (var service in formData.services) {
      await _db.insert(
        childTableServices1A,
        {
          'form_id': formId,
          'domain_id': service['domain_id'],
          'service_id': service['service_id'],
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
      for (var criticalEvent in formData.criticalEvents) {
        await _db.insert(
          childTableCriticalEvents,
          {
            'form_id': formId,
            'domain_id': criticalEvent['domain_id'],
            'service_id': criticalEvent['service_id'],
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    } else {
      print("ourPrint ");
      // insert services
      for (var service in formData.services) {
        print("ourservice$service");
        await _db.insert(
          childTableServices1B,
          {
            'form_id': formId,
            'domain_id': service.domainId ?? ' ',
            'service_id': service.serviceId,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }
  }

  // from 1a or 1b
  // all rows returned as a list of maps, where each map is a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllForm1Rows(String table) async {
    List<Map<String, dynamic>> map = await _db.query(table);

    if(table == "form1a") {
      List<Map<String, dynamic>> form1ServicesMap = await _db.query(childTableServices1A);
      List<Map<String, dynamic>> form1ACriticalEventsMap = await _db.query(childTableCriticalEvents);

      Map<int, List<Map<String, dynamic>>> servicesMap = {};
      for (var service in form1ServicesMap) {
        final formId = service['form_id'];
        servicesMap[formId] ??= [];
        servicesMap[formId]!.add(service);
      }

      Map<int, List<Map<String, dynamic>>> criticalEventsMap = {};
      for (var event in form1ACriticalEventsMap) {
        final formId = event['form_id'];
        criticalEventsMap[formId] ??= [];
        criticalEventsMap[formId]!.add(event);
      }

      // Create a new list with associated services
      List<Map<String, dynamic>> form1AWithServicesAndEvents = [];
      for (var form1 in map) {
        final formId = form1['_id'];
        final services = servicesMap[formId] ?? [];
        final events = criticalEventsMap[formId] ?? [];

        form1AWithServicesAndEvents.add({
          ...form1,
          'services': services,
          'critical_events': events
        });
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>services:$services");
      }
      return form1AWithServicesAndEvents;
    } else if (table == 'form1b'){
      List<Map<String, dynamic>> form1ServicesMap = await _db.query(childTableServices1B);

      Map<int, List<Map<String, dynamic>>> servicesMap = {};
      for (var service in form1ServicesMap) {
        final formId = service['form_id'];
        servicesMap[formId] ??= [];
        servicesMap[formId]!.add(service);
      }

      // Create a new list with associated services
      List<Map<String, dynamic>> form1BWithServices = [];
      for (var form1 in map) {
        final formId = form1['_id'];
        final services = servicesMap[formId] ?? [];

        form1BWithServices.add({
          ...form1,
          'services': services,
        });

      }
      return form1BWithServices;
    }

    return [];

   }

  // get a single row(form 1a or 1b)
  Future<Map<String, dynamic>> queryForm1Row(String table, int id) async {
    List<Map<String, dynamic>> queryRows = await _db.query(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return queryRows.first;
  }

  // delete from table(form 1a or 1b)
  Future<void> deleteForm1AData(String table, int id) async {
    await _db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }


  // insert Metadata
  Future<bool> insertMetadata (Metadata metadata) async {
    await _db.insert(
      tableFormMetaData,
      {
        columnItemId: metadata.itemId,
        columnFieldName: metadata.itemName,
        columnItemDescription: metadata.itemDescription,
        columnItemSubCategory: metadata.itemSubCategory,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return true;
  }


  Future<List<Map<String, dynamic>>> getMetadataByFieldName(String fieldName) async {

    try {
      final queryResult = await _db.query(
        tableFormMetaData,
        where: '$columnFieldName = ?',
        whereArgs: [fieldName],
      );

      // pass as Metadata
      // List<Metadata> metadataList = [];
      // for (var metadataJson in queryResult) {
      //   metadataList.add(Metadata.fromJson(metadataJson));
      // }
      return queryResult;
    } catch (e) {
      print('Error retrieving metadata: $e');
      return [];
    }
  }

  // Query All form Metat data
  Future<List<Map<String, dynamic>>> queryAllMetadataRows() async {
    List<Map<String, dynamic>> map = await _db.query(tableFormMetaData);
    return map;
  }

  //Query specific field Items
  Future<List<Map<String, dynamic>>> querySpecificFieldItems(String fieldName) async {
    const sql = 'SELECT * FROM $tableFormMetaData WHERE field_name = ?';
    final List<Map<String, dynamic>> results = await _db.rawQuery(sql, [fieldName]);
    return results;
  }


  // insert a case plan
  Future<bool> insertCasePlan(CasePlanModel casePlan) async {

    try {
      // Insert the main case plan information
      final casePlanId = await _db.insert(
        tableCasePlan,
        {
          columnOvcCpimsId: casePlan.ovcCpimsId,
          columnDateOfEvent: casePlan.dateOfEvent,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Insert the associated services
      for (var service in casePlan.services) {
        final serviceId = await _db.insert(
          childTableCasePlanServices,
          {
            'form_id': casePlanId,
            'domain_id': service.domainId,
            columnGoalId: service.goalId,
            columnGapId: service.gapId,
            columnPriorityId: service.priorityId,
            columnResultsId: service.resultsId,
            columnReasonId: service.reasonId,
            columnCompletionDate: service.completionDate,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        // Insert the associated service IDs
        for (var serviceId in service.serviceIds) {
          await _db.insert(
            childTableCasePlanServiceIds,
            {
              'parent_id': serviceId,
              'service_id': serviceId,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }

        // Insert the associated responsible IDs
        for (var responsibleId in service.responsibleIds) {
          await _db.insert(
            childTableCasePlanResponsibleIds,
            {
              'parent_id': serviceId,
              'responsible_id': responsibleId,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }

      return true;
    } catch (e) {
      print('Error inserting case plan: $e');
      return false;
    }
  }

  // get a single case plan
  Future<CasePlanModel?> getCasePlan(String ovcCpimsId) async {

    try {
      // Retrieve the main case plan information
      final mainQueryResult = await _db.query(
        tableCasePlan,
        where: '$columnOvcCpimsId = ?',
        whereArgs: [ovcCpimsId],
      );

      if (mainQueryResult.isNotEmpty) {
        final casePlanId = mainQueryResult.first[columnId] as int;

        // Retrieve the associated services
        final serviceQueryResult = await _db.query(
          childTableCasePlanServices,
          where: 'form_id = ?',
          whereArgs: [casePlanId],
        );

        List<CasePlanServiceModel> services = [];
        for (var serviceRow in serviceQueryResult) {
          final serviceId = serviceRow[columnId] as int;

          // Retrieve associated service IDs
          final serviceIdQueryResult = await _db.query(
            childTableCasePlanServiceIds,
            where: 'parent_id = ?',
            whereArgs: [serviceId],
          );

          List<String> serviceIds = serviceIdQueryResult
              .map((serviceIdRow) => serviceIdRow['service_id'].toString())
              .toList();

          // Retrieve associated responsible IDs
          final responsibleIdQueryResult = await _db.query(
            childTableCasePlanResponsibleIds,
            where: 'parent_id = ?',
            whereArgs: [serviceId],
          );

          List<String> responsibleIds = responsibleIdQueryResult
              .map((responsibleIdRow) => responsibleIdRow['responsible_id'].toString())
              .toList();

          services.add(CasePlanServiceModel(
            domainId: serviceRow['domain_id'] as String,
            serviceIds: serviceIds,
            goalId: serviceRow[columnGoalId] as String,
            gapId: serviceRow[columnGapId] as String,
            priorityId: serviceRow[columnPriorityId] as String,
            responsibleIds: responsibleIds,
            resultsId: serviceRow[columnResultsId] as String,
            reasonId: serviceRow[columnReasonId] as String,
            completionDate: serviceRow[columnCompletionDate] as String,
          ));
        }

        // Create and return the CasePlanModel instance
        return CasePlanModel(
          ovcCpimsId: mainQueryResult.first[columnOvcCpimsId] as String,
          dateOfEvent: mainQueryResult.first[columnDateOfEvent] as String,
          services: services,
        );
      }

      return null; // Return null if case plan not found
    } catch (e) {
      print('Error retrieving case plan: $e');
      return null;
    }
  }
}


// void main() async {
//   CasePlanModel newCasePlan = CasePlanModel(
//     ovcCpimsId: 'xyz',
//     dateOfEvent: '2023-06-13',
//     services: [
//       CasePlanServiceModel(
//         domainId: 'DEDU',
//         serviceIds: ['CPTS2e', 'CP96SC'],
//         goalId: 'CPTG1sc',
//         gapId: 'CPTG6e',
//         priorityId: 'CPTG5p',
//         responsibleIds: ['CGH', 'NGO'],
//         resultsId: '',
//         reasonId: '',
//         completionDate: '2023-07-13',
//       ),
//     ],
//   );
//
//   // Insert the new case plan
//   await insertCasePlan(newCasePlan);
//
//   print('Case plan inserted successfully');
// }

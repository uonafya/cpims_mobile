import 'package:cpims_mobile/Models/form_1a.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'cpims2.db';
  static const _databaseVersion = 1;

  static const tableForm1A = 'form1a';
  static const tableForm1B = 'form1b';
  static const childTableServices = 'services';
  static const childTableCriticalEvents = 'critical_events';

  static const columnId = '_id';
  static const columnOvcCpimsId = 'ovc_cpims_id';
  static const columnDateOfEvent = 'date_of_event';

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
      CREATE TABLE $tableForm1A (
        $columnId INTEGER PRIMARY KEY,
        $columnOvcCpimsId TEXT NOT NULL,
        $columnDateOfEvent TEXT NOT NULL
      )
      ''');

    await db.execute('''
        CREATE TABLE $childTableServices (
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
          domain_id TEXT,
          service_id,
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
        CREATE TABLE $childTableServices (
          id INTEGER PRIMARY KEY,
          form_id INTEGER NOT NULL,
          domain_id TEXT NOT NULL,
          service_id TEXT NOT NULL,
          FOREIGN KEY (form_id) REFERENCES $tableForm1B($columnId)
        )
        ''');
  }

  // insert formData
  Future<void> insertForm1Data(String table,formData) async {
    final formId = await _db.insert(
      table,
      {
        'ovc_cpims_id': formData.ovcCpimsId,
        'date_of_event': formData.dateOfEvent,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // insert services
    for (var service in formData.services) {
      await _db.insert(
        childTableServices,
        {
          'form_id': formId,
          'domain_id': service['domain_id'],
          'service_id': service['service_id'],
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    // insert critical events
    if (table == "form1a") {
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
    }
  }

  // all rows returned as a list of maps, where each map is a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    List<Map<String, dynamic>> map = await _db.query(table);
    List<Map<String, dynamic>> form1ServicesMap = await _db.query(childTableServices);


    // Create a map of form_id to associated services
    Map<int, List<Map<String, dynamic>>> servicesMap = {};
    for (var service in form1ServicesMap) {
      final formId = service['form_id'];
      servicesMap[formId] ??= [];
      servicesMap[formId]!.add(service);
    }

    if(table == "form1a") {
      List<Map<String, dynamic>> form1ACriticalEventsMap = await _db.query(childTableCriticalEvents);
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

      }
      print(form1AWithServicesAndEvents);
      return form1AWithServicesAndEvents;
    }
      // Create a new list with associated services
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
    print(form1BWithServices);
    return form1BWithServices;
   }


  // get a single row
  Future<Map<String, dynamic>> queryRow(String table, int id) async {
    List<Map<String, dynamic>> queryRows = await _db.query(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return queryRows.first;
  }

  // delete from table
  Future<void> deleteForm1AData(String table, int id) async {
    await _db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}

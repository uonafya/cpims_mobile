
import 'package:cpims_mobile/Models/case_load.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CaseLoadDb {
  static final CaseLoadDb instance = CaseLoadDb._init();
  static Database? _database;

  CaseLoadDb._init();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await _initDB('children_ovc.db');

    return _database!;
  }

//create database and child table

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableOvc (
        ${OvcFields.id} $idType,
        ${OvcFields.cboID} $textType,
        ${OvcFields.ovcFirstName} $textType,
        ${OvcFields.ovcSurname} $textType,
        ${OvcFields.registationDate} $textType,
        ${OvcFields.dateOfBirth} $textType,
        ${OvcFields.caregiverNames} $textType,
        ${OvcFields.sex} $textType
      )
    ''');
  }

  Future<void> insertDoc(CaseLoadModel caseLoadModel) async {
    final db = await instance.database;

    await db.insert(tableOvc, caseLoadModel.toJson());
  }

  Future<List<CaseLoadModel>> retrieveCaseLoads() async {
    final db = await instance.database;
    final result = await db.query(tableOvc);
    print('Local Model $result');
    return result.map((json) => CaseLoadModel.fromJson(json)).toList();
  }

  // table name and field names
  static const tableOvc = 'ovcs';
}

class OvcFields {
  static final List<String> values = [
    id,
    cboID,
    ovcFirstName,
    ovcSurname,
    dateOfBirth,
    caregiverNames,
    sex
  ];

  static const String id = '_id';
  static const String cboID = 'cbo_id';
  static const String ovcFirstName = 'ovc_first_name';
  static const String ovcSurname = 'ovc_surname';
  static const String dateOfBirth = 'date_of_birth';
  static const String registationDate = 'registration_date';
  static const String caregiverNames = 'caregiver_names';
  static const String sex = 'sex';
}

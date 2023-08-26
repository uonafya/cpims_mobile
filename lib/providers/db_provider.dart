// ignore_for_file: depend_on_referenced_packages

import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/Models/statistic_model.dart';
import 'package:cpims_mobile/screens/cpara/model/cpara_model.dart';
import 'package:cpims_mobile/screens/cpara/model/detail_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../screens/cpara/widgets/ovc_sub_population_form.dart';

class LocalDb {
  static final LocalDb instance = LocalDb._init();
  static Database? _database;

  LocalDb._init();

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
    return await openDatabase(path, version: 1, onCreate: _createTables);
  }

  Future<void> _createTables(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $caseloadTable (
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

    await db.execute('''
      CREATE TABLE $statisticsTable (
        ${SummaryFields.id} $idType,
        ${SummaryFields.children} $textType,
        ${SummaryFields.caregivers} $textType,
        ${SummaryFields.government} $textType,
        ${SummaryFields.ngo} $textType,
        ${SummaryFields.caseRecords} $textType,
        ${SummaryFields.pendingCases} $textType,
        ${SummaryFields.orgUnits} $textType,
        ${SummaryFields.workforceMembers} $textType,
        ${SummaryFields.household} $textType,
        ${SummaryFields.childrenAll} $textType,
        ${SummaryFields.ovcSummary} $textType,
        ${SummaryFields.ovcRegs} $textType,
        ${SummaryFields.caseRegs} $textType,
        ${SummaryFields.caseCats} $textType,
        ${SummaryFields.criteria} $textType,
        ${SummaryFields.orgUnit} $textType,
        ${SummaryFields.orgUnitId} $textType,
        ${SummaryFields.details} $textType
      )
''');

    await creatingCparaTables(db, version);
    await createOvcSubPopulation(db, version);
  }

  Future<void> insertCaseLoad(CaseLoadModel caseLoadModel) async {
    final db = await instance.database;

    await db.insert(caseloadTable, caseLoadModel.toJson());
  }


  Future<void> insertStatistics(SummaryDataModel summaryModel) async {
    final db = await instance.database;

    await db.insert(statisticsTable, summaryModel.toJson());
  }

  Future<List<CaseLoadModel>> retrieveCaseLoads() async {
    final db = await instance.database;
    final result = await db.query(caseloadTable);
    return result.map((json) => CaseLoadModel.fromJson(json)).toList();
  }

  Future<List<SummaryDataModel>> retrieveStatistics() async {
    final db = await instance.database;
    final result = await db.query(statisticsTable);
    return result.map((json) => SummaryDataModel.fromJson(json)).toList();
  }

  Future<void> creatingCparaTables(Database db, int version) async {
    try {
      debugPrint("Creating Cpara tables");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS Form(id INTEGER PRIMARY KEY, date TEXT);");

      // await db.execute(
      //     "CREATE TABLE IF NOT EXISTS Child(childOVCCPMISID TEXT PRIMARY KEY, childName TEXT, childAge TEXT, childGender TEXT, childSchool TEXT, childOVCRegistered TEXT);");

      // await db.execute(
      //     "CREATE TABLE IF NOT EXISTS Household(householdID TEXT PRIMARY KEY);");

      // await db.execute(
      //     "CREATE TABLE IF NOT EXISTS HouseholdChild(childID TEXT, householdID TEXT, FOREIGN KEY (householdID) REFERENCES Household(householdID), PRIMARY KEY(childID, householdID));");

      await db.execute(
          "CREATE TABLE IF NOT EXISTS HouseholdAnswer(formID INTEGER, id INTEGER PRIMARY KEY, houseHoldID TEXT, questionID TEXT, answer TEXT, FOREIGN KEY (formID) REFERENCES Form(id));");



    } catch (err) {
      debugPrint("OHH SHIT!");
      debugPrint(err.toString());
      debugPrint("OHH SHIT");
    }
  }

  Future<void> createOvcSubPopulation(Database db, int version) async {
    try {
      await db.execute('''
      CREATE TABLE $ovcsubpopulation (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uuid TEXT,
        cpims_id TEXT,
        criteria TEXT,
        date_of_service DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');
    } catch (err) {
      debugPrint(err.toString());
    }
  }


  Future<void> insertCparaData({required CparaModel cparaModelDB, required String ovcId}) async {
    final db = await instance.database;

    // Create form
    cparaModelDB
        .createForm(db)
        .then((value) {
      // Get formID
      cparaModelDB
          .getLatestFormID(db)
          .then((formData) {
        var formDate = formData.formDate;
        var formDateString =
        formDate.toString().split(' ')[0];
        var formID = formData.formID;
        cparaModelDB
            .addHouseholdFilledQuestionsToDB(
            db,
            "Test House",
            formDateString,
            ovcId,
            formID);
      });
    });
  }

  Future<void> insertOvcPrepopulationData(String uuid,String cpimsId,List<CheckboxQuestion> questions) async{
    final db = await instance.database;
   for(var question in questions){
     int value= question.isChecked! ? 1 : 0;
     await db.insert(ovcsubpopulation, {
       'uuid':uuid,
       'cpims_id':cpimsId,
       'criteria':question.questionID,
     },conflictAlgorithm: ConflictAlgorithm.replace
     );
   }

  }

  // table name and field names
  static const caseloadTable = 'ovcs';
  static const statisticsTable = 'statistics';
  static const ovcsubpopulation='ovcsubpopulation';
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

class SummaryFields {
  static final List<String> values = [
    id,
    children,
    caregivers,
    government,
    ngo,
    caseRecords,
    pendingCases,
    orgUnits,
    workforceMembers,
    household,
    childrenAll,
    ovcSummary,
    ovcRegs,
    caseRegs,
    caseCats,
    criteria,
    orgUnit,
    orgUnitId,
    details
  ];

  static const String id = '_id';
  static const String children = 'children';
  static const String caregivers = 'caregivers';
  static const String government = 'government';
  static const String ngo = 'ngo';
  static const String caseRecords = 'case_records';
  static const String pendingCases = 'pending_cases';
  static const String orgUnits = 'org_units';
  static const String workforceMembers = 'workforce_members';
  static const String household = 'household';
  static const String childrenAll = 'children_all';
  static const String ovcSummary = 'ovc_summary';
  static const String ovcRegs = 'ovc_regs';
  static const String caseRegs = 'case_regs';
  static const String caseCats = 'case_cats';
  static const String criteria = 'criteria';
  static const String orgUnit = 'org_unit';
  static const String orgUnitId = 'org_unit_id';
  static const String details = 'details';
}


// ignore_for_file: depend_on_referenced_packages
import 'dart:async';

import 'package:cpims_mobile/Models/case_load_model.dart';
import 'package:cpims_mobile/Models/form_metadata_model.dart';
import 'package:cpims_mobile/Models/statistic_model.dart';
import 'package:cpims_mobile/screens/cpara/model/cpara_model.dart';
import 'package:cpims_mobile/screens/cpara/model/ovc_model.dart';
import 'package:cpims_mobile/screens/cpara/widgets/ovc_sub_population_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_current_status_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/hiv_risk_assessment_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_assessment/progress_monitoring_form.dart';
import 'package:cpims_mobile/screens/forms/hiv_management/models/hiv_management_form_model.dart';
import 'package:cpims_mobile/utils/app_form_metadata.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Models/caseplan_form_model.dart';
import '../constants.dart';
import '../screens/forms/form1a/new/form_one_a.dart';

class LocalDb {
  static const String _databaseName = 'children_ovc4.db';
  static final LocalDb instance = LocalDb._init();
  static Database? _database;

  LocalDb._init();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await _initDB(_databaseName);

    return _database!;
  }

  Future<void> deleteDb() async {
    databaseFactory.deleteDatabase(_databaseName);
    _database = null;
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
    const textTypeNull = 'TEXT NULL';
    const intType = 'INTEGER';

    await db.execute('''
      CREATE TABLE $caseloadTable (
        ${OvcFields.id} $idType,
        ${OvcFields.cboID} $textType,
        ${OvcFields.ovcFirstName} $textType,
        ${OvcFields.ovcSurname} $textType,
        ${OvcFields.registationDate} $textType,
        ${OvcFields.dateOfBirth} $textType,
        ${OvcFields.caregiverNames} $textType,
        ${OvcFields.sex} $textType,
        ${OvcFields.caregiverCpimsId} $textType,
        ${OvcFields.chvCpimsId} $textType,
        ${OvcFields.ovchivstatus} $textType
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

    await db.execute('''
      CREATE TABLE $casePlanTable (
        ${CasePlan.id} $idType,
        ${CasePlan.ovcCpimsId} $textType,
        ${CasePlan.dateOfEvent} $textType,
        ${CasePlan.formDateSynced} $textTypeNull
      )
      ''');

    await db.execute('''
        CREATE TABLE $casePlanServicesTable (
          ${CasePlanServices.id} $idType,
          ${CasePlanServices.formId} $intType,
          ${CasePlanServices.domainId} $textType,
          ${CasePlanServices.goalId} $textType,
          ${CasePlanServices.priorityId} $textType,
          ${CasePlanServices.gapId} $textType,
          ${CasePlanServices.serviceIds} $textType,
          ${CasePlanServices.resultsId} $textType,
          ${CasePlanServices.reasonId} $textType,
          ${CasePlanServices.completionDate} $textType,
          ${CasePlanServices.responsibleIds} $textType,
          FOREIGN KEY (${CasePlanServices.formId}) REFERENCES $casePlanTable(${CasePlan.id})
        )
        ''');

    await db.execute('''
        CREATE TABLE $tableFormMetadata (
          ${FormMetadata.columnId} $idType,
          ${FormMetadata.columnItemId} $textType,
          ${FormMetadata.columnFieldName} $textType,
          ${FormMetadata.columnItemDescription} $textType,
          ${FormMetadata.columnItemSubCategory} $textType,
          ${FormMetadata.columnTheOrder} $textType
        )
        ''');

    await db.execute('''
        CREATE TABLE $form1Table (
          ${Form1.id} $idType,
          ${Form1.uuid} $textType,
          ${Form1.ovcCpimsId} $textType,
          ${Form1.dateOfEvent} $textType,
          ${Form1.formType} $textType,
          ${Form1.formDateSynced} $textTypeNull
        )
        ''');

    // created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    await db.execute('''
  CREATE TABLE $form1ServicesTable (
    ${Form1Services.id} $idType,
    ${Form1Services.formId} $intType,
    ${Form1Services.domainId} $textType,
    ${Form1Services.serviceId} $textType,
    FOREIGN KEY (${Form1Services.formId}) REFERENCES $form1Table(${Form1.id})
  )
''');

    await db.execute('''
      CREATE TABLE $form1CriticalEventsTable (
        ${Form1CriticalEvents.id} $idType,
        ${Form1CriticalEvents.formId} $textType,
        ${Form1CriticalEvents.eventId} $textType,
        ${Form1CriticalEvents.eventDate} $textType,
        FOREIGN KEY (${Form1CriticalEvents.formId}) REFERENCES $form1Table(${Form1.id})
        )
      ''');

    await creatingCparaTables(db, version);
    await createOvcSubPopulation(db, version);
    await createAppMetaDataTable(db, version);
    await createHRSForms(db, version);
    await createHMFForms(db, version);
  }

  Future<void> createAppMetaDataTable(Database db, int version) async {
    try {
      await db.execute('''
     CREATE TABLE app_form_metadata (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        form_id TEXT,
        location_lat TEXT,
        location_long TEXT,
        start_of_interview TEXT,
        end_of_interview TEXT,
        form_type TEXT
      )
    ''');
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> insertCaseLoad(CaseLoadModel caseLoadModel) async {
    try {
      final db = await instance.database;

      await db.insert(caseloadTable, caseLoadModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      debugPrint("Error inserting caseload data: $e");
    }
  }

  Future<void> insertMultipleCaseLoad(
      List<CaseLoadModel> caseLoadModelList) async {
    try {
      final db = await instance.database;

      // Use a batch to insert all the data at once
      final batch = db.batch();

      for (final caseLoadModel in caseLoadModelList) {
        batch.insert(
          caseloadTable,
          caseLoadModel.toMap(), // Convert the model to a map
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      // Commit the batch to insert all the data in a single transaction
      await batch.commit(noResult: true);
    } catch (e) {
      debugPrint("Error inserting caseload data: $e");
    }
  }

  Future<void> updateMultipleCaseLoad(
      List<CaseLoadModel> caseLoadModelList) async {
    try {
      final db = await instance.database;

      // Use a batch to update all the data at once
      final batch = db.batch();

      for (final caseLoadModel in caseLoadModelList) {
        batch.update(
          caseloadTable,
          caseLoadModel.toMap(),
          where: 'ovc_cpims_id = ?',
          // Provide a condition to specify which records to update
          whereArgs: [caseLoadModel.cpimsId],
          // Provide the ID of the record to update
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      // Commit the batch to update all the data in a single transaction
      await batch.commit(noResult: true);
    } catch (e) {
      debugPrint("Error updating caseload data: $e");
    }
  }

  //delete all caseload data
  Future<void> deleteAllCaseLoad() async {
    try {
      final db = await instance.database;
      await db.delete(caseloadTable);
    } catch (e) {
      debugPrint("Error deleting caseload data: $e");
    }
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
    await createCparaForms(db, version);
    try {
      debugPrint("Creating Cpara tables");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS HouseholdAnswer(formID INTEGER, id INTEGER PRIMARY KEY, houseHoldID TEXT, questionID TEXT, answer TEXT, FOREIGN KEY (formID) REFERENCES Form(id));");

      await db.execute(
          "CREATE TABLE IF NOT EXISTS ChildAnswer(formID INTEGER, id INTEGER PRIMARY KEY, childID TEXT, questionid TEXT, answer TEXT, FOREIGN KEY (formID) REFERENCES Form(id));");
    } catch (err) {
      debugPrint("Error creating Cpara tables: $err");
    }
  }

  Future<void> insertCparaData(
      {required CparaModel cparaModelDB,
      required String ovcId,
      required String startTime,
      required String careProviderId}) async {
    final db = await instance.database;
    var idForm = 0;
    String selectedDate = cparaModelDB.detail.dateOfAssessment ??
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    // Create form
    cparaModelDB.createForm(db, selectedDate).then((formUUID) {
      // Get formID
      cparaModelDB.getLatestFormID(db).then((formData) {
        var formDate = formData.formDate;
        var formDateString = formDate.toString().split(' ')[0];
        var formID = formData.formID;
        idForm = formID;
        cparaModelDB
            .addHouseholdFilledQuestionsToDB(db, formDateString, ovcId, formID)
            .then((value) {
          //insert app form metadata
          insertAppFormMetaData(formUUID, startTime, 'cpara').then((value) =>
              handleSubmit(
                  selectedDate: selectedDate,
                  formId: formID,
                  ovcSub: cparaModelDB.ovcSubPopulations));
        });
      });
    });
    // await handleSubmit(selectedDate: "selectedDate");
  }

  void handleSubmit(
      {required String selectedDate,
      required int formId,
      required CparaOvcSubPopulation ovcSub}) async {
    // CparaOvcSubPopulation ovcSub =
    //     context.read<CparaProvider>().cparaOvcSubPopulation ??
    //         CparaOvcSubPopulation();
    final localDb = LocalDb.instance;
    List<CparaOvcChild> listOfOvcChild = ovcSub.childrenQuestions ?? [];

    // final currentContext = context; // Store the context in a local variable

    try {
      for (var child in listOfOvcChild) {
        List<CheckboxQuestion> selectedQuestions = [];
        if (child.answer1 ?? false) {
          selectedQuestions.add(CheckboxQuestion(
              question: "question",
              id: 0,
              questionID: child.question1 ?? "double",
              isChecked: child.answer1 ?? false));
        }

        if (child.answer2 ?? false) {
          selectedQuestions.add(CheckboxQuestion(
              question: "question",
              id: 0,
              questionID: child.question2 ?? "AGYW",
              isChecked: child.answer2 ?? false));
        }

        if (child.answer3 ?? false) {
          selectedQuestions.add(CheckboxQuestion(
              question: "question",
              id: 0,
              questionID: child.question3 ?? "HEI",
              isChecked: child.answer3 ?? false));
        }

        if (child.answer4 ?? false) {
          selectedQuestions.add(CheckboxQuestion(
              question: "question",
              id: 0,
              questionID: child.question4 ?? "FSW",
              isChecked: child.answer4 ?? false));
        }

        if (child.answer5 ?? false) {
          selectedQuestions.add(CheckboxQuestion(
              question: "question",
              id: 0,
              questionID: child.question5 ?? "PLHIV",
              isChecked: child.answer5 ?? false));
        }

        if (child.answer6 ?? false) {
          selectedQuestions.add(CheckboxQuestion(
              question: "question",
              id: 0,
              questionID: child.question6 ?? "CLHIV",
              isChecked: child.answer6 ?? false));
        }

        if (child.answer7 ?? false) {
          selectedQuestions.add(CheckboxQuestion(
              question: "question",
              id: 0,
              questionID: child.question7 ?? "SVAC",
              isChecked: child.answer7 ?? false));
        }

        if (child.answer8 ?? false) {
          selectedQuestions.add(CheckboxQuestion(
              question: "question",
              id: 0,
              questionID: child.question8 ?? "AHIV",
              isChecked: child.answer8 ?? false));
        }

        // String uuid = const Uuid().v4();
        // String? dateOfAssessment = selectedDate != null
        //     ? DateFormat('yyyy-MM-dd').format(selectedDate)
        //     : null;
        await localDb.insertOvcSubpopulationData(
            "$formId", "${child.ovcId}", selectedDate, selectedQuestions);
      }
      // if(mounted) {
      //   Navigator.pop(context);
      // }
    } catch (error) {
      throw ("Error Occurred");
      // if (currentContext.mounted) {
      //   showDialog(
      //     context: currentContext, // Use the local context
      //     builder: (context) => AlertDialog(
      //       title: const Text('Error'),
      //       content: Text('An error occurred: $error'),
      //       actions: [
      //         TextButton(
      //           onPressed: () {
      //             Get.back(); // Close the dialog
      //           },
      //           child: const Text('OK'),
      //         ),
      //       ],
      //     ),
      //   );
      // }
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
        date_of_event TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        form_date_synced TEXT NULL
      )
    ''');
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> createCparaForms(Database db, int version) async {
    try {
      await db.execute('''
      CREATE TABLE $cparaForms (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        form_id INTEGER,
        date TEXT,
        uuid TEXT,
        form_date_synced TEXT NULL
      )
    ''');
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> createHRSForms(Database db, int version) async {
    // Define the table name

    // Define the table schema with all the fields
    const String createTableQuery = '''
    CREATE TABLE $HRSForms (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ovc_cpims_id TEXT,
      HIV_RA_1A TEXT,
      HIV_RS_01 TEXT,
      HIV_RS_02 TEXT,
      HIV_RS_03 TEXT,
      HIV_RS_04 TEXT,
      HIV_RS_05 TEXT,
      HIV_RS_06 TEXT,
      HIV_RS_09 TEXT,
      HIV_RS_06A TEXT,
      HIV_RS_07 TEXT,
      HIV_RS_08 TEXT,
      HIV_RS_10 TEXT,
      HIV_RS_10A TEXT,
      HIV_RS_10B TEXT,
      HIV_RS_11 TEXT,
      HIV_RS_14 TEXT,
      HIV_RS_15 TEXT,
      HIV_RS_16 TEXT,
      HIV_RS_17 TEXT,
      HIV_RS_18 TEXT,
      HIV_RS_18A TEXT,
      HIV_RS_18B TEXT,
      HIV_RS_21 TEXT,
      HIV_RS_22 TEXT,
      HIV_RS_23 TEXT,
      HIV_RS_24 TEXT,
      HIV_RA_3Q6 TEXT
    )
  ''';

    try {
      await db.execute(createTableQuery);
    } catch (e) {
      print('Error creating table: $e');
    }
  }

  Future<void> insertHRSData(
      String cpmisId,
      HIVCurrentStatusModel currentStatus,
      HIVRiskAssessmentModel assessment,
      ProgressMonitoringModel progress) async {
    final db = await instance.database;
    await db.insert(
      HRSForms,
      {
        'ovc_cpims_id': cpmisId,
        'HIV_RA_1A': currentStatus.dateOfAssessment,
        'HIV_RS_01': currentStatus.statusOfChild,
        'HIV_RS_02': currentStatus.hivStatus,
        'HIV_RS_03': currentStatus.hivTestDone,
        'HIV_RS_04': assessment.biologicalFather,
        'HIV_RS_05': assessment.malnourished,
        'HIV_RS_06': assessment.sexualAbuse,
        'HIV_RS_09': assessment.sexualAbuseAdolescent,
        'HIV_RS_06A': assessment.traditionalProcedures,
        'HIV_RS_07': assessment.persistentlySick,
        'HIV_RS_08': assessment.tb,
        'HIV_RS_10': assessment.sexualIntercourse,
        'HIV_RS_10A': assessment.symptomsOfSTI,
        'HIV_RS_10B': assessment.ivDrugUser,
        'HIV_RS_11': assessment.finalEvaluation,
        'HIV_RS_14': progress.parentAcceptHivTesting,
        'HIV_RS_15': progress.parentAcceptHivTestingDate,
        'HIV_RS_16': progress.formalReferralMade,
        'HIV_RS_17': progress.formalReferralMadeDate,
        'HIV_RS_18': progress.formalReferralCompleted,
        'HIV_RS_18A': progress.reasonForNotMakingReferral,
        'HIV_RS_18B': progress.hivTestResult,
        'HIV_RS_21': progress.referredForArt,
        'HIV_RS_22': progress.referredForArtDate,
        'HIV_RS_23': progress.artReferralCompleted,
        'HIV_RS_24': progress.artReferralCompletedDate,
        'HIV_RA_3Q6': progress.facilityOfArtEnrollment,
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchHRSFormData() async {
    final db = await LocalDb.instance.database;
    final hrsData = await db.query(HRSForms);
    return hrsData;
  }

  // create HIVManagement table
  Future<void> createHMFForms(Database db, int version) async {
    // Define the table schema with all the fields
    const String createTableQuery = '''
    CREATE TABLE $hmfForms (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ovc_cpims_id TEXT,
      date_of_event TEXT,
      HIV_MGMT_1_A TEXT,
      HIV_MGMT_1_B TEXT,
      HIV_MGMT_1_C TEXT,
      HIV_MGMT_1_D TEXT,
      HIV_MGMT_1_E TEXT,
      HIV_MGMT_1_E_DATE TEXT,
      HIV_MGMT_1_F TEXT,
      HIV_MGMT_1_F_DATE TEXT,
      HIV_MGMT_1_G TEXT,
      HIV_MGMT_1_G_DATE TEXT,
      HIV_MGMT_2_A TEXT,
      HIV_MGMT_2_B TEXT,
      HIV_MGMT_2_C TEXT,
      HIV_MGMT_2_D TEXT,
      HIV_MGMT_2_E TEXT,
      HIV_MGMT_2_F TEXT,
      HIV_MGMT_2_G TEXT,
      HIV_MGMT_2_H_2 TEXT,
      HIV_MGMT_2_H_3 TEXT,
      HIV_MGMT_2_H_4 TEXT,
      HIV_MGMT_2_H_5 TEXT,
      HIV_MGMT_2_I_1 TEXT,
      HIV_MGMT_2_I_DATE TEXT,
      HIV_MGMT_2_J TEXT,
      HIV_MGMT_2_K TEXT,
      HIV_MGMT_2_L_1 TEXT,
      HIV_MGMT_2_L_2 TEXT,
      HIV_MGMT_2_M TEXT,
      HIV_MGMT_2_N TEXT,
      HIV_MGMT_2_O_1 TEXT,
      HIV_MGMT_2_O_2 TEXT,
      HIV_MGMT_2_P TEXT,
      HIV_MGMT_2_Q TEXT,
      HIV_MGMT_2_R TEXT,
      HIV_MGMT_2_S TEXT,
    )
  ''';

    try {
      await db.execute(createTableQuery);
    } catch (e) {
      if (kDebugMode) {
        print('Error creating table: $e');
      }
    }
  }

  Future<void> insertHMFFormData(
    String cpmisId,
    ARTTherapyHIVFormModel artTherapyHIVFormModel,
    HIVVisitationFormModel hivVisitationFormModel,
  ) async {
    final db = await instance.database;
    await db.insert(
      hmfForms,
      {
        'ovc_cpims_id': cpmisId,
        'date_of_event': artTherapyHIVFormModel.dateOfEvent,
        'HIV_MGMT_1_A': artTherapyHIVFormModel.dateHIVConfirmedPositive,
        'HIV_MGMT_1_B': artTherapyHIVFormModel.dateTreatmentInitiated,
        'HIV_MGMT_1_C': artTherapyHIVFormModel.baselineHEILoad,
        'HIV_MGMT_1_D': artTherapyHIVFormModel.dateStartedFirstLine,
        'HIV_MGMT_1_E': artTherapyHIVFormModel.arvsSubWithFirstLine,
        'HIV_MGMT_1_E_DATE': artTherapyHIVFormModel.arvsSubWithFirstLineDate,
        'HIV_MGMT_1_F': artTherapyHIVFormModel.switchToSecondLine,
        'HIV_MGMT_1_F_DATE': artTherapyHIVFormModel.switchToSecondLineDate,
        'HIV_MGMT_1_G': artTherapyHIVFormModel.switchToThirdLine,
        'HIV_MGMT_1_G_DATE': artTherapyHIVFormModel.switchToThirdLineDate,
        'HIV_MGMT_2_A': hivVisitationFormModel.visitDate,
        'HIV_MGMT_2_B': hivVisitationFormModel.durationOnARTs,
        'HIV_MGMT_2_C': hivVisitationFormModel.height,
        'HIV_MGMT_2_D': hivVisitationFormModel.mUAC,
        'HIV_MGMT_2_E': hivVisitationFormModel.arvDrugsAdherence,
        'HIV_MGMT_2_F': hivVisitationFormModel.arvDrugsDuration,
        'HIV_MGMT_2_G': hivVisitationFormModel.adherenceCounseling,
        'HIV_MGMT_2_H_2': hivVisitationFormModel.treatmentSupporter,
        'HIV_MGMT_2_H_3': hivVisitationFormModel.treatmentSupporterSex,
        'HIV_MGMT_2_H_4': hivVisitationFormModel.treatmentSupporterAge,
        'HIV_MGMT_2_H_5': hivVisitationFormModel.treatmentSupporterHIVStatus,
        'HIV_MGMT_2_I_1': hivVisitationFormModel.viralLoadResults,
        'HIV_MGMT_2_I_DATE': hivVisitationFormModel.labInvestigationsDate,
        'HIV_MGMT_2_J': hivVisitationFormModel.detectableViralLoadInterventions,
        'HIV_MGMT_2_K': hivVisitationFormModel.disclosure,
        'HIV_MGMT_2_L_1': hivVisitationFormModel.mUACScore,
        'HIV_MGMT_2_L_2': hivVisitationFormModel,
        'HIV_MGMT_2_M': hivVisitationFormModel.nhifEnrollmentStatus,
        'HIV_MGMT_2_N': hivVisitationFormModel.supportGroupStatus,
        'HIV_MGMT_2_O_1': hivVisitationFormModel.nhifEnrollment,
        'HIV_MGMT_2_O_2': hivVisitationFormModel.nhifEnrollmentStatus,
        'HIV_MGMT_2_P': hivVisitationFormModel.referralServices,
        'HIV_MGMT_2_Q': hivVisitationFormModel.nextAppointmentDate,
        'HIV_MGMT_2_R': hivVisitationFormModel.peerEducatorName,
        'HIV_MGMT_2_S': hivVisitationFormModel.peerEducatorContact,
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchHMFFormData() async {
    final db = await LocalDb.instance.database;
    final hmfFormData = await db.query(hmfForms);
    return hmfFormData;
  }

  Future<void> insertOvcSubpopulationData(String uuid, String cpimsId,
      String dateOfAssessment, List<CheckboxQuestion> questions) async {
    final db = await instance.database;
    for (var question in questions) {
      await db.insert(
          ovcsubpopulation,
          {
            'uuid': uuid,
            'cpims_id': cpimsId,
            'criteria': question.questionID,
            'date_of_event': dateOfAssessment,
            'form_date_synced': null
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<Map<String, dynamic>>> fetchOvcSubPopulationData() async {
    final db = await LocalDb.instance.database;
    final result = await db.query(ovcsubpopulation);
    return result;
  }

  // insert Metadata
  Future<bool> insertMetadata(Metadata metadata) async {
    final db = await instance.database;
    await db.insert(tableFormMetadata, metadata.toJson());
    return true;
  }

  // Query All form Metadata
  Future<List<Map<String, dynamic>>> queryAllMetadataRows() async {
    final db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(tableFormMetadata);
    return results;
  }

  //Query specific field Items
  Future<List<Map<String, dynamic>>> querySpecificMetadataFieldItems(
      String fieldName) async {
    final db = await instance.database;
    const sql = 'SELECT * FROM $tableFormMetadata WHERE field_name = ?';
    final List<Map<String, dynamic>> results =
        await db.rawQuery(sql, [fieldName]);
    return results;
  }

  Future<void> insertAppFormMetaData(uuid, startOfInterview, formType) async {
    final db = await instance.database;
    Position userLocation = await getUserLocation(); // Await the location here
    String lat = userLocation.latitude.toString();
    String longitude = userLocation.longitude.toString();
    await db.insert(
      appFormMetaDataTable,
      {
        'form_id': uuid,
        'location_lat': lat,
        'location_long': longitude,
        'start_of_interview': startOfInterview,
        'end_of_interview': DateTime.now().toIso8601String(),
        'form_type': formType,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // insert formData(either form1a or form1b)
  Future<void> insertForm1Data(
      String formType, formData, metadata, uuid) async {
    try {
      final db = await instance.database;
      final formId = await db.insert(
        form1Table,
        {
          'ovc_cpims_id': formData.ovcCpimsId,
          'date_of_event': formData.dateOfEvent,
          'form_type': formType,
          'form_date_synced': null,
          'uuid': uuid,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      //insert app form metadata
      await insertAppFormMetaData(uuid, metadata.startOfInterview, formType);

      // insert services
      for (var service in formData.services) {
        await db.insert(
          form1ServicesTable,
          {
            'form_id': formId,
            'domain_id': service.domainId,
            'service_id': service.serviceId,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      for (var criticalEvent in formData.criticalEvents) {
        await db.insert(
          form1CriticalEventsTable,
          {
            'form_id': formId,
            'event_id': criticalEvent.eventId,
            'event_date': criticalEvent.eventDate,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error inserting form1 data: $e');
      }
    }
  }

  Future<List<Map<String, dynamic>>> queryAllForm1Rows(String formType) async {
    try {
      final db = await instance.database;
      const sql =
          'SELECT * FROM $form1Table WHERE form_type = ? AND form_date_synced IS NULL';
      final List<Map<String, dynamic>> form1Rows =
          await db.rawQuery(sql, [formType]);

      List<Map<String, dynamic>> updatedForm1Rows = [];

      for (var form1row in form1Rows) {
        int formId = form1row['_id'];

        // Fetch associated services
        final List<Map<String, dynamic>> services = await db.query(
          form1ServicesTable,
          where: '${Form1Services.formId} = ?',
          whereArgs: [formId],
        );

        // Fetch associated critical events
        final List<Map<String, dynamic>> criticalEvents = await db.query(
          form1CriticalEventsTable,
          where: '${Form1CriticalEvents.formId} = ?',
          whereArgs: [formId],
        );

        final AppFormMetaData appFormMetaData =
            await getAppFormMetaData(form1row['uuid']);

        // Create a new map that includes existing form1row data, services, critical_events, and ID
        Map<String, dynamic> updatedForm1Row = {
          ...form1row,
          'services': services,
          'critical_events': criticalEvents,
          'id': formId,
          'app_form_metadata': appFormMetaData.toJson(),
          'device_id': await getDeviceId(),
        };
        // Add the updated map to the list
        updatedForm1Rows.add(updatedForm1Row);
      }
      debugPrint("Updated form1 rows: $updatedForm1Rows");

      return updatedForm1Rows;
    } catch (e) {
      if (kDebugMode) {
        print("Error querying form1 data: $e");
      }
      return [];
    }
  }

  Future<int?> queryForm1UnsyncedForms(String formType) async {
    try {
      final db = await instance.database;
      const sql =
          'SELECT COUNT(*) FROM $form1Table WHERE form_type = ? AND form_date_synced IS NULL';
      final List<Map<String, dynamic>> result =
          await db.rawQuery(sql, [formType]);

      if (result.isNotEmpty) {
        return Sqflite.firstIntValue(result);
      } else {
        return 0; // Return 0 if no count is found.
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error querying form1 count: $e");
      }
      return 0; // Return 0 if there is an error.
    }
  }

  Future<Stream<int>> queryForm1UnsyncedFormsStream(String formType) async {
    final controller = StreamController<int>();

    try {
      final db = await instance.database;
      const sql =
          'SELECT COUNT(*) FROM $form1Table WHERE form_type = ? AND form_date_synced IS NULL';
      final List<Map<String, dynamic>> result =
          await db.rawQuery(sql, [formType]);

      if (result.isNotEmpty) {
        controller.add(Sqflite.firstIntValue(result)!);
      } else {
        controller.add(0); // Return 0 if no count is found.
      }

      controller.close(); // Close the stream when the operation is complete.
    } catch (e) {
      if (kDebugMode) {
        print("Error querying form1 count: $e");
      }
      controller.addError(e);
      controller.close();
    }

    return controller.stream;
  }

  // get a single row(form 1a or 1b)
  Future<bool> deleteForm1Data(String formType, int id) async {
    try {
      final db = await instance.database;
      final queryResults = await db.query(
        form1Table,
        where: '${Form1.id} = ?',
        whereArgs: [id],
      );

      if (queryResults.isNotEmpty) {
        final form1Id = queryResults.first[Form1.id] as int;
        await db.delete(
          form1ServicesTable,
          where: 'form_id = ?',
          whereArgs: [form1Id],
        );
        await db.delete(
          form1CriticalEventsTable,
          where: 'form_id = ?',
          whereArgs: [form1Id],
        );
        final rowsAffected = await db.delete(
          form1Table,
          where: '${Form1.id} = ?',
          whereArgs: [form1Id],
        );
        return rowsAffected > 0;
      }
      return false;
    } catch (e) {
      debugPrint("Error deleting form1 data: $e");
    }
    return false;
  }

  //update form1 date_synced column
  Future<void> updateForm1DataDateSync(String formType, int id) async {
    try {
      final db = await instance.database;
      final queryResults = await db.query(
        form1Table,
        where: '${Form1.id} = ?',
        whereArgs: [id],
      );

      if (queryResults.isNotEmpty) {
        final form1Id = queryResults.first[Form1.id] as int;
        await db.update(
          form1Table,
          {
            'form_date_synced': DateTime.now().toString(),
          },
          where: '${Form1.id} = ?',
          whereArgs: [form1Id],
        );
      }
    } catch (e) {
      debugPrint("Error updating form1 data: $e");
    }
  }

  //new insert case plan
  Future<bool> insertCasePlanNew(CasePlanModel casePlan) async {
    try {
      final db = await instance.database;
      await db.transaction((txn) async {
        final casePlanId = await txn.insert(
          casePlanTable,
          {
            'ovc_cpims_id': casePlan.ovcCpimsId,
            'date_of_event': casePlan.dateOfEvent,
            'form_date_synced': null,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        for (var service in casePlan.services) {
          debugPrint("Here the services ${casePlan.services}");
          final serviceIdList = service.serviceIds.join(',');
          final responsibleIdList = service.responsibleIds.join(',');

          await txn.insert(
            casePlanServicesTable,
            {
              'form_id': casePlanId,
              'domain_id': service.domainId,
              'goal_id': service.goalId,
              'gap_id': service.gapId,
              'priority_id': service.priorityId,
              'results_id': service.resultsId,
              'reason_id': service.reasonId,
              'completion_date': service.completionDate ?? '',
              'service_ids': serviceIdList,
              'responsible_ids': responsibleIdList,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });

      return true;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error inserting case plan: $e');
      }
      if (kDebugMode) {
        print('Stack trace: $stackTrace');
      }
      return false;
    }
  }

  Future<CasePlanModel?> getCasePlanById(String ovcCpimsId) async {
    try {
      // Retrieve the main case plan information
      final db = await instance.database;
      final mainQueryResult = await db.query(
        casePlanTable,
        where: '${CasePlan.ovcCpimsId} = ?',
        whereArgs: [ovcCpimsId],
      );

      if (mainQueryResult.isNotEmpty) {
        final casePlanId = mainQueryResult.first[CasePlan.id] as int;

        // Retrieve the associated services
        final serviceQueryResult = await db.query(
          casePlanTable,
          where: 'form_id = ?',
          whereArgs: [casePlanId],
        );

        List<CasePlanServiceModel> services = [];
        for (var serviceRow in serviceQueryResult) {
          services.add(CasePlanServiceModel(
            domainId: serviceRow['domain_id'] as String,
            serviceIds: (serviceRow['service_ids'] as String).split(','),
            // Parse comma-separated service IDs
            goalId: serviceRow[CasePlanServices.goalId] as String,
            gapId: serviceRow[CasePlanServices.gapId] as String,
            priorityId: serviceRow[CasePlanServices.priorityId] as String,
            responsibleIds:
                (serviceRow['responsible_ids'] as String).split(','),
            // Parse comma-separated responsible IDs
            resultsId: serviceRow[CasePlanServices.resultsId] as String,
            reasonId: serviceRow[CasePlanServices.reasonId] as String,
            completionDate:
                serviceRow[CasePlanServices.completionDate] as String,
          ));
        }

        // Create and return the CasePlanModel instance
        return CasePlanModel(
          ovcCpimsId: mainQueryResult.first[CasePlan.ovcCpimsId] as String,
          dateOfEvent: mainQueryResult.first[CasePlan.dateOfEvent] as String,
          services: services,
        );
      }

      return null; // Return null if case plan not found
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving case plan: $e');
      }
      return null;
    }
  }

  Future<List<CasePlanModel>> getAllUnsyncedCasePlans() async {
    try {
      final db = await instance.database;

      // Use a raw SQL query to select all rows from the table
      final queryResult = await db.rawQuery(
          'SELECT * FROM $casePlanTable WHERE form_date_synced IS NULL');

      List<CasePlanModel> casePlans = [];

      for (var row in queryResult) {
        final casePlanId = row[CasePlan.id] as int;

        // Retrieve the associated services
        final serviceQueryResult = await db.query(
          casePlanServicesTable,
          where: 'form_id = ?',
          whereArgs: [casePlanId],
        );

        List<CasePlanServiceModel> services = [];
        for (var serviceRow in serviceQueryResult) {
          services.add(CasePlanServiceModel(
            domainId: serviceRow['domain_id'] as String,
            serviceIds: (serviceRow['service_ids'] as String).split(','),
            goalId: serviceRow[CasePlanServices.goalId] as String,
            gapId: serviceRow[CasePlanServices.gapId] as String,
            priorityId: serviceRow[CasePlanServices.priorityId] as String,
            responsibleIds:
                (serviceRow['responsible_ids'] as String).split(','),
            resultsId: serviceRow[CasePlanServices.resultsId] as String,
            reasonId: serviceRow[CasePlanServices.reasonId] as String,
            completionDate:
                serviceRow[CasePlanServices.completionDate] as String,
          ));
        }

        casePlans.add(CasePlanModel(
          id: row[CasePlan.id] as int,
          ovcCpimsId: row[CasePlan.ovcCpimsId] as String,
          dateOfEvent: row[CasePlan.dateOfEvent] as String,
          services: services,
        ));
      }

      return casePlans;
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving case plans: $e');
      }
      return [];
    }
  }

  Future<int> getUnsyncedCasePlanCount() async {
    try {
      final db = await instance.database;
      final queryResult = await db.rawQuery(
          'SELECT COUNT(*) FROM $casePlanTable WHERE form_date_synced IS NULL');

      if (queryResult.isEmpty) {
        return 0; // No unsynced case plans found
      }

      // Extract the count from the first row
      final count = queryResult.first.values.first as int;

      return count;
    } catch (e) {
      debugPrint('Error retrieving unsynced case plan count: $e');
      return 0; // Handle the error and return 0
    }
  }

  Future<bool> deleteCasePlan(String ovcCpimsId) async {
    try {
      // Retrieve the case plan id to be deleted
      final db = await instance.database;
      final casePlanIdQueryResult = await db.query(
        casePlanTable,
        columns: [CasePlan.id],
        where: '${CasePlan.ovcCpimsId} = ?',
        whereArgs: [ovcCpimsId],
      );

      if (casePlanIdQueryResult.isNotEmpty) {
        final casePlanId = casePlanIdQueryResult.first[CasePlan.id] as int;

        // Delete associated services first
        await db.delete(
          casePlanServicesTable,
          where: 'form_id = ?',
          whereArgs: [casePlanId],
        );

        // Delete the main case plan entry
        final rowsAffected = await db.delete(
          casePlanTable,
          where: '${CasePlan.id} = ?',
          whereArgs: [casePlanId],
        );

        return rowsAffected >
            0; // Return true if any rows were affected (case plan was deleted)
      }

      return false; // Return false if case plan was not found
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting case plan: $e');
      }
      return false;
    }
  }

  Future<int> getUnsyncedCparaFormCount() async {
    final db = await instance.database;
    try {
      List<Map<String, dynamic>> countResult = await db.rawQuery(
          "SELECT COUNT(id) AS count FROM Form WHERE form_date_synced IS NULL");

      if (countResult.isNotEmpty) {
        int count = countResult[0]['count'];
        return count;
      } else {
        return 0;
      }
    } catch (err) {
      throw ("Could Not Get Unsynced Forms Count: ${err.toString()}");
    }
  }

  Future<int> countOvcSubpopulationDataWithNullDateSynced() async {
    final db = await LocalDb.instance.database;
    const sql =
        "SELECT COUNT(*) as count FROM ovcsubpopulation WHERE form_date_synced IS NULL";
    List<Map<String, dynamic>> result = await db.rawQuery(sql);
    if (result.isNotEmpty) {
      return result[0]['count'];
    } else {
      return 0;
    }
  }

  Future<AppFormMetaData> getAppFormMetaData(String uuid) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> metaDataList = await db.query(
      appFormMetaDataTable,
      where: 'form_id = ?',
      whereArgs: [uuid],
    );

    if (metaDataList.isNotEmpty) {
      return AppFormMetaData.fromJson(metaDataList.first);
    } else {
      // Handle the case where no metadata is found
      return const AppFormMetaData(); // You should replace this with an appropriate default value or error handling.
    }
  }
}

// table name and field names
const caseloadTable = 'ovcs';
const statisticsTable = 'statistics';
const tableFormMetadata = 'form_metadata';
const casePlanTable = 'case_plan';
const casePlanServicesTable = 'case_plan_services';
const form1Table = 'form1';
const appFormMetaDataTable = 'app_form_metadata';
const form1ServicesTable = 'form1_services';
const form1CriticalEventsTable = 'form1_critical_events';
const ovcsubpopulation = 'ovcsubpopulation';
const cparaForms = 'Form';
const HRSForms = 'HRSForm';
const hmfForms = 'HMFForm';
const cparaHouseholdAnswers = 'cpara_household_answers';
const cparaChildAnswers = 'cpara_child_answers';

class OvcFields {
  static final List<String> values = [
    id,
    cboID,
    ovcFirstName,
    ovcSurname,
    dateOfBirth,
    caregiverNames,
    sex,
    caregiverCpimsId,
    chvCpimsId,
    ovchivstatus,
  ];

  static const String id = '_id';
  static const String cboID = 'ovc_cpims_id';
  static const String ovcFirstName = 'ovc_first_name';
  static const String ovcSurname = 'ovc_surname';
  static const String dateOfBirth = 'date_of_birth';
  static const String registationDate = 'registration_date';
  static const String caregiverNames = 'caregiver_names';
  static const String sex = 'sex';
  static const String caregiverCpimsId = 'caregiver_cpims_id';
  static const String chvCpimsId = 'chv_cpims_id';
  static const String ovchivstatus = 'ovchivstatus';
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

class FormMetadata {
  static final List<String> values = [
    columnId,
    columnFieldName,
    columnItemId,
    columnItemDescription,
    columnItemSubCategory,
    columnTheOrder,
  ];
  static const String columnId = '_id';
  static const String columnFieldName = 'field_name';
  static const String columnItemId = 'item_id';
  static const String columnItemDescription = 'item_description';
  static const String columnItemSubCategory = 'item_sub_Category';
  static const String columnTheOrder = 'the_order';
}

class CasePlan {
  static final List<String> values = [
    id,
    ovcCpimsId,
    dateOfEvent,
    formDateSynced
  ];

  static const String id = 'id';
  static const String ovcCpimsId = 'ovc_cpims_id';
  static const String dateOfEvent = 'date_of_event';
  static const String formDateSynced = 'form_date_synced';
}

class CasePlanServices {
  static final List<String> values = [
    id,
    formId,
    domainId,
    goalId,
    priorityId,
    gapId,
    resultsId,
    reasonId,
    completionDate,
    responsibleIds,
    serviceIds
  ];
  static const String id = 'id';
  static const String formId = 'form_id';
  static const String domainId = 'domain_id';
  static const String goalId = 'goal_id';
  static const String priorityId = 'priority_id';
  static const String gapId = 'gap_id';
  static const String resultsId = 'results_id';
  static const String serviceIds = 'service_ids';
  static const String responsibleIds = 'responsible_ids';
  static const String reasonId = 'reason_id';
  static const String completionDate = 'completion_date';
}

class Form1 {
  static final List<String> values = [
    id,
    uuid,
    formType,
    ovcCpimsId,
    dateOfEvent,
  ];

  static const String id = "_id";
  static const String uuid = "uuid";
  static const String formType = "form_type";
  static const String ovcCpimsId = "ovc_cpims_id";
  static const String dateOfEvent = 'date_of_event';
  static const String formDateSynced = 'form_date_synced';
}

class Form1Services {
  static final List<String> values = [
    id,
    formId,
    domainId,
    serviceId,
  ];

  static const String id = "_id";
  static const String formId = "form_id";
  static const String domainId = "domain_id";
  static const String serviceId = "service_id";
}

class Form1CriticalEvents {
  static final List<String> values = [
    id,
    formId,
    eventId,
    eventDate,
  ];

  static const String id = "_id";
  static const String formId = "form_id";
  static const String eventId = "event_id";
  static const String eventDate = "event_date";
}

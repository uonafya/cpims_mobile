import 'package:sqflite/sqflite.dart';

Future<void> createUnapprovedCparaTables(Database db) async {
  // Creating table to store unapproved CPARA form
  await db.execute('''
    CREATE TABLE IF NOT EXISTS UnapprovedCPARA(
      id INTEGER PRIMARY KEY,
      date_of_event TEXT
    )
    ''');

  // Creating table to store answers of the form
  await db.execute('''
    CREATE TABLE IF NOT EXISTS UnapprovedCPARAAnswers(
      id INTEGER PRIMARY KEY,
      question_code TEXT,
      answer_id TEXT,
      ovc_cpims_id TEXT,
      form_id INTEGER,
      FOREIGN KEY (form_id) REFERENCES UnapprovedCPARA(id)
    )
    ''');
}

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Controller {
  static Future<void> script(Database db) async {
    await _createTaskTable(db);
    await _createSubjectTable(db);
  }

  static Future<Database> openDB() async {
    return openDatabase(join(getDatabasesPath().toString(), 'practica02.db'),
        onCreate: (db, version) {
      return script(db);
    }, version: 1);
  }

  static Future<void> _createTaskTable(Database db) async {
    await db.execute('CREATE TABLE task ('
        'idTask INTEGER PRIMARY KEY AUTOINCREMENT,'
        'idSubjectTask TEXT NOT NULL,'
        'dateTask TEXT NOT NULL,'
        'descriptionTask TEXT NOT NULL,'
        'FOREIGN KEY (idSubjectTask) REFERENCES subject(idSubject))');
  }

  static Future<void> _createSubjectTable(Database db) async {
    await db.execute('CREATE TABLE subject ('
        'idSubject TEXT PRIMARY KEY,'
        'nameSubject TEXT NOT NULL,'
        'semesterSubject TEXT NOT NULL,'
        'teacherSubject TEXT NOT NULL)');
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Controller {
  String _databasesPath = '';
  final _dbName = 'tarea04.db';
  Database? _db;

  /// Initialize the connection to the database
  Future<void> _initialize() async {
    // Get the path to the database
    _databasesPath = join(await getDatabasesPath(), _dbName);
    // If the table does not exist, create it
    _db = await openDatabase(_databasesPath, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE IF NOT EXISTS tasks (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, description TEXT);');
    }, version: 1);
  }

  /// Open the connection to the database
  Future<Database> openDBTask() async {
    if (_db == null) {
      await _initialize();
    }
    return _db!;
  }

  /// Close the connection to the database
  Future<void> closeDBTask() async {
    if (_db != null) await _db!.close();
  }
}

import 'package:sqflite/sqflite.dart';

class Controller {
  var _databasesPath;
  final _dbName = 'tarea04.db';
  late Database _db;

  /// Initialize the connection to the database
  Future<void> init() async {
    // Get the path to the database
    _databasesPath = await getDatabasesPath() + _dbName;

    // If the table does not exist, create it
    _db = await openDatabase(_databasesPath, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT)');
    }, version: 1);
  }

  /// Open the connection to the database
  Future<Database> openDBTask() async {
    return await openDatabase(_dbName);
  }

  /// Close the connection to the database
  Future<void> closeDBTask() async {
    await _db.close();
  }
}

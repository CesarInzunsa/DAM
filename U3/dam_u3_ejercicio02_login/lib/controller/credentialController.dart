import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CredentialController {
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'base1.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE login(id TEXT PRIMARY KEY, user TEXT, password TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<bool> checkCredentials(String user, String password) async {
    Database base = await _openDB();

    // Comprobar si existen el usuario de administrador
    List<Map<String, dynamic>> res1 = await base.query(
      'login',
      where: 'user = ? AND password = ?',
      whereArgs: ['admin', 'admin'],
    );

    // Si no existe, se crea
    if (res1.isEmpty) {
      await base.insert(
        'login',
        {'id': '1', 'user': 'admin', 'password': 'admin'},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    List<Map<String, dynamic>> res2 = await base.query(
      'login',
      where: 'user = ? AND password = ?',
      whereArgs: [user, password],
    );

    return res2.isNotEmpty;
  }
}

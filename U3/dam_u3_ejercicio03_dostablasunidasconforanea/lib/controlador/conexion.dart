import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Conexion {
  static Future<void> script(Database db) async {
    await db.execute('CREATE TABLE artista (artistaID INTEGER PRIMARY KEY, nombre TEXT)');
    await db.execute('CREATE TABLE cancion (cancionID INTEGER PRIMARY KEY AUTOINCREMENT, nombreCancion TEXT, artistaID INTEGER, album TEXT, FOREIGN KEY (artistaID) REFERENCES artista(artistaID))');
  }

  static Future<Database> openDB() {
    return openDatabase(join(getDatabasesPath().toString(), 'ejercicio03.db'),
        onCreate: (db, version) {
      return script(db);
    }, version: 1);
  }
}

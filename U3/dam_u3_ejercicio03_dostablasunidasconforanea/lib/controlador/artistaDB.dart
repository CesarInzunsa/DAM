import 'package:sqflite/sqflite.dart';
import '../modelo/artista.dart';
import '../controlador/conexion.dart';

class ArtistaDB {
  static Future<int> insert(Artista artista) async {
    final Database base = await Conexion.openDB();
    return base.insert(
      'artista',
      artista.toJSON(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<int> delete(int artistaID) async {
    final Database base = await Conexion.openDB();
    return base.delete(
      'artista',
      where: 'artistaID = ?',
      whereArgs: [artistaID],
    );
  }

  static Future<List<Artista>> getAll() async {
    final Database base = await Conexion.openDB();
    List<Map<String, dynamic>> res = await base.query('artista');
    return List.generate(res.length, (i) {
      return Artista(
        artistaID: res[i]['artistaID'],
        nombre: res[i]['nombre'],
      );
    });
  }

  static Future<int> update(Artista artista) async {
    final Database base = await Conexion.openDB();
    return base.update(
      'artista',
      artista.toJSON(),
      where: 'artistaID = ?',
      whereArgs: [artista.artistaID],
    );
  }
}

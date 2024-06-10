import 'package:sqflite/sqflite.dart';
import '../modelo/cancion.dart';
import '../controlador/conexion.dart';
import '../modelo/cancionArtista.dart';

class CancionDB {
  static Future<int> insert(Cancion cancion) async {
    final Database base = await Conexion.openDB();
    return base.insert(
      'cancion',
      cancion.toJSON(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<int> delete(int cancionID) async {
    final Database base = await Conexion.openDB();
    return base.delete(
      'cancion',
      where: 'cancionID = ?',
      whereArgs: [cancionID],
    );
  }

  static Future<List<Cancion>> getAll() async {
    final Database base = await Conexion.openDB();
    List<Map<String, dynamic>> res = await base.query('cancion');
    return List.generate(res.length, (i) {
      return Cancion(
        cancionID: res[i]['cancionID'],
        nombreCancion: res[i]['nombreCancion'],
        artistaID: res[i]['artistaID'],
        album: res[i]['album'],
      );
    });
  }

  static Future<List<CancionArtista>> getAllWithArtistName() async {
    final Database base = await Conexion.openDB();
    // SELECT * FROM artista,cancion WHERE cancion.artistaID = artista.artistaID
    List<Map<String, dynamic>> res = await base.rawQuery(
        'SELECT c.cancionID, c.nombreCancion, c.album, a.nombre FROM cancion c INNER JOIN artista a ON c.artistaID = a.artistaID');
    return List.generate(res.length, (i) {
      return CancionArtista(
        cancionID: res[i]['c.cancionID'],
        nombreCancion: res[i]['c.nombreCancion'],
        nombreArtista: res[i]['a.nombre'],
        album: res[i]['c.album'],
      );
    });
  }

  static Future<int> update(Cancion cancion) async {
    final Database base = await Conexion.openDB();
    return base.update(
      'cancion',
      cancion.toJSON(),
      where: 'cancionID = ?',
      whereArgs: [cancion.cancionID],
    );
  }
}

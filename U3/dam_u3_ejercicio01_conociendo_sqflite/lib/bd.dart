import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'estudiante.dart';

class DB {
  static Future<Database> _abrirDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'base1.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE estudiante(noControl TEXT PRIMARY KEY, nombre TEXT, domicilio TEXT, carrera TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<int> insertar(Estudiante estudiante) async {
    Database base = await _abrirDB();
    return base.insert(
      'estudiante',
      estudiante.toJSON(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<int> eliminar(String noControl) async {
    Database base = await _abrirDB();
    return base.delete(
      'estudiante',
      where: 'noControl = ?',
      whereArgs: [noControl],
    );
  }

  static Future<List<Estudiante>> mostrarTodos() async {
    Database base = await _abrirDB();
    List<Map<String, dynamic>> resultado = await base.query('estudiante');
    return List.generate(resultado.length, (i) {
      return Estudiante(
        noControl: resultado[i]['noControl'],
        nombre: resultado[i]['nombre'],
        domicilio: resultado[i]['domicilio'],
        carrera: resultado[i]['carrera'],
      );
    });
  }

  static Future<int> actualizar(Estudiante estudiante) async {
    Database base = await _abrirDB();
    return base.update(
      'estudiante',
      estudiante.toJSONUpdate(),
      where: 'noControl = ?',
      whereArgs: [estudiante.noControl],
    );
  }

  static Future<Estudiante> mostrarEstudiante(String noControl) async {
    Database base = await _abrirDB();
    List<Map<String, dynamic>> resultado = await base.query(
      'estudiante',
      where: 'noControl = ?',
      whereArgs: [noControl],
    );
    return Estudiante(
      noControl: resultado[0]['noControl'],
      nombre: resultado[0]['nombre'],
      domicilio: resultado[0]['domicilio'],
      carrera: resultado[0]['carrera'],
    );
  }
}

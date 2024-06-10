import 'package:sqflite/sqflite.dart';
import '../controller/conexion.dart';
import '../model/materiaModel.dart';

class MateriaController {
  static Future<List<MateriaModel>> getAll() async {
    final Database base = await Conexion.openDB();
    List<Map<String, dynamic>> res = await base.query('materia');
    return List.generate(res.length, (i) {
      return MateriaModel(
        idMateria: res[i]['idMateria'],
        nombreMateria: res[i]['nombreMateria'],
      );
    });
  }

  static Future<int> insertOne(MateriaModel materia) async {
    final Database base = await Conexion.openDB();
    return base.insert(
      'materia',
      materia.toJSON(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<int> updateOne(MateriaModel materia) async {
    final Database base = await Conexion.openDB();
    return base.update(
      'materia',
      materia.toJSON(),
      where: 'idMateria = ?',
      whereArgs: [materia.idMateria],
    );
  }

  static Future<int> deleteOne(int idMateria) async {
    final Database base = await Conexion.openDB();
    return base.delete(
      'materia',
      where: 'idMateria = ?',
      whereArgs: [idMateria],
    );
  }

  static Future<List<MateriaModel>> getByName(String name) async {
    final Database base = await Conexion.openDB();
    List<Map<String, dynamic>> res = await base.query(
      'materia',
      where: 'LOWER(nombreMateria) LIKE LOWER(?)',
      whereArgs: ['%$name%'],
    );
    return List.generate(res.length, (i) {
      return MateriaModel(
        idMateria: res[i]['idMateria'],
        nombreMateria: res[i]['nombreMateria'],
      );
    });
  }
}

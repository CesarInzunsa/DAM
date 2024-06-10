import 'package:sqflite/sqflite.dart';
import '../controller/conexion.dart';
import '../model/profesorModel.dart';

class ProfesorController {
  static Future<List<ProfesorModel>> getAll() async {
    final Database base = await Conexion.openDB();
    List<Map<String, dynamic>> res = await base.query('profesor');
    return List.generate(res.length, (i) {
      return ProfesorModel(
        idProfesor: res[i]['idProfesor'],
        nombreProfesor: res[i]['nombreProfesor'],
        carreraProfesor: res[i]['carreraProfesor'],
      );
    });
  }

  static Future<int> insertOne(ProfesorModel profesor) async {
    final Database base = await Conexion.openDB();
    return base.insert(
      'profesor',
      profesor.toJSON(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<int> updateOne(ProfesorModel profesor) async {
    final Database base = await Conexion.openDB();
    return base.update(
      'profesor',
      profesor.toJSON(),
      where: 'idProfesor = ?',
      whereArgs: [profesor.idProfesor],
    );
  }

  static Future<int> deleteOne(int idProfesor) async {
    final Database base = await Conexion.openDB();
    return base.delete(
      'profesor',
      where: 'idProfesor = ?',
      whereArgs: [idProfesor],
    );
  }

  static Future<List<ProfesorModel>> getByCarrera(
      String carreraProfesor) async {
    final Database base = await Conexion.openDB();
    List<Map<String, dynamic>> res = await base.query(
      'profesor',
      where: 'LOWER(carreraProfesor) LIKE LOWER(?)',
      whereArgs: ['%$carreraProfesor%'],
    );
    return List.generate(res.length, (i) {
      return ProfesorModel(
        idProfesor: res[i]['idProfesor'],
        nombreProfesor: res[i]['nombreProfesor'],
        carreraProfesor: res[i]['carreraProfesor'],
      );
    });
  }
}

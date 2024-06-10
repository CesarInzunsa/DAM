import 'package:sqflite/sqflite.dart';
import '../controller/conexion.dart';
import '../model/asistenciaModel.dart';
import '../model/horarioModel.dart';
import '../model/materiaModel.dart';
import '../model/profesorModel.dart';

class AsistenciaController {
  static Future<List<AsistenciaModel>> getAll() async {
    final Database base = await Conexion.openDB();
    List<Map<String, dynamic>> res = await base.rawQuery(
        'SELECT * FROM asistencia a INNER JOIN horario h ON a.idHorario = h.idHorario INNER JOIN materia m ON h.idMateria = m.idMateria INNER JOIN profesor p ON h.idProfesor = p.idProfesor');
    return List.generate(res.length, (i) {
      return AsistenciaModel(
        idAsistencia: res[i]['idAsistencia'],
        horarioAsistencia: HorarioModel(
          idHorario: res[i]['idHorario'],
          profesorHorario: ProfesorModel(
            idProfesor: res[i]['idProfesor'],
            nombreProfesor: res[i]['nombreProfesor'],
            carreraProfesor: res[i]['carreraProfesor'],
          ),
          materiaHorario: MateriaModel(
            idMateria: res[i]['idMateria'],
            nombreMateria: res[i]['nombreMateria'],
          ),
          horaHorario: res[i]['horaHorario'],
          edificioHorario: res[i]['edificioHorario'],
          salonHorario: res[i]['salonHorario'],
        ),
        fechaAsistencia: res[i]['fechaAsistencia'],
        asistencia: res[i]['asistencia'],
      );
    });
  }

  static Future<int> insertOne(AsistenciaModel asistencia) async {
    final Database base = await Conexion.openDB();
    return base.insert(
      'asistencia',
      asistencia.toJSON(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<int> updateOne(AsistenciaModel asistencia) async {
    final Database base = await Conexion.openDB();
    return base.update(
      'asistencia',
      asistencia.toJSON(),
      where: 'idAsistencia = ?',
      whereArgs: [asistencia.idAsistencia],
    );
  }

  static Future<int> deleteOne(int idAsistencia) async {
    final Database base = await Conexion.openDB();
    return base.delete(
      'asistencia',
      where: 'idAsistencia = ?',
      whereArgs: [idAsistencia],
    );
  }

  static Future<List<AsistenciaModel>> getAsistenciasByDate(String date, int asistencia) async {
    final Database base = await Conexion.openDB();
    List<Map<String, dynamic>> res = await base.rawQuery(
        'SELECT * FROM asistencia a INNER JOIN horario h ON a.idHorario = h.idHorario INNER JOIN materia m ON h.idMateria = m.idMateria INNER JOIN profesor p ON h.idProfesor = p.idProfesor WHERE a.fechaAsistencia = ? AND a.asistencia = ?',
        [date, asistencia]);
    return List.generate(res.length, (i) {
      return AsistenciaModel(
        idAsistencia: res[i]['idAsistencia'],
        horarioAsistencia: HorarioModel(
          idHorario: res[i]['idHorario'],
          profesorHorario: ProfesorModel(
            idProfesor: res[i]['idProfesor'],
            nombreProfesor: res[i]['nombreProfesor'],
            carreraProfesor: res[i]['carreraProfesor'],
          ),
          materiaHorario: MateriaModel(
            idMateria: res[i]['idMateria'],
            nombreMateria: res[i]['nombreMateria'],
          ),
          horaHorario: res[i]['horaHorario'],
          edificioHorario: res[i]['edificioHorario'],
          salonHorario: res[i]['salonHorario'],
        ),
        fechaAsistencia: res[i]['fechaAsistencia'],
        asistencia: res[i]['asistencia'],
      );
    });
  }
}

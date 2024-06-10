import 'package:sqflite/sqflite.dart';
import '../controller/conexion.dart';
import '../model/horarioModel.dart';
import '../model/materiaModel.dart';
import '../model/profesorModel.dart';

class HorarioController {
  static Future<List<HorarioModel>> getAll() async {
    final Database base = await Conexion.openDB();
    List<Map<String, dynamic>> res = await base.rawQuery(
        'SELECT h.idHorario, p.idProfesor, p.nombreProfesor, p.carreraProfesor, m.idMateria, m.nombreMateria, h.horaHorario, h.edificioHorario, h.salonHorario FROM horario h INNER JOIN materia m ON h.idMateria = m.idMateria INNER JOIN profesor p ON h.idProfesor = p.idProfesor');
    return List.generate(res.length, (i) {
      return HorarioModel(
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
      );
    });
  }

  static Future<int> insertOne(HorarioModel horario) async {
    final Database base = await Conexion.openDB();
    return base.insert(
      'horario',
      horario.toJSON(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<int> updateOne(HorarioModel horario) async {
    final Database base = await Conexion.openDB();
    return base.update(
      'horario',
      horario.toJSON(),
      where: 'idHorario = ?',
      whereArgs: [horario.idHorario],
    );
  }

  static Future<int> deleteOne(int idHorario) async {
    final Database base = await Conexion.openDB();
    return base.delete(
      'horario',
      where: 'idHorario = ?',
      whereArgs: [idHorario],
    );
  }

  static Future<List<HorarioModel>> getHorariosByHoraEdificio(
      String HoraHorario, String edificioHorario) async {
    final Database base = await Conexion.openDB();
    List<Map<String, dynamic>> res = await base.rawQuery(
        'SELECT h.idHorario, p.idProfesor, p.nombreProfesor, p.carreraProfesor, m.idMateria, m.nombreMateria, h.horaHorario, h.edificioHorario, h.salonHorario FROM horario h INNER JOIN materia m ON h.idMateria = m.idMateria INNER JOIN profesor p ON h.idProfesor = p.idProfesor WHERE h.horaHorario = ? AND h.edificioHorario = ?',
        [HoraHorario, edificioHorario]);
    return List.generate(res.length, (i) {
      return HorarioModel(
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
      );
    });
  }
}

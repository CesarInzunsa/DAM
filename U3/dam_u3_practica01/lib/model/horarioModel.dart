import '../model/materiaModel.dart';
import '../model/profesorModel.dart';

class HorarioModel {
  int idHorario;
  ProfesorModel profesorHorario;
  MateriaModel materiaHorario;
  String horaHorario;
  String edificioHorario;
  String salonHorario;

  HorarioModel({
    required this.idHorario,
    required this.profesorHorario,
    required this.materiaHorario,
    required this.horaHorario,
    required this.edificioHorario,
    required this.salonHorario,
  });

  Map<String, dynamic> toJSON() {
    return {
      "idProfesor": this.profesorHorario.idProfesor,
      "idMateria": this.materiaHorario.idMateria,
      "horaHorario": this.horaHorario,
      "edificioHorario": this.edificioHorario,
      "salonHorario": this.salonHorario,
    };
  }
}

import 'horarioModel.dart';

class AsistenciaModel {
  int idAsistencia;
  HorarioModel horarioAsistencia;
  String fechaAsistencia;
  int asistencia;

  AsistenciaModel({
    required this.idAsistencia,
    required this.horarioAsistencia,
    required this.fechaAsistencia,
    required this.asistencia,
  });

  Map<String, dynamic> toJSON() {
    return {
      'idHorario': horarioAsistencia.idHorario,
      'fechaAsistencia': fechaAsistencia,
      'asistencia': asistencia,
    };
  }
}

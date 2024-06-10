class ProfesorModel {
  int idProfesor;
  String nombreProfesor;
  String carreraProfesor;

  ProfesorModel({
    required this.idProfesor,
    required this.nombreProfesor,
    required this.carreraProfesor,
  });

  Map<String, dynamic> toJSON() {
    return {
      'nombreProfesor': nombreProfesor,
      'carreraProfesor': carreraProfesor,
    };
  }
}

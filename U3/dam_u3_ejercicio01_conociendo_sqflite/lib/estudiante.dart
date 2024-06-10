class Estudiante {
  String noControl;
  String nombre;
  String domicilio;
  String carrera;

  Estudiante({
    required this.noControl,
    required this.nombre,
    required this.domicilio,
    required this.carrera,
  });

   Map<String, dynamic> toJSON() {
    return {
      'noControl': noControl,
      'nombre': nombre,
      'domicilio': domicilio,
      'carrera': carrera,
    };
  }

  Map<String, dynamic> toJSONUpdate() {
    return {
      'nombre': nombre,
      'domicilio': domicilio,
      'carrera': carrera,
    };
  }
}

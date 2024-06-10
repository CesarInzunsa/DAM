class Alumno {
  String id;
  String nc;
  String nombre;
  String domicilio;
  int edad;

  Alumno({
    this.id = '',
    required this.nc,
    required this.nombre,
    required this.domicilio,
    required this.edad,
  });

  Map<String, dynamic> toJSON() {
    return {
      'nc': nc,
      'nombre': nombre,
      'domicilio': domicilio,
      'edad': edad,
    };
  }
}

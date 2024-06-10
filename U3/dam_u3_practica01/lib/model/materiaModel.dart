class MateriaModel {
  int idMateria;
  String nombreMateria;

  MateriaModel({
    required this.idMateria,
    required this.nombreMateria,
  });

  Map<String, dynamic> toJSON() {
    return {
      'nombreMateria': nombreMateria,
    };
  }
}

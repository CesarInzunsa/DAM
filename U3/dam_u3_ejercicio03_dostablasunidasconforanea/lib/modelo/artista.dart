class Artista {
  int artistaID;
  String nombre;

  Artista({
    required this.artistaID,
    required this.nombre,
  });

  Map<String, dynamic> toJSON() {
    return {
      'artistaID': artistaID,
      'nombre': nombre,
    };
  }
}

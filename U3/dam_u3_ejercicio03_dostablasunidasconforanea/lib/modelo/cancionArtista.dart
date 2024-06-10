class CancionArtista {
  int cancionID;
  String nombreCancion;
  String nombreArtista;
  String album;

  CancionArtista({
    required this.cancionID,
    required this.nombreCancion,
    required this.nombreArtista,
    required this.album,
  });

  Map<String, dynamic> toJSON() {
    return {
      'cancionID': cancionID,
      'nombreCancion': nombreCancion,
      'nombreArtista': nombreArtista,
      'album': album,
    };
  }
}

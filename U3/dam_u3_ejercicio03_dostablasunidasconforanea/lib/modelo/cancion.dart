class Cancion {
  int cancionID;
  String nombreCancion;
  int artistaID;
  String album;

  Cancion({
    required this.cancionID,
    required this.nombreCancion,
    required this.artistaID,
    required this.album,
  });

  Map<String, dynamic> toJSON() {
    return {
      'nombreCancion': nombreCancion,
      'artistaID': artistaID,
      'album': album,
    };
  }
}

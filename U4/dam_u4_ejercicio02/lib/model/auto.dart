class Auto {
  String id;
  String marca;
  String modelo;
  String chofer;
  DateTime fechaCompra;
  String placa;
  int kilometraje;

  Auto({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.chofer,
    required this.fechaCompra,
    required this.placa,
    required this.kilometraje,
  });

  Map<String, dynamic> toJSON() {
    return {
      'marca': marca,
      'modelo': modelo,
      'chofer': chofer,
      'fechaCompra': fechaCompra,
      'placa': placa,
      'kilometraje': kilometraje,
    };
  }
}

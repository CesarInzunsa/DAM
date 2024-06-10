import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/auto.dart';

class AutoController {
  static FirebaseFirestore baseRemota = FirebaseFirestore.instance;

  /// Metodo para insertar un auto en la base de datos
  static Future<DocumentReference> insertar(Auto auto) async {
    return await baseRemota.collection('auto').add(auto.toJSON());
  }

  /// Metodo para mostrar todos los autos de la base de datos
  static Future<List<Auto>> mostrarTodos() async {
    List<Auto> autos = [];

    var res = await baseRemota.collection('auto').get();

    for (var doc in res.docs) {
      Map<String, dynamic> data = doc.data();
      DateTime utcTime = DateTime.fromMillisecondsSinceEpoch(data['fechaCompra'].seconds * 1000);
      // Adjust to UTC-7
      DateTime localTime = utcTime.add(const Duration(hours: -7)).toLocal();
      autos.add(
        Auto(
          id: doc.id,
          marca: data['marca'],
          modelo: data['modelo'],
          chofer: data['chofer'],
          fechaCompra: localTime,
          placa: data['placa'],
          kilometraje: data['kilometraje'],
        ),
      );
    }

    return autos;
  }

  /// Metodo para eliminar un auto en la base de datos
  static Future<void> eliminar(String id) async {
    await baseRemota.collection('auto').doc(id).delete();
  }

  /// Metodo para actualizar un alumno en la base de datos
  static Future<void> actualizar(Auto auto) async {
    await baseRemota
        .collection('auto')
        .doc(auto.id)
        .update(auto.toJSON());
  }
}

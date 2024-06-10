import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/alumno.dart';

class AlumnoDB {
  static FirebaseFirestore baseRemota = FirebaseFirestore.instance;

  /// Metodo para insertar un alumno en la base de datos
  static Future<DocumentReference> insertar(Alumno alumno) async {
    return await baseRemota.collection('alumno').add(alumno.toJSON());
  }

  /// Metodo para actualizar un alumno en la base de datos
  static Future<List<Alumno>> mostrarTodos() async {
    List<Alumno> alumnos = [];

    var consulta = await baseRemota.collection('alumno').get();

    for (var doc in consulta.docs) {
      Map<String, dynamic> data = doc.data();
      alumnos.add(
        Alumno(
          id: doc.id,
          nc: data['nc'],
          nombre: data['nombre'],
          domicilio: data['domicilio'],
          edad: data['edad'],
        ),
      );
    }

    return alumnos;
  }

  /// Metodo para actualizar un alumno en la base de datos
  static Future<void> eliminar(String id) async {
    await baseRemota.collection('alumno').doc(id).delete();
  }

  /// Metodo para actualizar un alumno en la base de datos
  static Future<void> actualizar(Alumno alumno) async {
    await baseRemota
        .collection('alumno')
        .doc(alumno.id)
        .update(alumno.toJSON());
  }
}

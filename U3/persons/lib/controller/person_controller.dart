import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/person_model.dart';

class PersonController {
  static Future<void> insertOne(Person person) async {
    // Crear un documento con un ID aleatorio
    final docPerson = FirebaseFirestore.instance.collection('persons').doc();

    // Establecer los datos del documento
    await docPerson.set(person.toJSON());
  }

  static Future<List<Person>> getAll() async {
    final persons = <Person>[];

    await FirebaseFirestore.instance.collection("persons").get().then((event) {
      for (var doc in event.docs) {
        persons.add(Person.fromJSON(doc.data()));
      }
    });

    return persons;
  }
}

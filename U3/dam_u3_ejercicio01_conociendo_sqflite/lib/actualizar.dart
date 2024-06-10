import 'package:flutter/material.dart';

import 'bd.dart';
import 'estudiante.dart';

class Actualizar extends StatefulWidget {
  final String noControl;

  const Actualizar({super.key, required this.noControl});

  @override
  State<Actualizar> createState() => _ActualizarState();
}

class _ActualizarState extends State<Actualizar> {
  void initState() {
    super.initState();
    precargarInformacion();
  }

  void precargarInformacion() async {
    Estudiante estudiante = await DB.mostrarEstudiante(widget.noControl);
    nombreController.text = estudiante.nombre;
    domicilioController.text = estudiante.domicilio;
    carreraController.text = estudiante.carrera;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDITAR'),
        backgroundColor: Colors.orange,
      ),
      body: _body(),
    );
  }

  final nombreController = TextEditingController();
  final domicilioController = TextEditingController();
  final carreraController = TextEditingController();

  Widget _body() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        TextField(
          controller: nombreController,
          decoration: const InputDecoration(
              labelText: 'Nombre', icon: Icon(Icons.numbers)),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: domicilioController,
          decoration: const InputDecoration(
              labelText: 'Domicilio', icon: Icon(Icons.phone)),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: carreraController,
          decoration: const InputDecoration(
              labelText: 'Carrera', icon: Icon(Icons.description)),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Estudiante estudiante = Estudiante(
                  noControl: widget.noControl,
                  nombre: nombreController.text,
                  domicilio: domicilioController.text,
                  carrera: carreraController.text,
                );
                DB.actualizar(estudiante).then((value) {
                  Navigator.pop(context, true);
                });
              },
              child: const Text('ACTUALIZAR'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('REGRESAR'),
            ),
          ],
        )
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'actualizar.dart';
import 'bd.dart';
import 'estudiante.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: App301()));
}

class App301 extends StatefulWidget {
  const App301({super.key});

  @override
  State<App301> createState() => _App301State();
}

class _App301State extends State<App301> {
  List<Estudiante> listaAlumnos = [];

  @override
  void initState() {
    super.initState();
    cargarListaAlumnos();
  }

  void cargarListaAlumnos() async {
    List<Estudiante> temporal = await DB.mostrarTodos();
    setState(() {
      listaAlumnos = temporal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('App 301'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'CAPTURAR'),
              Tab(icon: Icon(CupertinoIcons.person_2)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            capturar(),
            mostrar(),
          ],
        ),
      ),
    );
  }

  final noControlController = TextEditingController();
  final nombreController = TextEditingController();
  final domicilioController = TextEditingController();
  final carreraController = TextEditingController();

  Widget capturar() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        TextField(
          controller: noControlController,
          decoration: const InputDecoration(
              labelText: 'No. Control', icon: Icon(Icons.person)),
        ),
        const SizedBox(height: 10),
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
                  noControl: noControlController.text,
                  nombre: nombreController.text,
                  domicilio: domicilioController.text,
                  carrera: carreraController.text,
                );
                DB.insertar(estudiante).then((value) {
                  if (value < 1) {
                    mensaje('ERROR NO SE INSERTO');
                  } else {
                    mensaje('EXITO SE INSERTO');
                    limpiarCampos();
                    cargarListaAlumnos();
                  }
                });
              },
              child: const Text('INSERTAR'),
            ),
            ElevatedButton(
              onPressed: () {
                limpiarCampos();
              },
              child: const Text('LIMPIAR'),
            ),
          ],
        )
      ],
    );
  }

  Widget mostrar() {
    return ListView.builder(
        itemCount: listaAlumnos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listaAlumnos[index].nombre),
            subtitle: Text(listaAlumnos[index].domicilio),
            trailing: IconButton(
              onPressed: () {
                vistaBorrar(listaAlumnos[index].noControl);
              },
              icon: const Icon(Icons.delete),
            ),
            onTap: () {
              vistaEdicion(listaAlumnos[index].noControl);
            },
          );
        });
  }

  void mensaje(String s) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  }

  void vistaEdicion(String noControl) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('ATENCION'),
            content:
                const Text('ESTAS SEGURO QUE DESEAS ACTUALIZAR EL REGISTRO?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Actualizar(noControl: noControl);
                  })).then((value) {
                    if (value) {
                      mensaje('ACTUALIZADO CON EXITO');
                      cargarListaAlumnos();
                    }
                  });
                },
                child: const Text('SI'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('CANCELAR'),
              ),
            ],
          );
        });
  }

  void vistaBorrar(String noControl) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('ATENCION'),
            content:
                const Text('ESTAS SEGURO QUE DESEAS ELIMINAR EL REGISTRO?'),
            actions: [
              TextButton(
                onPressed: () {
                  DB.eliminar(noControl).then((value) {
                    mensaje('ELIMINADO CON EXITO');
                    cargarListaAlumnos();
                    Navigator.pop(context);
                  });
                },
                child: const Text('ELIMINAR'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('CANCELAR'),
              ),
            ],
          );
        });
  }

  void limpiarCampos() {
    noControlController.clear();
    nombreController.clear();
    domicilioController.clear();
    carreraController.clear();
  }
}

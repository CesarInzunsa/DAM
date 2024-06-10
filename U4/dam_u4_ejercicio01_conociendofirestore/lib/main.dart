import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controller/alumno_db.dart';
import 'model/alumno.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FIREBASE CRUD 01'),
          backgroundColor: CupertinoColors.extraLightBackgroundGray,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'CAPTURAR'),
              Tab(text: 'LISTAR'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            capturar(),
            listar(),
          ],
        ),
      ),
    );
  }

  final ncController = TextEditingController();
  final nombreController = TextEditingController();
  final domicilioController = TextEditingController();
  final edadController = TextEditingController();

  Widget capturar() {
    return ListView(
      padding: const EdgeInsets.all(30),
      children: [
        dibujarTextField('No. Control', ncController),
        dibujarTextField('Nombre', nombreController),
        dibujarTextField('Domicilio', domicilioController),
        dibujarTextField('Edad', edadController),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                onPressed: () {
                  Alumno alumno = Alumno(
                    nc: ncController.text,
                    nombre: nombreController.text,
                    domicilio: domicilioController.text,
                    edad: int.parse(edadController.text),
                  );

                  AlumnoDB.insertar(alumno).then((value) {
                    showMessage('SE INSERTO CORRECTAMENTE');
                    clearFields();
                    setState(() {});
                  });
                },
                child: const Text('Insertar'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                onPressed: () {
                  clearFields();
                },
                child: const Text('Limpiar'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget listar() {
    return FutureBuilder(
      future: AlumnoDB.mostrarTodos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(
                  '${index + 1}',
                  style: const TextStyle(fontSize: 20),
                ),
                title: Text(
                    '${snapshot.data![index].nombre} - ${snapshot.data![index].nc}'),
                subtitle: Text(
                    '${snapshot.data![index].domicilio} - ${snapshot.data![index].edad} años'),
                onTap: () => updateDialog(snapshot.data![index]),
                trailing: IconButton(
                  onPressed: () {
                    AlumnoDB.eliminar(snapshot.data![index].id).then((value) {
                      showMessage('SE ELIMINO CORRECTAMENTE');
                      setState(() {});
                    });
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          );
        }
      },
    );
  }

  void updateDialog(Alumno alumnoWithOldData) {
    ncController.text = alumnoWithOldData.nc;
    nombreController.text = alumnoWithOldData.nombre;
    domicilioController.text = alumnoWithOldData.domicilio;
    edadController.text = alumnoWithOldData.edad.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Actualizar Alumno'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                dibujarTextField('No. Control', ncController),
                dibujarTextField('Nombre', nombreController),
                dibujarTextField('Domicilio', domicilioController),
                dibujarTextField('Edad', edadController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Alumno alumnoWithNewData = Alumno(
                  id: alumnoWithOldData.id,
                  nc: ncController.text,
                  nombre: nombreController.text,
                  domicilio: domicilioController.text,
                  edad: int.parse(edadController.text),
                );

                AlumnoDB.actualizar(alumnoWithNewData).then((value) {
                  showMessage('SE ACTUALIZO CORRECTAMENTE');
                  Navigator.pop(context);
                  clearFields();
                  setState(() {});
                });
              },
              child: const Text('Actualizar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                clearFields();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  Widget dibujarTextField(String label, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void clearFields() {
    ncController.clear();
    nombreController.clear();
    domicilioController.clear();
    edadController.clear();
  }
}

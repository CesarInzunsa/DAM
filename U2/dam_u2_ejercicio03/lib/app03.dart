import 'package:dam_u2_ejercicio03/persona.dart';
import 'package:flutter/material.dart';

List<Persona> data = [
  Persona(
      nombre: 'Juan Gonzalez',
      domicilio: 'Cuarzo rosa',
      telefono: '31112565655'),
  Persona(
      nombre: 'Ana Gonzalez',
      domicilio: 'Cuarzo azul',
      telefono: '31112565655'),
  Persona(
      nombre: 'Pedro Perez',
      domicilio: 'Cuarzo verde',
      telefono: '31112565655'),
  Persona(
      nombre: 'Maria Lopez',
      domicilio: 'Cuarzo amarillo',
      telefono: '31112565655'),
];

class App03 extends StatefulWidget {
  const App03({super.key});

  @override
  State<App03> createState() => _App03State();
}

class _App03State extends State<App03> {
  int _indice = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio 03'),
      ),
      body: dinamico(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {}, label: const Icon(Icons.add)),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                      radius: 30,
                      child: const Text('I. D.'),
                      backgroundColor: Colors.amber),
                  Text(
                    'Cesar Inzunsa',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text('(C) Tec tepic',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            itemDrawer(1, Icons.home, 'CAPTURAR'),
            itemDrawer(2, Icons.update, 'MOSTRAR'),
            itemDrawer(3, Icons.delete, 'ACERCA DE...'),
          ],
        ),
      ),
    );
  }

  itemDrawer(int indice, IconData icono, String etiqueta) {
    return ListTile(
      title: Row(children: [
        Expanded(
          child: Icon(icono),
        ),
        Expanded(
          flex: 2,
          child: Text(etiqueta),
        )
      ]),
      onTap: () {
        setState(() {
          _indice = indice;
        });
        Navigator.pop(context);
      },
    );
  }

  Widget dinamico() {
    switch (_indice) {
      case 2:
        return mostrarLista();
      case 3:
        return const Center(
          child: Text('Creado por Cesar Inzunsa'),
        );
      default:
        return capturar();
    }
  }

  Widget mostrarLista() {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, indice) {
          return ListTile(
            leading: CircleAvatar(child: Text("${indice + 1}")),
            title: Text(data[indice].nombre),
            subtitle: Text(data[indice].domicilio),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (builder) {
                    return AlertDialog(
                      title: const Text('ATENCION'),
                      content: Text(
                          'Seguro que quieres borrar a ${data[indice].nombre}'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                data.removeAt(indice);
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('ELIMINAR')),
                        TextButton(
                            onPressed: () {
                              nom.text = data[indice].nombre;
                              dom.text = data[indice].domicilio;
                              tel.text = data[indice].telefono;
                              Navigator.pop(context);
                              ventanaModal();
                            },
                            child: const Text('Actualizar')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Salir')),
                      ],
                    );
                  });
            },
          );
        });
  }

  void ventanaModal() {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (builder) {
          return Container(
            padding: EdgeInsets.only(
                top: 20,
                left: 40,
                right: 40,
                bottom: MediaQuery.of(context).viewInsets.bottom + 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nom,
                  decoration: const InputDecoration(labelText: 'Nombre:'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: dom,
                  decoration: const InputDecoration(labelText: 'Domicilio:'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: tel,
                  decoration: const InputDecoration(labelText: 'Telefono:'),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            data[_indice].nombre = nom.text;
                            data[_indice].domicilio = dom.text;
                            data[_indice].telefono = tel.text;
                          });
                          nom.clear();
                          dom.clear();
                          tel.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('ACTUALIZAR')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('CANCELAR'))
                  ],
                )
              ],
            ),
          );
        });
  }

  final TextEditingController nom = TextEditingController();
  final TextEditingController dom = TextEditingController();
  final TextEditingController tel = TextEditingController();

  Widget capturar() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        TextField(
          controller: nom,
          decoration: const InputDecoration(labelText: 'Nombre completo:'),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: dom,
          decoration: const InputDecoration(labelText: 'Domicilio:'),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: tel,
          decoration: const InputDecoration(labelText: 'Telefono:'),
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (nom.text.isEmpty ||
                      dom.text.isEmpty ||
                      tel.text.isEmpty) {
                    nom.clear();
                    dom.clear();
                    tel.clear();
                    return;
                  }
                  var p = Persona(
                      nombre: nom.text,
                      domicilio: dom.text,
                      telefono: tel.text);
                  data.add(p);

                  nom.clear();
                  dom.clear();
                  tel.clear();
                },
                child: Text('CAPTURAR')),
            ElevatedButton(onPressed: () {}, child: Text('LIMPIAR'))
          ],
        )
      ],
    );
  }
}

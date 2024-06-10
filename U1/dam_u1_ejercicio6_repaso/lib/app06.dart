import 'package:flutter/material.dart';

class App06 extends StatefulWidget {
  const App06({super.key});

  @override
  State<App06> createState() => _App06State();
}

enum Titulacion { CENEVAL, TESIS, RESIDENCIA }

List Carreras = [
  "Sistemas Computacionales",
  "Bioquimica",
  "Quimica",
  "Civil",
  "Arquitectura",
  "Gestion Empresarial",
  "Mecatronica"
];

class _App06State extends State<App06> {
  bool algo = true;
  var nombre = TextEditingController();
  bool algo2 = false;
  Titulacion groupValue = Titulacion.CENEVAL;
  String itemSeleccionado = Carreras.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App06'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [Switch(value: algo, onChanged: (data) {})],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_box_outlined),
          TextField(
            controller: nombre,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.cabin),
              labelText: 'Escriba su nombre',
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: Text("OK")),
              SizedBox(width: 10),
              FilledButton(onPressed: () {}, child: Text("OK")),
              SizedBox(width: 10),
              TextButton(onPressed: () {}, child: Text("OK")),
            ],
          ),
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Hola como estas?"),
                  action: SnackBarAction(label: "SALIR", onPressed: () {}),
                ));
              },
              icon: Icon(Icons.delete)),
          SizedBox(height: 20),
          CheckboxListTile(
              title: Text("Aceptar"),
              value: algo2,
              onChanged: (datoCambiado) {
                setState(() {
                  algo2 = datoCambiado!;
                });
              }),
          RadioListTile(
              title: Text("CENEVAL"),
              value: Titulacion.CENEVAL,
              groupValue: groupValue,
              onChanged: (data) {
                setState(() {
                  groupValue = data!;
                });
              }),
          RadioListTile(
              title: Text("TESIS"),
              value: Titulacion.TESIS,
              groupValue: groupValue,
              onChanged: (data) {
                setState(() {
                  groupValue = data!;
                });
              }),
          RadioListTile(
            title: Text("RESIDENCIA"),
            value: Titulacion.RESIDENCIA,
            groupValue: groupValue,
            onChanged: (data) {
              setState(() {
                groupValue = data!;
              });
            },
          ),
          SizedBox(height: 20),
          DropdownButtonFormField(
              items: Carreras.map((e) {
                return DropdownMenuItem(
                  child: Text(e),
                  value: e,
                );
              }).toList(),
              onChanged: (item) {
                setState(() {
                  itemSeleccionado = item.toString();
                });
              })
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                AlertDialog(
                    title: Text("Atencion"),
                    content: Text("Mensaje del dialog"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK")),
                      TextButton(onPressed: () {}, child: Text("CANCELAR")),
                    ]);
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

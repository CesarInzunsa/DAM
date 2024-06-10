import 'dart:io';

import 'package:flutter/material.dart';

class App01 extends StatefulWidget {
  const App01({super.key});

  @override
  State<App01> createState() => _App01State();
}

class _App01State extends State<App01> {
  String nombre = "";
  final controlador = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mi primera APP",
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Presiona para SALIR",
                    style: TextStyle(fontSize: 25),
                  ),
                  backgroundColor: Colors.lightGreen,
                  action: SnackBarAction(
                      label: "SALIR",
                      onPressed: () {
                        exit(0);
                      }),
                ));
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bienvenido",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.red,
                      backgroundColor: Colors.brown),
                ),
                SizedBox(
                  height: 80,
                ),
                TextField(
                  controller: controlador,
                  decoration: InputDecoration(
                    labelText: "Escriba su nombre",
                    suffixIcon: Icon(Icons.account_box_outlined),
                    suffixIconColor: Colors.red,
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        nombre = controlador.text;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                          "Hola ${nombre}",
                          style: TextStyle(fontSize: 20),
                        )),
                      );
                    },
                    child: Text("Da click")),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.help),
      ),
    );
  }
}

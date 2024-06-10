import 'package:flutter/material.dart';

class App02 extends StatefulWidget {
  const App02({super.key});

  @override
  State<App02> createState() => _App02State();
}

class _App02State extends State<App02> {
  final controlador1 = TextEditingController();
  final controlador2 = TextEditingController();
  final controlador3 = TextEditingController();
  String mensaje = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Aplicacion02",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("(C) Reservados INZUNSA LLC")));
            },
            icon: const Icon(Icons.info_outline),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: <Widget>[
          TextField(
            controller: controlador1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Valor1:",
              labelStyle: TextStyle(fontSize: 20),
              prefixIcon: Icon(Icons.numbers),
              prefixIconColor: Colors.lightGreen,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: controlador2,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Valor2:",
              labelStyle: TextStyle(fontSize: 20),
              prefixIcon: Icon(Icons.numbers),
              prefixIconColor: Colors.lightGreen,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: controlador3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Valor3:",
              labelStyle: TextStyle(fontSize: 20),
              prefixIcon: Icon(Icons.numbers),
              prefixIconColor: Colors.lightGreen,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int v1 = int.parse(controlador1.text);
          int v2 = int.parse(controlador2.text);
          int v3 = int.parse(controlador3.text);

          int mayor = v1;

          if (v2 > mayor) {
            mayor = v2;
          } else if (v3 > mayor) {
            mayor = v3;
          }

          setState(() {
            mensaje = "El mayor es: $mayor";
          });

          showDialog(
              context: context,
              // nombreQueSea es el equivalente al this de joptionPane para
              // indicar que se mostrara en esa pantalla
              builder: (nombreQueSea) {
                return AlertDialog(
                  title: Text("ATENCIÓN"),
                  content: Text("MENSAJE: ${mensaje}"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    )
                  ],
                );
              });
        },
        child: Icon(Icons.lan_outlined),
      ),
    );
  }
}

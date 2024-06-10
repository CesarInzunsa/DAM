import 'package:flutter/material.dart';

class App05 extends StatefulWidget {
  const App05({super.key});

  @override
  State<App05> createState() => _App05State();
}

enum enumValores { viaje, regalo, dinero }

var titulo = 'Titulo de la App05';
List Colores = [
  "Blanco",
  "Azul",
  "Amarillo",
  "Rojo",
  "Naranja",
  "Cafe",
  "Negro",
  "Verde"
];

class _App05State extends State<App05> {
  enumValores radioButtonControllerRes = enumValores.viaje;
  bool checkBoxControllerRes = true;
  String itemSeleccionado = Colores.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(50),
          children: [
            Text("Elija su premio:", style: TextStyle(fontSize: 25)),
            RadioListTile(
                title: Text('Viaje'),
                value: enumValores.viaje,
                groupValue: radioButtonControllerRes,
                onChanged: (data) {
                  setState(() {
                    radioButtonControllerRes = data!;
                  });
                }),
            RadioListTile(
                title: Text('Regalo'),
                value: enumValores.regalo,
                groupValue: radioButtonControllerRes,
                onChanged: (data) {
                  setState(() {
                    radioButtonControllerRes = data!;
                  });
                }),
            RadioListTile(
                title: Text('Dinero'),
                value: enumValores.dinero,
                groupValue: radioButtonControllerRes,
                onChanged: (data) {
                  setState(() {
                    radioButtonControllerRes = data!;
                  });
                }),
            CheckboxListTile(
                title: Text('mostrar TITULO'),
                value: checkBoxControllerRes,
                onChanged: (data) {
                  setState(() {
                    if (checkBoxControllerRes) {
                      titulo = '';
                    } else {
                      titulo = 'Titulo de la App05';
                    }
                    checkBoxControllerRes = data!;
                  });
                }),
            DropdownButtonFormField(
                items: Colores.map((e) {
                  return DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  );
                }).toList(),
                onChanged: (item) {
                  setState(() {
                    itemSeleccionado = item.toString();
                  });
                }),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (nose) {
                        return AlertDialog(
                            title: Text('Atencion'),
                            content: Text(
                              'Resultado\nLo que eligio es ${radioButtonControllerRes.name}\ny el fondo es color ${itemSeleccionado}',
                              style: TextStyle(fontSize: 20),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Ok'))
                            ]);
                      });
                },
                child: Text('Mostrar'))
          ],
        ),
      ),
      backgroundColor: colores(),
    );
  }

  colores() {
    switch (itemSeleccionado) {
      case "Blanco":
        return Colors.white;
      case "Azul":
        return Colors.blue;
      case "Amarillo":
        return Colors.yellow;
      case "Rojo":
        return Colors.red;
      case "Naranja":
        return Colors.orange;
      case "Cafe":
        return Colors.brown;
      case "Negro":
        return Colors.black;
      case "Verde":
        return Colors.green;
      default:
        return Colors.white;
    }
  }
}

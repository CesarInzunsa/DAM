import 'package:flutter/material.dart';

class App07 extends StatefulWidget {
  const App07({super.key});

  @override
  State<App07> createState() => _App07State();
}

//
List itemsLista = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

enum radioValue { mayorque, menorque, iguales }

class _App07State extends State<App07> {
  var switchScreen = 1;
  var numSeleccionado = 0;
  var resultado = "RESULTADO";
  radioValue radioControlador = radioValue.mayorque;

  // Controladores
  var valor1 = TextEditingController();
  var valor2 = TextEditingController();

  // Texto para mostrar indicando el estado de los valores
  var estadoValores = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App07 Dinamico1"),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
              icon: const Icon(Icons.calculate_outlined),
              onPressed: () {
                setState(() {
                  switchScreen = 1;
                });
              }),
          IconButton(
              icon: const Icon(Icons.add_a_photo_sharp),
              onPressed: () {
                setState(() {
                  switchScreen = 2;
                });
              }),
          IconButton(
              icon: const Icon(Icons.image_search_outlined),
              onPressed: () {
                setState(() {
                  switchScreen = 3;
                });
              })
        ],
      ),
      body: dinamico1(),
    );
  }

  Widget dinamico1() {
    switch (switchScreen) {
      case 2:
        return ListView(
          padding: const EdgeInsets.all(30),
          children: [
            TextField(
                controller: valor1,
                decoration: const InputDecoration(
                    labelText: "Valor 1",
                    suffixIcon: Icon(Icons.numbers_outlined))),
            TextField(
                controller: valor2,
                decoration: const InputDecoration(
                    labelText: "Valor 2",
                    suffixIcon: Icon(Icons.numbers_outlined))),
            RadioListTile(
                title: const Text("MAYOR QUE"),
                value: radioValue.mayorque,
                groupValue: radioControlador,
                onChanged: (item) {
                  setState(() {
                    radioControlador = item!;
                  });
                }),
            RadioListTile(
                title: const Text("MENOR QUE"),
                value: radioValue.menorque,
                groupValue: radioControlador,
                onChanged: (item) {
                  setState(() {
                    radioControlador = item!;
                  });
                }),
            RadioListTile(
                title: const Text("IGUALES"),
                value: radioValue.iguales,
                groupValue: radioControlador,
                onChanged: (item) {
                  setState(() {
                    radioControlador = item!;
                  });
                }),
            FilledButton(
              onPressed: () {
                setState(() {
                  switch (radioControlador) {
                    case radioValue.mayorque:
                      setState(() {
                        var val1 = int.parse(valor1.text);
                        var val2 = int.parse(valor2.text);
                        if (val1 > val2) {
                          estadoValores = "$val1 SI ES MAYOR QUE $val2";
                        } else {
                          estadoValores = "$val1 NO ES MAYOR QUE $val2";
                        }
                      });
                      break;
                    case radioValue.menorque:
                      setState(() {
                        var val1 = int.parse(valor1.text);
                        var val2 = int.parse(valor2.text);
                        if (val1 < val2) {
                          estadoValores = "$val1 SI ES MENOR QUE $val2";
                        } else {
                          estadoValores = "$val1 NO ES MENOR QUE $val2";
                        }
                      });
                      break;
                    case radioValue.iguales:
                      setState(() {
                        var val1 = int.parse(valor1.text);
                        var val2 = int.parse(valor2.text);
                        if (val1 == val2) {
                          estadoValores = "$val1 SI ES IGUAL A $val2";
                        } else {
                          estadoValores = "$val1 NO ES IGUAL A $val2";
                        }
                      });
                      break;
                  }
                });
              },
              style: FilledButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("COMPARAR"),
            ),
            Text(estadoValores, style: const TextStyle(fontSize: 20))
          ],
        );
      case 3:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png'),
              const SizedBox(height: 20),
              const Text("(C) Reservados Cesar Inzunsa",
                  style: TextStyle(color: Colors.purple))
            ],
          ),
        );
      case 1:
      default:
        return ListView(
          padding: const EdgeInsets.all(40),
          children: <Widget>[
            const Text("TABLA DE MULTIPLICAR",
                style: TextStyle(fontSize: 20, color: Colors.tealAccent)),
            const SizedBox(height: 30),
            const Text("Elija el numero",
                style: TextStyle(color: Colors.orange)),
            DropdownButtonFormField(
              items: itemsLista.map((e) {
                return DropdownMenuItem(value: e, child: Text(e.toString()));
              }).toList(),
              onChanged: (item) {
                setState(() {
                  numSeleccionado = int.parse(item.toString());
                });
              },
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                setState(() {
                  calcularTablaMultiplicar();
                });
              },
              style: FilledButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("OK"),
            ),
            const SizedBox(height: 20),
            Text(resultado, style: const TextStyle(color: Colors.green))
          ],
        );
    }
  }

  calcularTablaMultiplicar() {
    resultado = "RESULTADO:";
    if (numSeleccionado != 0) {
      for (var i = 1; i <= 10; i++) {
        resultado += "\n$numSeleccionado x $i = ${numSeleccionado * i}";
      }
    }
  }
}

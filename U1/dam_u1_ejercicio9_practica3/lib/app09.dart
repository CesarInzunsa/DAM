import 'package:flutter/material.dart';

class App09 extends StatefulWidget {
  const App09({super.key});

  @override
  State<App09> createState() => _App09State();
}

String appTitle = 'App09 Práctica 3';
int screen = 0;
TextEditingController palindromoController = TextEditingController();
TextEditingController adivinaController = TextEditingController();
String palabraAAdivinar = '*********';
List<String> palabras = ['computadora', 'programacion', 'dart', 'flutter'];
String mensajeAdivina = '';

List<String> arregloImagenes = [
  'assets/imagen1.jpg',
  'assets/imagen2.jpg',
  'assets/imagen3.jpg'
];

int imagenActual = 0;

class _App09State extends State<App09> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(appTitle, style: const TextStyle(color: Colors.white)),
        ),
        body: drawBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              screen = 0;
            });
          },
          child: const Icon(Icons.add),
        ));
  }

  Widget drawBody() {
    switch (screen) {
      case 0:
        return mainMenu();
      case 1:
        return palindromoScreen();
      case 2:
        return adivinaScreen();
      case 3:
        return fondoDinamicoScreen();
      default:
        return mainMenu();
    }
  }

  Widget fondoDinamicoScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(arregloImagenes[imagenActual]),
          TextButton(onPressed: () {}, child: Text('RANDOM'))
        ],
      ),
    );
  }

  Widget adivinaScreen() {
    return ListView(
      padding: const EdgeInsets.all(30),
      children: [
        const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("palabraAAdivinar")]),
        const SizedBox(height: 20),
        TextField(
            controller: adivinaController,
            decoration: const InputDecoration(
                labelText: 'Letra', suffixIcon: Icon(Icons.access_alarm))),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () {}, child: const Text('Generar')),
        Text(mensajeAdivina)
      ],
    );
  }

  Widget palindromoScreen() {
    return ListView(
      padding: const EdgeInsets.all(30),
      children: [
        TextField(
          controller: palindromoController,
          decoration: const InputDecoration(
            labelText: 'Palabra',
            suffixIcon: Icon(Icons.add),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () {}, child: const Text('Generar'))
      ],
    );
  }

  Widget mainMenu() {
    return ListView(
      padding: const EdgeInsets.all(30),
      children: [
        ElevatedButton.icon(
            onPressed: () {
              setState(() {
                screen = 1;
              });
            },
            icon: Icon(Icons.add),
            label: const Text('Palindromo')),
        ElevatedButton.icon(
            onPressed: () {
              setState(() {
                screen = 2;
              });
            },
            icon: Icon(Icons.add),
            label: const Text('Adivina la palabra')),
        ElevatedButton.icon(
            onPressed: () {
              setState(() {
                screen = 3;
              });
            },
            icon: Icon(Icons.add),
            label: const Text('Fondo Dinamico')),
      ],
    );
  }
}

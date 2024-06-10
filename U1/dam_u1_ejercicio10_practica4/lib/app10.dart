import 'dart:math';

import 'package:flutter/material.dart';

class App10 extends StatefulWidget {
  const App10({super.key});

  @override
  State<App10> createState() => _App10State();
}

int screen = 1;
TextEditingController genNumberController = TextEditingController();
TextEditingController findNumberController = TextEditingController();
List uniqueListNumbers = [];
List duplicatedListNumbers = [];
String indices = '';

class _App10State extends State<App10> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        title: const Text('App10'),
        actions: drawAction(),
      ),
      body:
          ListView(padding: const EdgeInsets.all(30), children: drawScreens()),
    );
  }

  List<Widget> drawAction() {
    switch (screen) {
      case 1:
        return [drawIconHome()];
      case 2 || 3:
        return [
          IconButton(
              onPressed: () {
                if (screen == 2 || screen == 3) setState(() => screen = 1);
              },
              icon: (screen == 2 || screen == 3)
                  ? const Icon(Icons.arrow_back)
                  : const Icon(Icons.crop_square))
        ];
      default:
        return [drawIconHome()];
    }
  }

  Widget drawIconHome() {
    return IconButton(onPressed: () {}, icon: const Icon(Icons.crop_square));
  }

  List<Widget> drawScreens() {
    switch (screen) {
      case 1:
        return screenHome();
      case 2:
        return screenGenNumbers();
      case 3:
        return screenFindNumbers();
      default:
        return screenHome();
    }
  }

  List<Widget> screenGenNumbers() {
    return [
      TextField(
        controller: genNumberController,
        decoration: const InputDecoration(
            suffixIcon: Icon(Icons.numbers), labelText: 'Cantidad a generar'),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
          onPressed: () {
            setState(() {
              genUniqueNumbers(int.parse(genNumberController.text));
            });
          },
          child: const Text('GENERAR')),
      const SizedBox(height: 20),
      Text(getUniqueNumbers()),
    ];
  }

  genUniqueNumbers(n) {
    uniqueListNumbers.clear();
    for (var i = 0; i < n; i++) {
      int number = Random().nextInt(500);
      while (uniqueListNumbers.contains(number)) {
        number = Random().nextInt(500);
      }
      uniqueListNumbers.add(number);
    }
  }

  getUniqueNumbers() {
    String cad = '';
    for (var i = 0; i < uniqueListNumbers.length; i++) {
      cad += '[${i + 1}]=>${uniqueListNumbers[i].toString()}\n';
    }
    return cad;
  }

  List<Widget> screenFindNumbers() {
    setState(() {
      genNumbers();
    });
    return [
      TextField(
        controller: findNumberController,
        decoration: const InputDecoration(
            suffixIcon: Icon(Icons.numbers), labelText: '# duplicado a buscar'),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
          onPressed: () {
            findDuplicateNumber(int.parse(findNumberController.text));
          },
          child: const Text('BUSCAR')),
      const SizedBox(height: 20),
      Text('RESULTADO: ${indices}'),
      Text(duplicatedListNumbers.toString())
    ];
  }

  findDuplicateNumber(n) {

  }

  genNumbers() {
    duplicatedListNumbers.clear();
    for (var i = 0; i < 500; i++) {
      duplicatedListNumbers.add(Random().nextInt(500));
    }
  }

  List<Widget> screenHome() {
    return [
      ElevatedButton.icon(
        onPressed: () {
          setState(() => screen = 2);
        },
        label: const Text('Generar numeros'),
        style: ElevatedButton.styleFrom(),
        icon: const Icon(Icons.numbers),
      ),
      ElevatedButton.icon(
          onPressed: () {
            setState(() => screen = 3);
          },
          label: const Text('Encontrar numeros'),
          icon: const Icon(Icons.find_in_page_outlined))
    ];
  }
}

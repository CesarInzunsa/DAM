import 'Package:flutter/material.dart';

class App08 extends StatefulWidget {
  const App08({super.key});

  @override
  State<App08> createState() => _App08State();
}

int screen = 1;
TextEditingController factorialController = TextEditingController();
String resFactorial = '';
TextEditingController vectorController = TextEditingController();

List<String> itemsList = ['ENTEROS', 'DECIMALES'];
String tipoSeleccionado = 'ENTEROS';

class _App08State extends State<App08> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('App08 Práctica2'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          actions: appBarActions()),
      body: ListView(
          padding: const EdgeInsets.all(30),
          children: [Center(child: Column(children: switchBody()))]),
    );
  }

  List<Widget> switchBody() {
    switch (screen) {
      case 1:
        return screenFactorial();
      case 2:
        return screenVector();
      case 3:
        return screenGaleria();
      default:
        return screenFactorial();
    }
  }

  List<Widget> screenFactorial() {
    return <Widget>[
      const Text('FACTORIAL',
          style: TextStyle(color: Colors.blue, fontSize: 30)),
      TextField(
        controller: factorialController,
        decoration: const InputDecoration(
            labelText: 'Número',
            suffixIcon: Icon(
              Icons.numbers_outlined,
              color: Colors.blue,
            )),
        keyboardType: TextInputType.number,
      ),
      FilledButton(
          onPressed: () {
            setState(() {
              genFactorial();
            });
          },
          child: const Text('GENERAR')),
      Text(
        resFactorial,
        style: const TextStyle(fontSize: 15),
      )
    ];
  }

  genFactorial() {
    if (factorialController.text.isEmpty) {
      resFactorial = 'Ingrese un número';
    } else {
      int n = int.parse(factorialController.text);
      int f = 1;
      for (int i = 1; i <= n; i++) {
        f *= i;
      }
      resFactorial = 'Factorial de $n es $f';
    }
  }

  List<Widget> screenVector() {
    return <Widget>[
      const Text('GENERAR VECTOR',
          style: TextStyle(color: Colors.red, fontSize: 30)),
      const SizedBox(height: 20),
      TextField(
        controller: vectorController,
        decoration: const InputDecoration(
            labelText: 'Cantidad de valores a generar',
            suffixIcon: Icon(Icons.numbers_outlined)),
      ),
      const SizedBox(height: 20),
      DropdownButtonFormField(
          items: itemsList.map((e) {
            return DropdownMenuItem(value: e, child: Text(e));
          }).toList(),
          onChanged: (item) {
            setState(() {
              tipoSeleccionado = item!;
            });
          })
    ];
  }

  List<Widget> screenGaleria() {
    return <Widget>[];
  }

  List<Widget> appBarActions() {
    return <Widget>[
      IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              screen = 1;
            });
          }),
      IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              screen = 2;
            });
          }),
      IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            setState(() {
              screen = 3;
            });
          }),
    ];
  }
}

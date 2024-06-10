import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App0206(),
    ),
  );
}

/*
  Metodos Asincronos = async
  Metodos Sincronos = sync
*/

class App0206 extends StatefulWidget {
  const App0206({super.key});

  @override
  State<App0206> createState() => _App0206State();
}

class _App0206State extends State<App0206> {
  String mensaje = ''; //Hola, como, estas,
  double valor2 = 0.0;
  int valor = 0;
  final controlador = TextEditingController();
  final controlador2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences objeto = await SharedPreferences.getInstance();
    setState(() {
      valor = objeto.getInt('valor') ?? 0;
      mensaje = objeto.getString('mensaje') ?? '';
    });
  }

  void concatenacion() async {
    SharedPreferences objeto = await SharedPreferences.getInstance();
    setState(() {
      mensaje += '${controlador.text},';
      objeto.setString('mensaje', mensaje);
      controlador.clear();
    });
  }

  void incrementar() async {
    SharedPreferences objeto = await SharedPreferences.getInstance();
    setState(() {
      valor++;
      objeto.setInt('valor', valor);
    });
  }

  void decrementar() async {
    SharedPreferences objeto = await SharedPreferences.getInstance();
    setState(() {
      valor--;
      objeto.setInt('valor', valor);
    });
  }

  void concatenacion2() async {
    SharedPreferences objeto = await SharedPreferences.getInstance();
    setState(() {
      valor2 += double.parse(controlador2.text);
      objeto.setDouble('valor2', valor2);
      controlador2.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador: $valor'),
      ),
      body: ListView(
        children: [
          Text(
            mensaje,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: controlador,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                concatenacion();
              },
              child: const Text('AGREGAR')),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Valor: $valor2',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: controlador2,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                concatenacion2();
              },
              child: const Text('AGREGAR double')),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              decrementar();
            },
            child: const Text('Decrementar el valor'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          incrementar();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';

List nombres = [
  'Juana Miranda',
  'Maria Lopez',
  'Juan Perez',
  'Ana Miranda',
  'Pedro Lopez',
  'Maria Perez',
  'Juan Miranda',
  'Ana Lopez',
  'Juana Perez',
  'Pedro Miranda',
  'Maria Miranda',
  'Juan Lopez',
  'Ana Perez'
];
List oficios = [
  'Carpintero',
  'Albañil',
  'Pintor',
  'Electricista',
  'Plomero',
  'Mecanico',
  'Cocinero',
  'Carnicero',
  'Panadero',
  'Pescadero',
  'Cajero',
  'Vendedor',
  'Repartidor'
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _indice = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: App201());
  }

  Widget App201() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('App2 01'),
      ),
      body: dinamico(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'INICIO'),
          BottomNavigationBarItem(icon: Icon(Icons.cake), label: 'PASTEL'),
          BottomNavigationBarItem(icon: Icon(Icons.delete), label: 'BORRAR')
        ],
        currentIndex: _indice,
        onTap: (indiceActual) {
          setState(() {
            _indice = indiceActual;
          });
        },
        backgroundColor: Colors.amber,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        //iconSize: 30,
        //selectedFontSize: 20,
        //unselectedFontSize: 15,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget dinamico() {
    switch (_indice) {
      case 1:
        return tarjetas();
      case 2:
        return listaNombres();
      default:
        return Center(child: Icon(Icons.home, size: 40));
    }
  }

  Widget tarjetas() {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Card(
                child: Container(
                  width: 500,
                  height: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/icono1.png"),
                      Text('Facebook', style: const TextStyle(fontSize: 30)),
                      Text('Compañia META',
                          style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Container(
                  width: 500,
                  height: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/icono2.png"),
                      Text('Itunes', style: const TextStyle(fontSize: 30)),
                      Text('Compañia APPLE',
                          style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Container(
                  width: 500,
                  height: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/icono3.png"),
                      Text('WhatsApp', style: const TextStyle(fontSize: 30)),
                      Text('Compañia META',
                          style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Container(
                  width: 500,
                  height: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/icono4.png"),
                      Text('Amazon', style: const TextStyle(fontSize: 30)),
                      Text('Compañia AMAZON',
                          style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Container(
                  width: 500,
                  height: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/icono5.png"),
                      Text('Youtube', style: const TextStyle(fontSize: 30)),
                      Text('Compañia GOOGLE',
                          style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Container(
                  width: 500,
                  height: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/icono6.png"),
                      Text('Twitter', style: const TextStyle(fontSize: 30)),
                      Text('Compañia TWITTER',
                          style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Container(
                  width: 500,
                  height: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/icono7.png"),
                      Text('Instagram', style: const TextStyle(fontSize: 30)),
                      Text('Compañia META',
                          style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listaNombres() {
    return ListView.builder(
      itemCount: nombres.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text('${nombres[index]}'),
              subtitle: Text('${oficios[index]}'),
              leading: CircleAvatar(child: Text('${index}')),
              trailing: Icon(Icons.edit),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (builder) {
                      return AlertDialog(
                        title: Text('${nombres[index]}'),
                        content:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Text('Nombre: ${nombres[index]}'),
                          Text('Oficio: ${oficios[index]}'),
                        ]),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('SALIR'))
                        ],
                      );
                    });
              },
            ),
            Divider(height: 10)
          ],
        );
      },
    );
  }
}

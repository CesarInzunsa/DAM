import 'package:flutter/material.dart';

import 'login.dart';

class Home extends StatefulWidget {
  final String user;
  final String password;

  const Home({
    super.key,
    required this.user,
    required this.password,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: _drawUserData(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text("Menu principal"),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Datos usuario'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _drawUserData() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person_outline, size: 50),
            ),
            const SizedBox(height: 20),
            Text('Usuario: ${widget.user}'),
            const SizedBox(height: 20),
            Text('Contraseña: ${widget.password}'),
          ],
        ),
      ),
    );
  }
}

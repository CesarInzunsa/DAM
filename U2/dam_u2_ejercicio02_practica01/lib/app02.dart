import 'package:dam_u2_ejercicio02_practica01/person.dart';
import 'package:flutter/material.dart';

class App02 extends StatefulWidget {
  const App02({super.key});

  @override
  State<App02> createState() => _App02State();
}

List<Person> persons = [
  Person(
      name: 'Cesar Inzunsa', address: 'Calle 123', phoneNumber: '1234567890'),
  Person(name: 'Juan Perez', address: 'Calle 456', phoneNumber: '0987654321'),
  Person(name: 'Maria Lopez', address: 'Calle 789', phoneNumber: '6789012345')
];

int _index = 0;
TextEditingController _namePersonController = TextEditingController();
TextEditingController _addressPersonController = TextEditingController();
TextEditingController _phoneNumberPersonController = TextEditingController();

class _App02State extends State<App02> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _drawAppBar(),
      body: _drawBody(),
      bottomNavigationBar: _drawBottomNavigationBar(),
    );
  }

  AppBar _drawAppBar() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      foregroundColor: Colors.white,
      title: const Text('App02'),
    );
  }

  Widget _drawBody() {
    switch (_index) {
      case 1:
        return _drawGetPersons();
      case 2:
        return _drawAbout();
      default:
        return _drawInsertPerson();
    }
  }

  ListView _drawInsertPerson() {
    return ListView(
      padding: const EdgeInsets.all(30),
      children: [
        TextField(
          controller: _namePersonController,
          decoration: const InputDecoration(
              labelText: 'Nombre:', suffixIcon: Icon(Icons.person)),
        ),
        TextField(
          controller: _addressPersonController,
          decoration: const InputDecoration(
              labelText: 'Domicilio:', suffixIcon: Icon(Icons.home)),
        ),
        TextField(
          controller: _phoneNumberPersonController,
          decoration: const InputDecoration(
              labelText: 'Telefono:', suffixIcon: Icon(Icons.phone)),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (isFieldsEmpty()) {
                    return;
                  }

                  var p = Person(
                      name: _namePersonController.text,
                      address: _addressPersonController.text,
                      phoneNumber: _phoneNumberPersonController.text);

                  setState(() {
                    persons.add(p);
                  });
                  _clearFields();
                },
                child: const Text('Capturar')),
            ElevatedButton(
                onPressed: () {
                  _clearFields();
                },
                child: const Text('Limpiar')),
          ],
        )
      ],
    );
  }

  void _clearFields() {
    _namePersonController.clear();
    _addressPersonController.clear();
    _phoneNumberPersonController.clear();
  }

  bool isFieldsEmpty() {
    return _namePersonController.text.isEmpty ||
        _addressPersonController.text.isEmpty ||
        _phoneNumberPersonController.text.isEmpty;
  }

  ListView _drawGetPersons() {
    return ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(persons[index].name),
            subtitle: Text(persons[index].address),
            trailing: Text(persons[index].phoneNumber),
          );
        });
  }

  BottomNavigationBar _drawBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'CAPTURA'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'LISTADO'),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: 'ACERCA DE')
      ],
      currentIndex: _index,
      onTap: (currentIndex) {
        setState(() {
          _index = currentIndex;
        });
      },
      backgroundColor: Colors.blueGrey,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[300],
      type: BottomNavigationBarType.fixed,
    );
  }

  Center _drawAbout() {
    return const Center(
        child: Text(
      '(C) Cesar Inzunsa\nDerechos Reservado 2024',
      style: TextStyle(color: Colors.red, fontSize: 20),
    ));
  }
}

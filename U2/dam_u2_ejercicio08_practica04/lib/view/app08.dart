import 'package:dam_u2_ejercicio08_practica04/controller/studentController.dart';
import 'package:flutter/material.dart';

import '../model/student.dart';

class App08 extends StatefulWidget {
  const App08({super.key});

  @override
  State<App08> createState() => _App08State();
}

class _App08State extends State<App08> {
  int index = 0;
  var ncController = TextEditingController();
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var degreeController = TextEditingController();
  var indexController = TextEditingController();
  List<Student> listStudents = StudentController().data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ejercicio 08 - Práctica 04'),
      ),
      body: _drawBody(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Text('ESTUDIANTES'),
            ),
            const SizedBox(height: 10),
            _drawItem('Capturar', 0, const Icon(Icons.add)),
            _drawItem('Listado', 1, const Icon(Icons.list)),
            _drawItem('Borrar almacen', 2, const Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }

  ListTile _drawItem(String title, int index, Icon icon) {
    return ListTile(
      title: Row(
        children: [
          Expanded(child: icon),
          Expanded(flex: 2, child: Text(title))
        ],
      ),
      onTap: () {
        setState(() {
          this.index = index;
        });
        Navigator.pop(context);
      },
    );
  }

  Future<void> fetchData2() async {
    await StudentController().getStudents();
    listStudents = StudentController().data;
  }

  Widget _drawBody() {
    switch (index) {
      case 1:
        return FutureBuilder(
            future: fetchData2(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text("Error");
                }
                return _drawListDataScreen();
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            });
      case 2:
        return _drawDeleteStorageScreen();
      case 3:
        return _drawUpdateDataScreen();
      default:
        return _drawInsertDataScreen();
    }
  }

  ListView _drawInsertDataScreen() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _drawTextField('Número de control', ncController),
        _drawTextField('Nombre', nameController),
        _drawTextField('Dirección', addressController),
        _drawTextField('Carrera', degreeController),
        ElevatedButton(
          onPressed: () {
            if (areThereEmptyFields()) return;
            setState(() {
              saveData();
            });
            cleartextFields();
          },
          child: const Text('GUARDAR'),
        ),
      ],
    );
  }

  void cleartextFields() {
    ncController.clear();
    nameController.clear();
    addressController.clear();
    degreeController.clear();
  }

  ListView _drawListDataScreen() {
    return ListView.builder(
      itemCount: listStudents.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(listStudents[i].name),
          subtitle: Text(listStudents[i].degree),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              setState(() {
                index = 3;
              });
            },
          ),
        );
      },
    );
  }

  ListView _drawUpdateDataScreen() {
    return ListView(
      children: [
        _drawTextField('Número de control', ncController),
        _drawTextField('Nombre', nameController),
        _drawTextField('Dirección', addressController),
        _drawTextField('Carrera', degreeController),
        _drawTextField('Indice', indexController),
        ElevatedButton(
          onPressed: () {
            if (areThereEmptyFields()) return;
            updateStudent();
          },
          child: const Text('ACTUALIZAR'),
        ),
      ],
    );
  }

  TextFormField _drawTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  ListView _drawDeleteStorageScreen() {
    return ListView();
  }

  void fetchData() async {
    await StudentController().getStudents();
    setState(() {
      listStudents = StudentController().data;
    });
  }

  void saveData() async {
    Student student = Student(
      nc: ncController.text,
      name: nameController.text,
      address: addressController.text,
      degree: degreeController.text,
    );

    await StudentController().addStudent(student);
    fetchData();
  }

  void updateStudent() async {
    Student student = Student(
      nc: ncController.text,
      name: nameController.text,
      address: addressController.text,
      degree: degreeController.text,
    );

    await StudentController()
        .updateStudent(int.parse(indexController.text), student);
    fetchData();
  }

  bool areThereEmptyFields() {
    return ncController.text.isEmpty ||
        nameController.text.isEmpty ||
        addressController.text.isEmpty ||
        degreeController.text.isEmpty;
  }
}

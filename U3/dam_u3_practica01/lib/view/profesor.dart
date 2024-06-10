import 'package:flutter/material.dart';

import './widgets/navTabDestination.dart';
import '../controller/profesorController.dart';
import '../model/profesorModel.dart';

class Profesor extends StatefulWidget {
  const Profesor({super.key});

  @override
  State<Profesor> createState() => _ProfesorState();
}

class _ProfesorState extends State<Profesor> {
  TextEditingController nombreController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<ProfesorModel> profesores = [];
  final carreras = [
    'Ingenieria en Sistemas',
    'Arquitectura',
    'Ingenieria Bioquimica',
    'Ingenieria Civil',
    'Ingenieria Electrica',
    'Ingenieria en Gestion Empresarial',
    'Ingenieria Industrial',
    'Ingenieria Mecatronica',
    'Ingenieria Quimica',
    'Licenciatura en Administracion',
  ];
  var carrerasController = 'Ingenieria en Sistemas';

  var carreraNombreProfesorController = 'Ingenieria en Sistemas';
  List<ProfesorModel> profesoresByCarrera = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    List<ProfesorModel> profesores = await ProfesorController.getAll();
    setState(() {
      this.profesores = profesores;
    });

    setState(() {
      profesoresByCarrera = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: NavTabDestination.getNavTabDestination(),
        body: TabBarView(
          children: [
            _displayAllProfesores(),
            _drawQuery(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _displayProfesorModal(),
        ),
      ),
    );
  }

  /// Function to display all profesores with a ListTile
  Widget _displayAllProfesores() {
    if (profesores.isEmpty) {
      return const Center(child: Text('No hay profesores registradas'));
    }

    return ListView.builder(
      itemCount: profesores.length,
      itemBuilder: (builder, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(profesores[index].idProfesor.toString()),
            ),
            title: Text(profesores[index].nombreProfesor),
            subtitle: Text(profesores[index].carreraProfesor),
            onTap: () => _showProfesorAlertDialog(profesores[index]),
          ),
        );
      },
    );
  }

  /// Function to display a query
  Widget _drawQuery() {
    return Column(
      children: [
        const SizedBox(height: 11),
        const Text('Buscar por carrera:',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 11),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DropdownButtonFormField(
                isExpanded: true,
                value: carreraNombreProfesorController,
                items: carreras.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    carreraNombreProfesorController = value!;
                  });
                },
              ),
            ),
            FilledButton(
              onPressed: () async {
                profesoresByCarrera = await ProfesorController.getByCarrera(
                    carreraNombreProfesorController.toLowerCase());
                setState(() {
                  profesoresByCarrera;
                });
              },
              child: const Text('Buscar'),
            ),
          ],
        ),
        const SizedBox(height: 11),
        profesoresByCarrera.isEmpty || carreraNombreProfesorController.isEmpty
            ? Center(
                child: Container(
                padding: const EdgeInsets.all(20),
                child:
                    const Text('No se encontraron profesores con esa carrera'),
              ))
            : Expanded(
                child: ListView.builder(
                  itemCount: profesoresByCarrera.length,
                  itemBuilder: (builder, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                              profesoresByCarrera[index].idProfesor.toString()),
                        ),
                        title: Text(profesoresByCarrera[index].nombreProfesor),
                        subtitle:
                            Text(profesoresByCarrera[index].carreraProfesor),
                        onTap: () => _showProfesorAlertDialog(
                            profesoresByCarrera[index]),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  /// This function displays a modal for creating or updating a Profesor.
  void _displayProfesorModal([ProfesorModel? profesor]) {
    _clearFields();
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) => _drawProfesorModal(profesor),
    );
  }

  /// This function draws the modal for creating or updating a Profesor.
  Widget _drawProfesorModal(ProfesorModel? profesor) {
    bool isUpdating = profesor != null;
    return Column(
      children: [
        _getProfesorForm(profesor),
        _getActionButton(
          isUpdating ? () => _updateOneProfesor(profesor) : _insertOneProfesor,
          isUpdating ? 'Actualizar profesor' : 'Crear profesor',
        ),
      ],
    );
  }

  /// This function gets the form for creating or updating a Profesor.
  Widget _getProfesorForm(ProfesorModel? profesor) {
    if (profesor != null && nombreController.text.isEmpty) {
      nombreController.text = profesor.nombreProfesor;
    }
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              controller: nombreController,
              decoration: const InputDecoration(
                hintText: 'Nombre del profesor',
                prefixIcon: Icon(Icons.short_text_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 11),
            DropdownButtonFormField(
              value: carrerasController,
              items: carreras.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  carrerasController = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor seleccione una carrera';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  /// This function gets the action button for creating or updating a Profesor.
  Widget _getActionButton(myFuction, String text) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          myFuction();
          Navigator.of(context).pop();
        }
      },
      child: Text(text),
    );
  }

  /// This function shows an alert dialog for a Profesor.
  void _showProfesorAlertDialog(ProfesorModel profesor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profesor'),
        content: const Text('¿Qué desea hacer con el profesor?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _displayProfesorModal(profesor);
            },
            child: const Text('Editar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showConfirmDeleteProfesor(profesor);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  /// This function shows a confirm dialog for deleting a Profesor.
  void _showConfirmDeleteProfesor(ProfesorModel profesor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar profesor'),
        content: const Text('¿Está seguro de eliminar al profesor?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteOneProfesor(profesor);
            },
            child: const Text('Sí'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  /// This function creates a new Profesor
  void _insertOneProfesor() {
    ProfesorModel profesor = ProfesorModel(
      idProfesor: -1,
      nombreProfesor: nombreController.text,
      carreraProfesor: carrerasController,
    );

    ProfesorController.insertOne(profesor).then((value) {
      _showMessage('Profesor creado correctamente');
      _loadData();
    });
  }

  /// This function updates a Profesor
  void _updateOneProfesor(ProfesorModel oldProfesor) {
    ProfesorModel profesor = ProfesorModel(
      idProfesor: oldProfesor.idProfesor,
      nombreProfesor: nombreController.text,
      carreraProfesor: carrerasController,
    );

    ProfesorController.updateOne(profesor).then((value) {
      _showMessage('Profesor actualizado correctamente');
      _loadData();
    });
  }

  /// This function deletes a Profesor
  void _deleteOneProfesor(ProfesorModel profesor) {
    ProfesorController.deleteOne(profesor.idProfesor).then((value) {
      _showMessage('Profesor eliminado correctamente');
      _loadData();
    });
  }

  /// This function clears the fields
  void _clearFields() {
    nombreController.clear();
    carrerasController = 'Ingenieria en Sistemas';
  }

  /// This function shows a message in a SnackBar
  void _showMessage(String msj) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msj)),
    );
  }
}

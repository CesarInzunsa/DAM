import 'package:flutter/material.dart';

import '../controller/materiaController.dart';
import './widgets/navTabDestination.dart';
import '../model/materiaModel.dart';

class Materia extends StatefulWidget {
  const Materia({super.key});

  @override
  State<Materia> createState() => _MateriaState();
}

class _MateriaState extends State<Materia> {
  TextEditingController nombreController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<MateriaModel> materias = [];

  TextEditingController nombreMateriaController = TextEditingController();
  List<MateriaModel> materiasByName = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    List<MateriaModel> materias = await MateriaController.getAll();
    setState(() {
      this.materias = materias;
    });

    setState(() {
      materiasByName = [];
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
            _displayAllMaterias(),
            _drawQuery(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _displayMateriaModal(),
        ),
      ),
    );
  }

  /// Function to display all materias with a ListTile
  Widget _displayAllMaterias() {
    if (materias.isEmpty) {
      return const Center(child: Text('No hay materias registradas'));
    }

    return ListView.builder(
      itemCount: materias.length,
      itemBuilder: (builder, index) {
        return Card(
          //color: Colors.orange[50],
          //surfaceTintColor: Colors.orange[50],
          child: ListTile(
            leading: CircleAvatar(
              //backgroundColor: Colors.orange[100],
              child: Text(materias[index].idMateria.toString()),
            ),
            title: Text(materias[index].nombreMateria),
            onTap: () => _showMateriaAlertDialog(materias[index]),
          ),
        );
      },
    );
  }

  /// Function to search by materia
  Widget _drawQuery() {
    return Column(
      children: [
        const SizedBox(height: 11),
        const Text('Buscar por nombre:',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 11),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: nombreMateriaController,
                decoration: const InputDecoration(
                  hintText: 'Buscar por nombre',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            FilledButton(
              onPressed: () async {
                materiasByName = await MateriaController.getByName(
                    nombreMateriaController.text.toLowerCase());
                setState(() {
                  materiasByName;
                });
              },
              child: const Text('Buscar'),
            ),
          ],
        ),
        const SizedBox(height: 11),
        materiasByName.isEmpty || nombreMateriaController.text.isEmpty
            ? Center(
                child: Container(
                padding: const EdgeInsets.all(20),
                child: const Text('No se encontraron materias registradas'),
              ))
            : Expanded(
                child: ListView.builder(
                  itemCount: materiasByName.length,
                  itemBuilder: (builder, index) {
                    return Card(
                      //color: Colors.orange[50],
                      //surfaceTintColor: Colors.orange[50],
                      child: ListTile(
                        leading: CircleAvatar(
                          //backgroundColor: Colors.orange[100],
                          child:
                              Text(materiasByName[index].idMateria.toString()),
                        ),
                        title: Text(materiasByName[index].nombreMateria),
                        onTap: () =>
                            _showMateriaAlertDialog(materiasByName[index]),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  /// This function displays a modal for creating or updating a Materia.
  void _displayMateriaModal([MateriaModel? materia]) {
    _clearFields();
    showModalBottomSheet(
      //backgroundColor: Colors.orange[50],
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) => _drawMateriaModal(materia),
    );
  }

  /// This function draws the modal for creating or updating a Materia.
  Widget _drawMateriaModal(MateriaModel? materia) {
    bool isUpdating = materia != null;
    return Column(
      children: [
        _getMateriaForm(materia),
        _getActionButton(
          isUpdating ? () => _updateOneMateria(materia) : _insertOneMateria,
          isUpdating ? 'Actualizar materia' : 'Crear materia',
        ),
      ],
    );
  }

  /// This function gets the form for creating or updating a Materia.
  Widget _getMateriaForm(MateriaModel? materia) {
    if (materia != null && nombreController.text.isEmpty) {
      nombreController.text = materia.nombreMateria;
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
                hintText: 'Nombre de la materia',
                prefixIcon: Icon(Icons.short_text_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un nombre';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  /// This function gets the action button for creating or updating a Materia.
  Widget _getActionButton(myFuction, String text) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.of(context).pop();
          myFuction();
        }
      },
      child: Text(text),
    );
  }

  /// This function shows an alert dialog for a Materia.
  void _showMateriaAlertDialog(MateriaModel materia) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Materia'),
        content: const Text('¿Qué desea hacer con la materia?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _displayMateriaModal(materia);
            },
            child: const Text('Editar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showConfirmDeleteMateria(materia);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  /// This function shows a confirm dialog for deleting a Materia.
  void _showConfirmDeleteMateria(MateriaModel materia) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar materia'),
        content: const Text('¿Está seguro de eliminar la materia?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteOneMateria(materia);
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

  /// This function creates a new Materia
  void _insertOneMateria() {
    MateriaModel materia = MateriaModel(
      idMateria: -1,
      nombreMateria: nombreController.text,
    );

    MateriaController.insertOne(materia).then((value) {
      _showMessage('Materia creada correctamente');
      _loadData();
    });
  }

  /// This function updates a Materia
  void _updateOneMateria(MateriaModel oldMateria) {
    MateriaModel materia = MateriaModel(
      idMateria: oldMateria.idMateria,
      nombreMateria: nombreController.text,
    );

    MateriaController.updateOne(materia).then((value) {
      _showMessage('Materia actualizada correctamente');
      _loadData();
    });
  }

  /// This function deletes a Materia
  void _deleteOneMateria(MateriaModel materia) {
    MateriaController.deleteOne(materia.idMateria).then((value) {
      _showMessage('Materia eliminada correctamente');
      _loadData();
    });
  }

  /// This function clears the fields
  void _clearFields() {
    nombreController.clear();
  }

  /// This function shows a message in a SnackBar
  void _showMessage(String msj) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msj)),
    );
  }
}

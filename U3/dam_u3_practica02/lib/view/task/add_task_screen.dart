import 'package:flutter/material.dart';

import '../../model/subject_model.dart';
import '../../controller/subject_controller.dart';
import '../../model/task_model.dart';
import '../../controller/task_controller.dart';
import '../config/config.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var idSubjectController = TextEditingController();
  var dateTaskController = TextEditingController();
  var descriptionTaskController = TextEditingController();

  List<SubjectModel> subjects = [];

  @override
  void initState() {
    super.initState();
    _fetchSubjects();
  }

  void _fetchSubjects() async {
    List<SubjectModel> subjects = await SubjectController.getAll();

    setState(() {
      this.subjects = subjects;
    });

    idSubjectController.text = subjects[0].idSubject;

    setState(() {
      idSubjectController;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.orange,
        leading: const Icon(Icons.add_home_work),
        title: const Text(
          'Agregar tarea',
          style: Config.appBarTextStyle,
        ),
      ),
      body: _displayForm(),
    );
  }

  Widget _displayForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // idMateria TEXT
          //_drawTextField('idMateria', idSubjectController),
          _drawDropdown(),
          // fechaEntregaTarea TEXT
          //Config.drawTextField('fecha de entrega de la tarea', dateTaskController),
          Config.drawDatePicker(dateTaskController, context),
          // descripcion TEXT
          Config.drawTextField('Descripcion', descriptionTaskController),
          // Botones
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Config.drawButton(
                'Cancelar',
                _onCancel,
                ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
              Config.drawButton(
                'Guardar',
                _onSave,
                ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _drawDropdown() {
    return DropdownButtonFormField(
      value: idSubjectController.text,
      padding: const EdgeInsets.only(bottom: 13.0),
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      onChanged: (value) {
        setState(() {
          idSubjectController.text = value!;
        });
      },
      items: subjects.map((e) {
        return DropdownMenuItem(
          value: e.idSubject,
          child: Text(e.nameSubject),
        );
      }).toList(),
    );
  }

  void _onCancel() {
    Navigator.pop(context);
  }

  void _onSave() {
    if (_isControllersEmpty()) {
      Config.showMessage(context, 'Todos los campos son requeridos');
      return;
    }

    TaskModel task = TaskModel(
      idSubjectTask: idSubjectController.text,
      dateTask: dateTaskController.text,
      descriptionTask: descriptionTaskController.text,
    );

    TaskController.insertOne(task).then((value) {
      Navigator.pop(context);
    });
  }

  bool _isControllersEmpty() {
    return idSubjectController.text.isEmpty ||
        dateTaskController.text.isEmpty ||
        descriptionTaskController.text.isEmpty;
  }
}

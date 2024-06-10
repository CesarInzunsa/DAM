import 'package:flutter/material.dart';

import '../../controller/subject_controller.dart';
import '../../controller/task_controller.dart';
import '../../model/subject_model.dart';
import '../../model/task_model.dart';
import '../../model/task_subject.dart';
import '../config/config.dart';

class UpdateTaskScreen extends StatefulWidget {
  const UpdateTaskScreen({super.key});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  late var idSubjectController =
      TextEditingController(text: taskAndSubject.subject.idSubject);
  late var dateTaskController =
      TextEditingController(text: taskAndSubject.task.dateTask);
  late var descriptionTaskController =
      TextEditingController(text: taskAndSubject.task.descriptionTask);

  late TaskSubjectModel taskAndSubject;

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

    idSubjectController.text = taskAndSubject.subject.idSubject;

    setState(() {
      idSubjectController;
    });
  }

  @override
  Widget build(BuildContext context) {
    taskAndSubject =
        ModalRoute.of(context)!.settings.arguments as TaskSubjectModel;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.orange,
        leading: const Icon(Icons.edit),
        title: const Text(
          'Actualizar tarea',
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
          _drawDropdown(),
          //Config.drawTextField('fecha de entrega de la tarea', dateTaskController),
          Config.drawDatePicker(dateTaskController, context),
          Config.drawTextField('Descripcion', descriptionTaskController),
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
      idTask: taskAndSubject.task.idTask,
      idSubjectTask: idSubjectController.text,
      dateTask: dateTaskController.text,
      descriptionTask: descriptionTaskController.text,
    );

    TaskController.updateOne(task).then((value) {
      Navigator.pop(context);
    });
  }

  bool _isControllersEmpty() {
    return idSubjectController.text.isEmpty ||
        dateTaskController.text.isEmpty ||
        descriptionTaskController.text.isEmpty;
  }
}

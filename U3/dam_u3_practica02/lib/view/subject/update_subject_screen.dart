import 'package:flutter/material.dart';

import '../config/config.dart';
import '../../controller/subject_controller.dart';
import '../../model/subject_model.dart';

class UpdateSubjectScreen extends StatefulWidget {
  const UpdateSubjectScreen({super.key});

  @override
  State<UpdateSubjectScreen> createState() => _UpdateSubjectScreenState();
}

class _UpdateSubjectScreenState extends State<UpdateSubjectScreen> {
  late var nameSubjectController =
      TextEditingController(text: subject.nameSubject);
  late var semesterSubjectController =
      TextEditingController(text: subject.semesterSubject);
  late var teacherSubjectController =
      TextEditingController(text: subject.teacherSubject);
  late SubjectModel subject;
  List<String> semesters = Config.getSemesters();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    subject = ModalRoute.of(context)!.settings.arguments as SubjectModel;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.orange,
        leading: const Icon(Icons.edit),
        title: const Text(
          'Actualizar materia',
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
          Config.drawTextField(
              'Nombre de la materia', nameSubjectController),
          _drawDropdown(),
          Config.drawTextField(
              'Docente de la materia', teacherSubjectController),
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
                _onUpdate,
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
      value: semesterSubjectController.text,
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
          semesterSubjectController.text = value.toString();
        });
      },
      items: semesters.map((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(e),
        );
      }).toList(),
    );
  }

  void _onCancel() {
    Navigator.pop(context);
  }

  void _onUpdate() {
    if (_isControllersEmpty()) {
      Config.showMessage(context, 'Todos los campos son requeridos');
      return;
    }

    subject.nameSubject = nameSubjectController.text;
    subject.semesterSubject = semesterSubjectController.text;
    subject.teacherSubject = teacherSubjectController.text;

    SubjectController.updateOne(subject).then((value) {
      Navigator.pop(context);
    });
  }

  bool _isControllersEmpty(){
    return nameSubjectController.text.isEmpty ||
        semesterSubjectController.text.isEmpty ||
        teacherSubjectController.text.isEmpty;
  }
}

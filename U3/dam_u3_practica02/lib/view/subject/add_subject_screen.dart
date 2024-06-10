import 'package:flutter/material.dart';

import '../../controller/subject_controller.dart';
import '../../model/subject_model.dart';
import '../config/config.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  var nameSubjectController = TextEditingController();
  var semesterSubjectController = TextEditingController();
  var teacherSubjectController = TextEditingController();

  List<String> semesters = Config.getSemesters();

  @override
  void initState() {
    super.initState();
    semesterSubjectController.text = semesters[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.orange,
        leading: const Icon(Icons.create_new_folder),
        title: const Text(
          'Agregar materia',
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
                _onCancelSubjectPressed,
                ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
              Config.drawButton(
                'Guardar',
                _onSaveSubjectPressed,
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

  void _onCancelSubjectPressed() {
    Navigator.pop(context);
  }

  void _onSaveSubjectPressed() {
    if (_isControllersEmpty()) {
      Config.showMessage(context, 'Todos los campos son requeridos');
      return;
    }

    SubjectModel subject = SubjectModel(
      nameSubject: nameSubjectController.text,
      semesterSubject: semesterSubjectController.text,
      teacherSubject: teacherSubjectController.text,
    );

    SubjectController.insertOne(subject).then((value) {
      Navigator.pop(context);
    });
  }

  bool _isControllersEmpty(){
    return nameSubjectController.text.isEmpty ||
        semesterSubjectController.text.isEmpty ||
        teacherSubjectController.text.isEmpty;
  }
}

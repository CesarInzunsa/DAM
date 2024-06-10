import 'package:flutter/material.dart';

import '../controller/subject_controller.dart';
import '../model/subject_model.dart';
import 'config/config.dart';

class QuerySubjectsScreen extends StatefulWidget {
  const QuerySubjectsScreen({super.key});

  @override
  State<QuerySubjectsScreen> createState() => _QuerySubjectsScreenState();
}

class _QuerySubjectsScreenState extends State<QuerySubjectsScreen> {
  List<SubjectModel> subjects = [];

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() async {
    final subjects = await SubjectController.getAll();
    setState(() {
      this.subjects = subjects;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _displaySubjects(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: _displayAddSubjectScreen,
        child: const Icon(
          Icons.create_new_folder,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _displaySubjects() {
    if (subjects.isEmpty) {
      return const Center(child: Text('No hay materias registradas.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80.0),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.orange[100],
          child: ListTile(
            title: Text(subjects[index].nameSubject),
            subtitle: Text(subjects[index].teacherSubject),
            trailing: Text(subjects[index].semesterSubject),
            onTap: () {
              _optionsDialog(subjects[index]);
            },
          ),
        );
      },
    );
  }

  _displayAddSubjectScreen() {
    Navigator.pushNamed(context, '/add-subject').then((value) => _fetchData());
  }

  _optionsDialog(SubjectModel subject) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.orange[50],
          title: Text(subject.nameSubject),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profesor: ${subject.teacherSubject}'),
              Text('Semestre: ${subject.semesterSubject}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:
                  const Text('Cerrar', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  '/update-subject',
                  arguments: subject,
                ).then((value) => _fetchData());
              },
              child:
                  const Text('Editar', style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteSubjectDialog(subject);
              },
              child:
                  const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _deleteSubjectDialog(SubjectModel subject) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar materia'),
          content: const Text('¿Estás seguro de eliminar esta materia?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteSubject(subject);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSubject(SubjectModel subject) async {
    if (await SubjectController.hasTasks(subject.idSubject)) {
      Config.showMessage(context,
          'No se puede eliminar la materia porque tiene tareas asociadas.');
      return;
    }

    await SubjectController.deleteOne(subject.idSubject)
        .then((value) => _fetchData());
  }
}

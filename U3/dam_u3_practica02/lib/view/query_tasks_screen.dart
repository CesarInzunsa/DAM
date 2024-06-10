import 'package:flutter/material.dart';

import '../controller/subject_controller.dart';
import '../model/task_subject.dart';
import '../model/subject_model.dart';
import '../controller/task_controller.dart';
import 'config/config.dart';

class QueryTasksScreen extends StatefulWidget {
  const QueryTasksScreen({super.key});

  @override
  State<QueryTasksScreen> createState() => _QueryTasksScreenState();
}

class _QueryTasksScreenState extends State<QueryTasksScreen> {
  List<TaskSubjectModel> taskAndSubjects = [];
  List<SubjectModel> subjects = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    List<TaskSubjectModel> taskAndSubjects = await TaskController.getAll();

    setState(() {
      this.taskAndSubjects = taskAndSubjects;
    });

    List<SubjectModel> subjects = await SubjectController.getAll();

    setState(() {
      this.subjects = subjects;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _displayTasks(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: _displayAddTaskScreen,
          child: const Icon(
            Icons.add_home_work,
            color: Colors.white,
          ),
        ));
  }

  Widget _displayTasks() {
    if (taskAndSubjects.isEmpty) {
      return const Center(child: Text('No hay tareas registradas.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80.0),
      itemCount: taskAndSubjects.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.orange[100],
          child: ListTile(
            title: Text(taskAndSubjects[index].task.descriptionTask),
            subtitle: Text(taskAndSubjects[index].subject.nameSubject),
            leading: CircleAvatar(
              backgroundColor: Colors.orange[50],
              child: Text(taskAndSubjects[index].task.idTask.toString()),
            ),
            trailing: Text(taskAndSubjects[index].task.dateTask),
            onTap: () {
              _optionsDialog(taskAndSubjects[index]);
            },
          ),
        );
      },
    );
  }

  _displayAddTaskScreen() {
    if (subjects.isEmpty) {
      Config.showMessage(context,
          'Por favor registre una materia antes de agregar una tarea.');
      return;
    }

    Navigator.pushNamed(context, '/add-task').then((value) => _fetchData());
  }

  _optionsDialog(TaskSubjectModel taskAndSubject) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.orange[50],
          title: Text(
              'Que desea hacer con la tarea ${taskAndSubject.task.idTask}?'),
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
                  '/update-task',
                  arguments: taskAndSubject,
                ).then((value) => _fetchData());
              },
              child:
                  const Text('Editar', style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteTaskDialog(taskAndSubject);
              },
              child:
                  const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _deleteTaskDialog(TaskSubjectModel taskAndSubject) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar tarea'),
          content: const Text('¿Estás seguro de eliminar esta tarea?'),
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
                _deleteTask(taskAndSubject);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(TaskSubjectModel taskAndSubject) async {
    await TaskController.deleteOne(taskAndSubject.task.idTask)
        .then((value) => _fetchData());
  }
}

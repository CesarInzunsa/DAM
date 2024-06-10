import 'package:flutter/material.dart';

import '../controller/task_controller.dart';
import '../model/task_subject.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  List<TaskSubjectModel> taskAndSubjectList = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    List<TaskSubjectModel> taskAndSubjectList =
        await TaskController.getAllOrderByDate();

    setState(() {
      this.taskAndSubjectList = taskAndSubjectList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _displayBody();
  }

  _displayBody() {
    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
        left: 10.0,
        right: 10.0,
      ),
      itemCount: taskAndSubjectList.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.orange[100],
          child: Column(
            children: [
              _displayNameTeacher(index),
              _displayNameSubject(index),
              ExpansionTile(
                title: const Text('Descripcion de la tarea'),
                subtitle: Text(taskAndSubjectList[index].task.dateTask),
                childrenPadding: const EdgeInsets.all(22.0),
                dense: true,
                children: [
                  Row(
                    children: [
                      Text(
                        taskAndSubjectList[index].subject.teacherSubject,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 11),
                  Row(
                    children: [
                      Text(
                        taskAndSubjectList[index].task.descriptionTask,
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _displayNameTeacher(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Card.filled(
          color: Colors.orange[50],
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: Text(taskAndSubjectList[index].subject.teacherSubject),
            ),
          ),
        ),
      ],
    );
  }

  Widget _displayNameSubject(int index) {
    return SizedBox(
      height: 100,
      child: Center(
        child: Text(
          taskAndSubjectList[index].subject.nameSubject.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

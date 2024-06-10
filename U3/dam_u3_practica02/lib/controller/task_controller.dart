import 'package:sqflite/sqflite.dart';

import '../model/subject_model.dart';
import '../model/task_model.dart';
import '../model/task_subject.dart';
import 'controller.dart';

class TaskController {
  static Future<void> insertOne(TaskModel task) async {
    final Database db = await Controller.openDB();
    await db.insert(
      'task',
      task.toJSON()
    );
  }

  static Future<void> updateOne(TaskModel task) async {
    final Database db = await Controller.openDB();
    await db.update(
      'task',
      task.toJSON(),
      where: 'idTask = ?',
      whereArgs: [task.idTask],
    );
  }

  static Future<void> deleteOne(int idTask) async {
    final Database db = await Controller.openDB();
    await db.delete(
      'task',
      where: 'idTask = ?',
      whereArgs: [idTask],
    );
  }

  static Future<List<TaskSubjectModel>> getAll() async {
    final Database db = await Controller.openDB();
    List<Map<String, dynamic>> json = await db.rawQuery(
        'SELECT t.idTask, t.dateTask, t.descriptionTask, t.idSubjectTask, s.nameSubject, s.semesterSubject, s.teacherSubject FROM task t INNER JOIN subject s ON t.idSubjectTask = s.idSubject;');
    return List.generate(
      json.length,
      (index) {
        TaskModel task = TaskModel(
          idTask: json[index]['idTask'],
          idSubjectTask: json[index]['idSubjectTask'],
          dateTask: json[index]['dateTask'],
          descriptionTask: json[index]['descriptionTask'],
        );

        SubjectModel subject = SubjectModel(
          idSubject: json[index]['idSubjectTask'],
          nameSubject: json[index]['nameSubject'],
          semesterSubject: json[index]['semesterSubject'],
          teacherSubject: json[index]['teacherSubject'],
        );

        return TaskSubjectModel(
          task: task,
          subject: subject,
        );
      });
  }

  static Future<List<TaskSubjectModel>> getAllOrderByDate() async {
    final Database db = await Controller.openDB();
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT t.idTask, t.dateTask, t.descriptionTask, t.idSubjectTask, s.nameSubject, s.semesterSubject, s.teacherSubject FROM task t INNER JOIN subject s ON t.idSubjectTask = s.idSubject ORDER BY t.dateTask;');
    return List.generate(
      result.length,
      (index) => TaskSubjectModel.toTaskSubject(result[index]),
    );
  }

  static Future<bool> thereAreSubjects() async {
    final Database db = await Controller.openDB();
    List<Map<String, dynamic>> result = await db.rawQuery('SELECT * FROM subject;');
    return result.isNotEmpty;
  }
}

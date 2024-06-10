import 'package:sqflite/sqflite.dart';

import '../model/subject_model.dart';
import 'controller.dart';

class SubjectController {
  static Future<void> insertOne(SubjectModel subject) async {
    final Database db = await Controller.openDB();
    await db.insert(
      'subject',
      subject.toJSON(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<void> updateOne(SubjectModel subject) async {
    final Database db = await Controller.openDB();
    await db.update(
      'subject',
      subject.toJSON(),
      where: 'idSubject = ?',
      whereArgs: [subject.idSubject],
    );
  }

  static Future<void> deleteOne(String idSubject) async {
    final Database db = await Controller.openDB();
    await db.delete(
      'subject',
      where: 'idSubject = ?',
      whereArgs: [idSubject],
    );
  }

  static Future<List<SubjectModel>> getAll() async {
    final Database db = await Controller.openDB();
    List<Map<String, dynamic>> result = await db.query('subject');
    return List.generate(
      result.length,
      (index) => SubjectModel.toSubject(result[index]),
    );
  }

  static Future<bool> hasTasks(String idSubject) async {
    final Database db = await Controller.openDB();
    List<Map<String, dynamic>> result = await db.query(
      'task',
      where: 'idSubjectTask = ?',
      whereArgs: [idSubject],
    );
    return result.isNotEmpty;
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:dam_u1_tarea4_tu_primera_app/controller/connection.dart';
import 'package:dam_u1_tarea4_tu_primera_app/model/task.dart';

class TaskManager {
  /// Get all the tasks from the database
  Future<List<Task>> getTasks() async {
    // Get a reference to the database
    final Database db = await Controller().openDBTask();
    // Query the table for all the tasks
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    // Close the connection to the database
    await Controller().closeDBTask();
    // Convert the List<Map<String, dynamic>> into a List<Task>
    return List.generate(maps.length, (i) {
      return Task(id: maps[i]['id'], description: maps[i]['description']);
    });
  }

  /// Add a new task to the database
  Future<void> addTask(String description) async {
    // Get a reference to the database
    final Database db = await Controller().openDBTask();
    // Insert the task into the correct table
    await db.insert(
      'tasks',
      {'description': description},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // Close the connection to the database
    await Controller().closeDBTask();
  }
}

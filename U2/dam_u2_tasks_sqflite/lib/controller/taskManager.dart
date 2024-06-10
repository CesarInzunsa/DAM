import 'package:sqflite/sqflite.dart';
import 'package:dam_u2_tasks_sqflite/controller/controller.dart';
import 'package:dam_u2_tasks_sqflite/model/task.dart';

class TaskManager {
  /// Get all the tasks from the database
  Future<List<Task>> getTasks() async {
    // Get a reference to the database
    final Database db = await Controller().openDBTask();
    // Query the table for all the tasks
    var sql = "SELECT * FROM tasks;";
    final tasks = await db.rawQuery(sql);
    // Close the connection to the database
    await Controller().closeDBTask();
    // Convert the List<Map<String, dynamic>> into a List<Task>
    return tasks.map((task) => Task.toTask(task)).toList();
  }

  /// Add a new task to the database
  Future<void> addTask(String description) async {
    // Get a reference to the database
    final Database db = await Controller().openDBTask();
    // Insert the task into the correct table
    var sql = "INSERT INTO tasks (description) VALUES ('$description');";
    await db.rawInsert(sql);
    // Close the connection to the database
    await Controller().closeDBTask();
  }
}

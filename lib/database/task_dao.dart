import '../models/task_model.dart';
import 'database_helper.dart';

class TaskDao {
  final db = DatabaseHelper.instance;

  Future<List<TaskModel>> getTasks() async {
    final result = await (await db.database).query('tasks');
    return result.map((map) => TaskModel.fromMap(map)).toList();
  }

  Future<int> insertTask(TaskModel task) async {
    return await (await db.database).insert('tasks', task.toMap());
  }

  Future<int> updateTask(TaskModel task) async {
    return await (await db.database).update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> deleteTask(int id) async {
    return await (await db.database).delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TaskModel>> searchTasks(String query) async {
    final dbClient = await db.database;
    final result = await dbClient.query('tasks', where: 'title LIKE ? ', whereArgs: ['%$query%']);
    return result.map((map) => TaskModel.fromMap(map)).toList();
  }
}

import '../stores/task_store.dart';

class TaskController {
  final TaskStore store = TaskStore();

  void loadTasks() => store.loadTasks();
  void addTask(String title) => store.addTask(title);
  void updateTask(task) => store.updateTask(task);
  void deleteTask(int id) => store.deleteTask(id);
  void setSearchQuery(String query) => store.setSearchQuery(query);
  void applyFilter() => store.applyFilter();
}

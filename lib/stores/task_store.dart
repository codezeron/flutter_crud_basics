import 'package:flutter_application_2/database/task_dao.dart';
import 'package:mobx/mobx.dart';
import '../models/task_model.dart';

part 'task_store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  @observable
  ObservableList<TaskModel> allTasks = ObservableList<TaskModel>();

  @observable
  ObservableList<TaskModel> filteredTasks = ObservableList<TaskModel>();

  @observable
  String searchQuery = '';

  @action
  Future<void> loadTasks() async {
    final taskDao = TaskDao();
    final list = await taskDao.getTasks();
    allTasks = ObservableList.of(list);
    applyFilter();
  }

  @action
  Future<void> addTask(String title) async {
    final taskDao = TaskDao();
    final task = TaskModel(title: title);
    await taskDao.insertTask(task);
    await loadTasks();
  }

  @action
  Future<void> updateTask(TaskModel task) async {
    final taskDao = TaskDao();
    await taskDao.updateTask(task);
    await loadTasks();
  }

  @action
  Future<void> deleteTask(int id) async {
    final taskDao = TaskDao();
    await taskDao.deleteTask(id);
    await loadTasks();
  }

  @action
  void setSearchQuery(String query) {
    searchQuery = query;
    applyFilter();
  }

  @action
  void applyFilter() {
    if (searchQuery.isEmpty) {
      filteredTasks = ObservableList.of(allTasks);
    } else {
      filteredTasks = ObservableList.of(allTasks.where((task) => task.title.toLowerCase().contains(searchQuery.toLowerCase())));
    }
  }
}

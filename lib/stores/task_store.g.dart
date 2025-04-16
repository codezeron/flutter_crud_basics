// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskStore on _TaskStore, Store {
  late final _$allTasksAtom =
      Atom(name: '_TaskStore.allTasks', context: context);

  @override
  ObservableList<TaskModel> get allTasks {
    _$allTasksAtom.reportRead();
    return super.allTasks;
  }

  @override
  set allTasks(ObservableList<TaskModel> value) {
    _$allTasksAtom.reportWrite(value, super.allTasks, () {
      super.allTasks = value;
    });
  }

  late final _$filteredTasksAtom =
      Atom(name: '_TaskStore.filteredTasks', context: context);

  @override
  ObservableList<TaskModel> get filteredTasks {
    _$filteredTasksAtom.reportRead();
    return super.filteredTasks;
  }

  @override
  set filteredTasks(ObservableList<TaskModel> value) {
    _$filteredTasksAtom.reportWrite(value, super.filteredTasks, () {
      super.filteredTasks = value;
    });
  }

  late final _$searchQueryAtom =
      Atom(name: '_TaskStore.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$loadTasksAsyncAction =
      AsyncAction('_TaskStore.loadTasks', context: context);

  @override
  Future<void> loadTasks() {
    return _$loadTasksAsyncAction.run(() => super.loadTasks());
  }

  late final _$addTaskAsyncAction =
      AsyncAction('_TaskStore.addTask', context: context);

  @override
  Future<void> addTask(String title) {
    return _$addTaskAsyncAction.run(() => super.addTask(title));
  }

  late final _$updateTaskAsyncAction =
      AsyncAction('_TaskStore.updateTask', context: context);

  @override
  Future<void> updateTask(TaskModel task) {
    return _$updateTaskAsyncAction.run(() => super.updateTask(task));
  }

  late final _$deleteTaskAsyncAction =
      AsyncAction('_TaskStore.deleteTask', context: context);

  @override
  Future<void> deleteTask(int id) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(id));
  }

  late final _$_TaskStoreActionController =
      ActionController(name: '_TaskStore', context: context);

  @override
  void setSearchQuery(String query) {
    final _$actionInfo = _$_TaskStoreActionController.startAction(
        name: '_TaskStore.setSearchQuery');
    try {
      return super.setSearchQuery(query);
    } finally {
      _$_TaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void applyFilter() {
    final _$actionInfo = _$_TaskStoreActionController.startAction(
        name: '_TaskStore.applyFilter');
    try {
      return super.applyFilter();
    } finally {
      _$_TaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
allTasks: ${allTasks},
filteredTasks: ${filteredTasks},
searchQuery: ${searchQuery}
    ''';
  }
}

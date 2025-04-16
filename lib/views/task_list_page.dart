import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../controllers/task_controller.dart';
import '../models/task_model.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TaskController>();
    final store = controller.store;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: const Text('Task List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: controller.setSearchQuery,
              decoration: const InputDecoration(labelText: 'Search tasks', border: OutlineInputBorder(), prefixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: Observer(
              builder:
                  (_) =>
                      store.filteredTasks.isEmpty
                          ? const Center(child: Text('No tasks found.'))
                          : ListView.builder(
                            itemCount: store.filteredTasks.length,
                            itemBuilder: (_, index) {
                              final task = store.filteredTasks[index];
                              return TaskItem(
                                task: task,
                                onEdit: () => _showEditDialog(context, controller, task),
                                onDelete: () {
                                  if (task.id != null) {
                                    controller.deleteTask(task.id!);
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task deleted')));
                                  }
                                },
                              );
                            },
                          ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, TaskController controller, TaskModel task) {
    final TextEditingController editController = TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Edit Task'),
            content: TextField(controller: editController, decoration: const InputDecoration(labelText: 'Task title')),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  final updatedTitle = editController.text.trim();
                  if (updatedTitle.isNotEmpty) {
                    final updatedTask = TaskModel(id: task.id, title: updatedTitle);
                    controller.updateTask(updatedTask);
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task "${task.title}" updated')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task title cannot be empty')));
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskItem({super.key, required this.task, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: const Icon(Icons.edit, color: Colors.orange), onPressed: onEdit),
          IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: onDelete),
        ],
      ),
    );
  }
}

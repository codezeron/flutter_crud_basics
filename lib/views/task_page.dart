import 'package:flutter/material.dart';
import 'package:flutter_application_2/controllers/theme_notifier.dart';
import 'package:flutter_application_2/views/task_list_page.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _textController = TextEditingController();
  late TaskController controller;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<TaskController>(context, listen: false);
    controller.loadTasks();
  }

  void _editTaskDialog(TaskModel task) {
    final _editController = TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Task'),
            content: TextField(controller: _textController, decoration: const InputDecoration(labelText: 'Enter new Task Title'), autofocus: true),
            actions: [
              TextButton(child: const Text("Cancel"), onPressed: () => Navigator.of(context).pop()),
              ElevatedButton(
                onPressed: () {
                  final updatedTitle = _editController.text.trim();
                  if (updatedTitle.isNotEmpty) {
                    final updatedTask = TaskModel(id: task.id, title: updatedTitle);
                    controller.updateTask(updatedTask);
                    Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDark = themeNotifier.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          Row(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(isDark ? Icons.dark_mode : Icons.light_mode, key: ValueKey(isDark), color: isDark ? Colors.indigo : Colors.amber),
              ),
              Switch.adaptive(value: isDark, onChanged: themeNotifier.toggleTheme),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'New Task'),
              onSubmitted: (value) {
                final taskText = value.trim();
                if (taskText.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task title cannot be empty')));
                  return;
                } else if (taskText.length > 50) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task title cannot exceed 50 characters')));
                  return;
                }
                controller.addTask(value);
                _textController.clear();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task "$taskText" added')));
              },
            ),
          ),
          Expanded(
            child: Observer(
              builder:
                  (_) => ListView.builder(
                    itemCount: controller.store.allTasks.length,
                    itemBuilder: (context, index) {
                      final task = controller.store.allTasks[index];
                      return ListTile(
                        title: Text(task.title),
                        trailing: Checkbox(
                          value: task.done,
                          onChanged: (value) {
                            controller.updateTask(task.copyWith(done: value!));
                          },
                        ),
                        onTap: () => _editTaskDialog(task),
                      );
                    },
                  ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const TaskListPage()));
            },
            child: const Text('Go to List'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

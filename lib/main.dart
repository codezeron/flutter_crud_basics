import 'package:flutter/material.dart';
import 'package:flutter_application_2/controllers/task_controller.dart';
import 'package:flutter_application_2/controllers/theme_notifier.dart';
import 'package:flutter_application_2/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'views/task_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeNotifier()), Provider<TaskController>(create: (_) => TaskController())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder:
          (context, themeNotifier, child) => MaterialApp(
            title: 'Task App',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeNotifier.themeMode,
            home: TaskPage(),
            debugShowCheckedModeBanner: false,
          ),
    );
  }
}

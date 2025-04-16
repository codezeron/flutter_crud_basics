import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: Colors.grey[100],
    appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
    textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: const AppBarTheme(backgroundColor: Colors.grey, foregroundColor: Colors.white),
    textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
  );
}

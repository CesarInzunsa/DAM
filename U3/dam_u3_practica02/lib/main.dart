import 'package:flutter/material.dart';

import 'view/home_screen.dart';
import 'view/subject/add_subject_screen.dart';
import 'view/task/add_task_screen.dart';
import 'view/subject/update_subject_screen.dart';
import 'view/task/update_task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practica 02',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: {
        '/add-task': (context) => const AddTaskScreen(),
        '/add-subject': (context) => const AddSubjectScreen(),
        '/update-subject': (context) => const UpdateSubjectScreen(),
        '/update-task': (context) => const UpdateTaskScreen(),
      },
    );
  }
}

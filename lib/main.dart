import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/providers/task_provider.dart';
import 'package:task_manager_app/screens/login_screen.dart';
import 'package:task_manager_app/screens/task_list_screen.dart';
import 'package:task_manager_app/screens/task_detail_screen.dart';
import 'package:task_manager_app/utils/storage_utils.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple,
            brightness: Brightness.light,
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Task Manager App',
        home: FutureBuilder<Map<String, dynamic>?>(
          future: StorageUtil.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show a loading indicator
            } else if (snapshot.hasData && snapshot.data != null) {
              return const TaskListScreen(); // Navigate to task list screen if user is logged in
            } else {
              return const LoginScreen(); // Navigate to login screen if user is not logged in
            }
          },
        ),
        routes: {
          '/tasks': (context) => const TaskListScreen(),
          '/taskDetail': (context) => const TaskDetailScreen(),
        },
      ),
    );
  }
}

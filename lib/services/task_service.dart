import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager_app/models/task.dart';

class TaskService {
  final String _baseUrl = 'https://dummyjson.com/todos';

  Future<List<Task>> fetchTasks(int limit, int skip) async {
    final response =
        await http.get(Uri.parse('$_baseUrl?limit=$limit&skip=$skip'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Task> tasks =
          (data['todos'] as List).map((task) => Task.fromJson(task)).toList();
      return tasks;
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<Task> addTask(Task task) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'todo': task.todo,
        'completed': task.completed,
        'userId': task.userId,
      }),
    );

    if (response.statusCode == 200) {
      // The correct status code should be checked here (e.g., 201 for created).
      return Task.fromJson(jsonDecode(response.body));
    } else {
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to add task');
    }
  }

  Future<void> updateTask(Task task) async {
    print('Updating task with ID: ${task.id}'); // Debug information
    final response = await http.put(
      Uri.parse('$_baseUrl/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'completed': task.completed,
        // Include other fields to update if necessary
      }),
    );

    if (response.statusCode == 200) {
      // Optional: Log or handle successful update
      print('Update successful: ${response.body}'); // Debug information
    } else {
      print(
          'Response status code: ${response.statusCode}'); // Debug information
      print('Response body: ${response.body}'); // Debug information
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}

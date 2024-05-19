import 'package:flutter/material.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:task_manager_app/services/task_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;
  final int _limit = 10;
  int _skip = 0;
  bool _hasMore = true;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  final TaskService _taskService = TaskService();

  Future<void> fetchTasks({bool isRefresh = false}) async {
    if (isRefresh) {
      _skip = 0;
      _hasMore = true;
      _tasks = [];
    }

    if (!_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newTasks = await _taskService.fetchTasks(_limit, _skip);
      if (newTasks.isEmpty) {
        _hasMore = false; // No more items available, stop fetching
      } else {
        if (newTasks.length < _limit) {
          _hasMore = false; // Less than the limit, stop fetching
        }

        _tasks.addAll(newTasks);
        _skip += _limit;
      }
    } catch (error) {
      print('Failed to fetch tasks: $error');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    try {
      final newTask = await _taskService.addTask(task);
      _tasks.add(newTask);
      notifyListeners();
    } catch (error) {
      print('Failed to add task: $error');
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _taskService.updateTask(task);
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
        notifyListeners();
      }
    } catch (error) {
      print('Failed to update task: $error');
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await _taskService.deleteTask(id);
      _tasks.removeWhere((task) => task.id == id);
      notifyListeners();
    } catch (error) {
      print('Failed to delete task: $error');
    }
  }
}

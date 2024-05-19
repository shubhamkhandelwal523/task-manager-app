import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager_app/providers/task_provider.dart';
import 'package:task_manager_app/models/task.dart';

void main() {
  group('TaskProvider', () {
    test('Fetch tasks', () async {
      final taskProvider = TaskProvider();
      await taskProvider.fetchTasks(isRefresh: true);
      expect(taskProvider.tasks.isNotEmpty, true);
    });

    test('Add task', () async {
      final taskProvider = TaskProvider();
      final initialTaskCount = taskProvider.tasks.length;
      await taskProvider
          .addTask(Task(todo: 'Test task', completed: false, userId: 1));
      expect(taskProvider.tasks.length, initialTaskCount + 1);
    });

    test('Update task', () async {
      final taskProvider = TaskProvider();
      final taskToUpdate = taskProvider.tasks.first;
      final updatedTask = Task(
        id: taskToUpdate.id,
        todo: 'Updated task',
        completed: !taskToUpdate.completed!,
        userId: taskToUpdate.userId,
      );
      await taskProvider.updateTask(updatedTask);
      expect(taskProvider.tasks.contains(updatedTask), true);
    });

    test('Delete task', () async {
      final taskProvider = TaskProvider();
      final initialTaskCount = taskProvider.tasks.length;
      final taskToDelete = taskProvider.tasks.first;
      await taskProvider.deleteTask(taskToDelete.id!);
      expect(taskProvider.tasks.length, initialTaskCount - 1);
      expect(taskProvider.tasks.contains(taskToDelete), false);
    });

    test('Pagination', () async {
      final taskProvider = TaskProvider();
      final initialTaskCount = taskProvider.tasks.length;
      await taskProvider.fetchTasks(isRefresh: false); // Fetch more tasks
      expect(taskProvider.tasks.length, greaterThan(initialTaskCount));
    });

    test('State management', () {
      final taskProvider = TaskProvider();
      taskProvider.addListener(() {});
      taskProvider.fetchTasks(isRefresh: true);
      expect(taskProvider.isLoading, true);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:task_manager_app/providers/task_provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Text(task.id.toString() ?? ""),
          title: Text(
            task.todo!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Completed: ${task.completed.toString()}"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(context, '/taskDetail', arguments: task);
                },
              ),
              IconButton(
                icon: GestureDetector(
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  Provider.of<TaskProvider>(context, listen: false)
                      .deleteTask(task.id!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:task_manager_app/providers/task_provider.dart';

class TaskForm extends StatefulWidget {
  final Task? task;

  const TaskForm({super.key, this.task});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _todoController = TextEditingController();
  bool _completed = false;

  @override
  void initState() {
    if (widget.task != null) {
      _todoController.text = widget.task!.todo!;
      _completed = widget.task!.completed!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _todoController,
            decoration: const InputDecoration(labelText: 'To-Do'),
          ),
          CheckboxListTile(
            title: const Text('Completed'),
            value: _completed,
            onChanged: (bool? value) {
              setState(() {
                _completed = value!;
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final taskProvider =
                  Provider.of<TaskProvider>(context, listen: false);
              final task = Task(
                id: widget.task?.id,
                todo: _todoController.text,
                completed: _completed,
                userId: widget.task?.userId ??
                    5, // Assuming userId is 5 for new tasks
              );

              if (widget.task == null) {
                taskProvider.addTask(task);
              } else {
                taskProvider.updateTask(task);
              }
              Navigator.pop(context);
            },
            child: const Text('Save Task'),
          ),
        ],
      ),
    );
  }
}

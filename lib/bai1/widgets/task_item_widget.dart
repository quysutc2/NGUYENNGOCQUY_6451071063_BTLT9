import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../controllers/task_controller.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel task;
  final TaskController controller;

  const TaskItemWidget({super.key, required this.task, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        await controller.deleteTask(task.id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: CheckboxListTile(
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          value: task.isDone,
          onChanged: (bool? value) async {
            if (value != null) {
              await controller.updateTaskStatus(task.id, value);
            }
          },
          secondary: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await controller.deleteTask(task.id);
            },
          ),
        ),
      ),
    );
  }
}

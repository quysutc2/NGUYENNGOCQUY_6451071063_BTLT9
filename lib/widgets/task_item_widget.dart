import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/firestore_service.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel task;
  final FirestoreService _firestore = FirestoreService();

  TaskItemWidget({super.key, required this.task});

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
        await _firestore.deleteTask(task.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đã xóa công việc')),
          );
        }
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
              await _firestore.updateTaskStatus(task.id, value);
            }
          },
          secondary: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await _firestore.deleteTask(task.id);
            },
          ),
        ),
      ),
    );
  }
}

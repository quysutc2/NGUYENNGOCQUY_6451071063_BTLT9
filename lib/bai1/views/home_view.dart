import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../controllers/task_controller.dart';
import '../widgets/task_item_widget.dart';
import 'add_task_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final TaskController _controller = TaskController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 1: To-do List (Firestore)'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<TaskModel>>(
        stream: _controller.tasks,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Lỗi: ${snapshot.error}'));
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

          final tasks = snapshot.data ?? [];
          if (tasks.isEmpty) return const Center(child: Text('Chưa có công việc nào.'));

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) => TaskItemWidget(task: tasks[index], controller: _controller),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTaskView())),
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TaskController _controller = TaskController();
  final _formKey = GlobalKey<FormState>();
  String title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm công việc')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tiêu đề công việc'),
                validator: (val) => val!.isEmpty ? 'Vui lòng nhập tiêu đề' : null,
                onChanged: (val) => setState(() => title = val),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _controller.addTask(title);
                    if (mounted) Navigator.pop(context);
                  }
                },
                child: const Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

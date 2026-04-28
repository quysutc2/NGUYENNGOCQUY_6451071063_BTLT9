import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final AuthController _auth = AuthController();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bài 2: Đăng ký')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Nhập email' : null,
                onChanged: (val) => setState(() => email = val),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Mật khẩu'),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Nhập mật khẩu 6+ ký tự' : null,
                onChanged: (val) => setState(() => password = val),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text('Đăng ký'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await _auth.register(email, password);
                      if (mounted) Navigator.pop(context);
                    } catch (e) {
                      setState(() => error = 'Đăng ký thất bại.');
                    }
                  }
                },
              ),
              Text(error, style: const TextStyle(color: Colors.red, fontSize: 14.0)),
            ],
          ),
        ),
      ),
    );
  }
}

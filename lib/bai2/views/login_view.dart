import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController _auth = AuthController();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bài 2: Đăng nhập')),
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
                child: const Text('Đăng nhập'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await _auth.login(email, password);
                    } catch (e) {
                      setState(() => error = 'Thông tin đăng nhập không hợp lệ');
                    }
                  }
                },
              ),
              TextButton(
                child: const Text('Chưa có tài khoản? Đăng ký'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView()));
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

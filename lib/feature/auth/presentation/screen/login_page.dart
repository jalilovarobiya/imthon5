import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imthon5/core/routes/app_routes.dart';
import 'package:imthon5/feature/auth/presentation/widgets/text_form_feald_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.clear();
    _password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormFieldWidget(
                controller: _email,
                hintText: "Enter your email",
                prefixicon: Icon(
                  size: 40,
                  Icons.person_outline_rounded,
                  color: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Iltimos email kiriting";
                  }
                  return null;
                },
              ),
              TextFormFieldWidget(
                prefixicon: Icon(
                  size: 40,
                  Icons.lock_outline,
                  color: Colors.white,
                ),
                controller: _password,
                hintText: "Enter your password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Iltimos parol kiriting";
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    context.go(AppRoutes.register);
                  },
                  child: Text(
                    "Create a new account",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                  ),
                  onPressed:
                  // state is AuthLoading
                  //     ? null
                  //     :
                  () {
                    if (_formKey.currentState!.validate()) {
                      context.go(AppRoutes.main);
                    }
                  },
                  child: Text(
                    "LOG IN",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

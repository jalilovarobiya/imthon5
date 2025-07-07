import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imthon5/feature/auth/presentation/widgets/text_form_feald_widget.dart';
import 'package:imthon5/core/routes/app_routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  final _passwordConfirmation = TextEditingController();

  String? member;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _name.dispose();
    _passwordConfirmation.dispose();
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              TextFormFieldWidget(
                controller: _name,
                hintText: "Enter Your Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Iltimos ismingizni kiriting";
                  }
                  return null;
                },
              ),
              TextFormFieldWidget(
                controller: _email,
                hintText: "Enter Your Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Iltimos email kiriting";
                  }
                  return null;
                },
              ),
              TextFormFieldWidget(
                controller: _password,
                hintText: "Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Iltimos parol kiriting";
                  } else if (_password.text.length < 6) {
                    return "Parol 6 ta raqamdan kop bolsh kere";
                  }
                  return null;
                },
              ),
              TextFormFieldWidget(
                controller: _passwordConfirmation,
                hintText: "Confirm Password",
                validator: (value) {
                  if (_passwordConfirmation.text != _password.text) {
                    return "Parolni to'g'ri kiriting";
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    context.go(AppRoutes.login);
                  },
                  child: Text(
                    "Already have an account? Log in",
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.go(AppRoutes.main);
                    }
                  },
                  child: Text(
                    "Create an account",
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

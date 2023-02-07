import 'package:biometric_auth_frontend/views/register/register_body.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = "/register";

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
        ),
      ),
      body: const RegisterBody(),
    );
  }
}

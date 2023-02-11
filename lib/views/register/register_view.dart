import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/views/register/register_body.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = "register";
  static String routePath = "/register";

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).registerScreenTitle,
        ),
      ),
      body: const RegisterBody(),
    );
  }
}

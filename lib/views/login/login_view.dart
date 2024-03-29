import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/views/login/login_body.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "login";
  static String routePath = "/login";

  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).loginScreenTitle,
        ),
      ),
      body: const LoginScreenBody(),
    );
  }
}

import 'package:biometric_auth_frontend/size_config.dart';
import 'package:biometric_auth_frontend/views/login/login_body.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/login";

  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
        ),
      ),
      body: const LoginScreenBody(),
    );
  }
}

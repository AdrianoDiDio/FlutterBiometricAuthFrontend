import 'package:biometric_auth_frontend/localizations_ext.dart';
import 'package:biometric_auth_frontend/size_config.dart';
import 'package:biometric_auth_frontend/views/login/login_form.dart';
import 'package:biometric_auth_frontend/views/register/register_view.dart';
import 'package:flutter/material.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: double.infinity,
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.blockSizeVertical * 8,
              horizontal: SizeConfig.blockSizeHorizontal * 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Login",
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 8,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
                const LoginForm(),
                SizedBox(height: SizeConfig.blockSizeHorizontal * 4),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child: Text(S.of(context).registerButton)),
              ],
            ),
          )),
    );
  }
}

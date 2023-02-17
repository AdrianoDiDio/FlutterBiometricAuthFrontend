import 'package:biometric_auth_frontend/failures/error_object.dart';
import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/localizations_ext.dart';
import 'package:biometric_auth_frontend/locator.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/providers/auth_provider.dart';
import 'package:biometric_auth_frontend/retrofit/repositories/auth_repository.dart';
import 'package:biometric_auth_frontend/retrofit/responses/login_response.dart';
import 'package:biometric_auth_frontend/size_config.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:biometric_auth_frontend/views/home/home_screen_shell_view.dart';
import 'package:biometric_auth_frontend/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showPassword = false;
  String? errorMessage;
  FocusNode emailFocusNode = FocusNode();

  Future<void> submitIfValid() async {
    if (formKey.currentState!.validate()) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const Center(
                child: CircularProgressIndicator(strokeWidth: 2));
          });
      AuthRepositoryImplementation authRepository =
          AuthRepositoryImplementation();
      Either<Failure, LoginResponse> result = await authRepository
          .login(emailController.text.trim(), passwordController.text.trim())
          .whenComplete(() => context.pop());
      result.fold((l) {
        ErrorObject errorObject =
            ErrorObject.mapFailureToErrorObject(failure: l);
        logger.d("Error: ${errorObject.title} ${errorObject.message}");
        setState(() {
          errorMessage = errorObject.message;
        });
      }, (r) {
        Provider.of<AuthProvider>(context, listen: false)
            .login(r.accessToken, r.refreshToken);
        setState(() {
          errorMessage = null;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(() {
      logger.d("called");
      if (!emailFocusNode.hasFocus) {
        emailController.text = emailController.text.trim();
      }
    });
    showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
                focusNode: emailFocusNode,
                controller: emailController,
                keyboardType: TextInputType.name,
                autofillHints: const [AutofillHints.username],
                decoration: InputDecoration(
                    hintText: S.of(context).usernameHint,
                    prefixIcon: const Icon(Icons.person_rounded)),
                validator: (value) {
                  if (value == null) {
                    return S.of(context).usernameEmpty;
                  }
                  value = value.trim();
                  if (value.isEmpty) {
                    return S.of(context).usernameEmpty;
                  }
                  return null;
                },
                textInputAction: TextInputAction.next),
            SizedBox(height: SizeConfig.blockSizeVertical * 8),
            TextFormField(
              controller: passwordController,
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration(
                  hintText: S.of(context).passwordHint,
                  suffixIcon: IconButton(
                    icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                  prefixIcon: const Icon(Icons.password_rounded),
                  errorText: errorMessage,
                  errorMaxLines: 3),
              obscureText: !showPassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).passwordEmpty;
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (value) {
                submitIfValid();
              },
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 4),
            ElevatedButton(
                onPressed: () {
                  submitIfValid();
                },
                child: Text(S.of(context).loginButton)),
          ],
        ));
  }
}

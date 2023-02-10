import 'package:biometric_auth_frontend/failures/error_object.dart';
import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/localizations_ext.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/retrofit/repositories/user_repository.dart';
import 'package:biometric_auth_frontend/retrofit/responses/register_response.dart';
import 'package:biometric_auth_frontend/size_config.dart';
import 'package:biometric_auth_frontend/views/login/login_view.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? errorMessage;
  bool showPassword = false;

  Future<void> submitIfValid() async {
    if (formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
                child: CircularProgressIndicator(strokeWidth: 2));
          });
      UserRepositoryImplementation userRepository =
          UserRepositoryImplementation();
      Either<Failure, RegisterResponse> result = await userRepository
          .register(usernameController.text, emailController.text,
              passwordController.text)
          .whenComplete(() => context.pop());
      result.fold((l) {
        setState(() {
          errorMessage =
              ErrorObject.mapFailureToErrorObject(failure: l).message;
        });
      }, (r) {
        logger.d("Got ${r.user.id} ${r.user.email} ${r.user.username}");
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(S.of(context).registrationDialogTitle),
                  content: Text(
                    S.of(context).registrationDialogContent(
                        r.user.username, r.user.id, r.user.email),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          context.go(LoginScreen.routeName);
                        },
                        child: Text(S.of(context).dialogOkButton))
                  ],
                ));
        setState(() {
          errorMessage = null;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
                controller: usernameController,
                keyboardType: TextInputType.name,
                autofillHints: const [AutofillHints.username],
                decoration:
                    InputDecoration(hintText: S.of(context).usernameHint),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).usernameEmpty;
                  }
                  return null;
                },
                textInputAction: TextInputAction.next),
            SizedBox(height: SizeConfig.blockSizeVertical * 4),
            TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                decoration: InputDecoration(hintText: S.of(context).emailHint),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).emailEmpty;
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return S.of(context).invalidEmail;
                  }
                  return null;
                },
                textInputAction: TextInputAction.next),
            SizedBox(height: SizeConfig.blockSizeVertical * 4),
            TextFormField(
              controller: passwordController,
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration(
                hintText: S.of(context).passwordHint,
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).passwordEmpty;
                }
                if (value.length < 8) {
                  return S.of(context).passwordTooShort;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                submitIfValid();
              },
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 4),
            TextFormField(
              decoration: InputDecoration(
                  hintText: S.of(context).confirmPasswordHint,
                  errorText: errorMessage),
              obscureText: !showPassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).passwordEmpty;
                }
                if (value != passwordController.text) {
                  return S.of(context).passwordDoesNotMatch;
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
                child: Text(S.of(context).registerButton)),
          ],
        ));
  }
}

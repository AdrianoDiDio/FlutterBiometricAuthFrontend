import 'package:biometric_auth_frontend/views/home/home_view.dart';
import 'package:biometric_auth_frontend/views/login/login_view.dart';
import 'package:biometric_auth_frontend/views/register/register_view.dart';
import 'package:biometric_auth_frontend/views/settings/language_settings_view.dart';
import 'package:biometric_auth_frontend/views/settings/theme_settings_view.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  LanguageSettingsView.routeName: (context) => const LanguageSettingsView(),
  ThemeSettingsView.routeName: (context) => const ThemeSettingsView()
};

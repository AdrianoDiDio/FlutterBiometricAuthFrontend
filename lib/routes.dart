import 'package:biometric_auth_frontend/views/home/home_view.dart';
import 'package:biometric_auth_frontend/views/login/login_view.dart';
import 'package:biometric_auth_frontend/views/register/register_view.dart';
import 'package:biometric_auth_frontend/views/settings/biometric_settings_view.dart';
import 'package:biometric_auth_frontend/views/settings/language_settings_view.dart';
import 'package:biometric_auth_frontend/views/settings/theme_settings_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter goRouter =
    GoRouter(initialLocation: LoginScreen.routeName, routes: [
  GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen()),
  GoRoute(
      path: RegisterScreen.routeName,
      builder: (context, state) => const RegisterScreen()),
  GoRoute(
      path: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen()),
  GoRoute(
      path: LanguageSettingsView.routeName,
      builder: (context, state) => const LanguageSettingsView()),
  GoRoute(
      path: ThemeSettingsView.routeName,
      builder: (context, state) => const ThemeSettingsView()),
  GoRoute(
      path: BiometricSettingsView.routeName,
      builder: (context, state) => const BiometricSettingsView()),
]);

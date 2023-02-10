import 'package:biometric_auth_frontend/views/home/home_screen_shell_view.dart';
import 'package:biometric_auth_frontend/views/home/home_view.dart';
import 'package:biometric_auth_frontend/views/login/login_view.dart';
import 'package:biometric_auth_frontend/views/register/register_view.dart';
import 'package:biometric_auth_frontend/views/settings/biometric_settings_view.dart';
import 'package:biometric_auth_frontend/views/settings/language_settings_view.dart';
import 'package:biometric_auth_frontend/views/settings/settings_view.dart';
import 'package:biometric_auth_frontend/views/settings/theme_settings_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter goRouter = GoRouter(
    initialLocation: LoginScreen.routeName,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
          path: LoginScreen.routeName,
          builder: (context, state) => const LoginScreen()),
      GoRoute(
          path: RegisterScreen.routeName,
          builder: (context, state) => const RegisterScreen()),
      ShellRoute(
          builder: (context, state, child) => HomeScreenShellView(
                child: child,
              ),
          routes: [
            GoRoute(
                path: HomeView.routeName,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: HomeView())),
            GoRoute(
                path: SettingsView.routeName,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: SettingsView()),
                routes: [
                  GoRoute(
                      path: LanguageSettingsView.routeName,
                      builder: (context, state) =>
                          const LanguageSettingsView()),
                  GoRoute(
                      path: ThemeSettingsView.routeName,
                      builder: (context, state) => const ThemeSettingsView()),
                  GoRoute(
                      path: BiometricSettingsView.routeName,
                      builder: (context, state) =>
                          const BiometricSettingsView()),
                ])
          ])
      // GoRoute(
      //     path: HomeScreenShellView.routeName,
      //     builder: (context, state) => const HomeScreenShellView()),
    ]);

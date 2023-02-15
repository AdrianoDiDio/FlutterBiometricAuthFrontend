import 'package:biometric_auth_frontend/locator.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/providers/auth_provider.dart';
import 'package:biometric_auth_frontend/size_config.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:biometric_auth_frontend/views/home/home_screen_shell_view.dart';
import 'package:biometric_auth_frontend/views/home/home_view.dart';
import 'package:biometric_auth_frontend/views/login/login_view.dart';
import 'package:biometric_auth_frontend/views/register/register_view.dart';
import 'package:biometric_auth_frontend/views/settings/biometric_settings_view.dart';
import 'package:biometric_auth_frontend/views/settings/language_settings_view.dart';
import 'package:biometric_auth_frontend/views/settings/settings_view.dart';
import 'package:biometric_auth_frontend/views/settings/theme_settings_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainRouter {
  final AuthProvider authProvider;
  MainRouter(this.authProvider);
  late final GoRouter goRouter = GoRouter(
      initialLocation: LoginScreen.routePath,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/',
          redirect: (context, state) => HomeView.routePath,
        ),
        GoRoute(
            path: LoginScreen.routePath,
            name: LoginScreen.routeName,
            builder: (context, state) => const LoginScreen()),
        GoRoute(
            path: RegisterScreen.routePath,
            name: RegisterScreen.routeName,
            builder: (context, state) => const RegisterScreen()),
        ShellRoute(
            builder: (context, state, child) => HomeScreenShellView(
                  child: child,
                ),
            routes: [
              GoRoute(
                  path: HomeView.routePath,
                  name: HomeView.routeName,
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: HomeView())),
              GoRoute(
                  path: SettingsView.routePath,
                  name: SettingsView.routeName,
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: SettingsView()),
                  routes: [
                    GoRoute(
                        path: LanguageSettingsView.routePath,
                        name: LanguageSettingsView.routeName,
                        builder: (context, state) =>
                            const LanguageSettingsView()),
                    GoRoute(
                        path: ThemeSettingsView.routePath,
                        name: ThemeSettingsView.routeName,
                        builder: (context, state) => const ThemeSettingsView()),
                    GoRoute(
                        path: BiometricSettingsView.routePath,
                        name: BiometricSettingsView.routeName,
                        builder: (context, state) =>
                            const BiometricSettingsView()),
                  ])
            ])
      ],
      redirect: (context, state) async {
        final loggingIn = state.subloc == LoginScreen.routePath;
        final isInRegisterScreen = state.subloc == RegisterScreen.routePath;
        final loggedIn = authProvider.isLoggedIn;
        //NOTE(Adriano): Redirect to login only if we have an invalid token and we
        //               are not trying to register a new user.
        if (!loggedIn && !loggingIn && !isInRegisterScreen) {
          return LoginScreen.routePath;
        }
        //NOTE(Adriano): If we have a valid token then we can skip the login screen.
        if (loggedIn && (loggingIn || isInRegisterScreen)) {
          return HomeView.routePath;
        }
        logger.d("All fine i'm where I should be");
        return null;
      },
      refreshListenable: authProvider);
}

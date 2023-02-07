import 'package:biometric_auth_frontend/locator.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/providers/theme_provider.dart';
import 'package:biometric_auth_frontend/routes.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:biometric_auth_frontend/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    hide ChangeNotifierProvider, Consumer;
import 'generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

void main() {
  setUpLazySingletons();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        lazy: false,
        create: (_) => ThemeProvider(),
        child: Consumer(builder: (context, ThemeProvider themeNotifier, child) {
          return MaterialApp(
            title: 'Biometric Auth Frontend',
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.blue,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(brightness: Brightness.dark),
            themeMode: themeNotifier.themeMode,
            debugShowCheckedModeBanner: false,
            routes: routes,
            initialRoute: LoginScreen.routeName,
            localizationsDelegates: const [
              LocaleNamesLocalizationsDelegate(),
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
          );
        }));
  }
}

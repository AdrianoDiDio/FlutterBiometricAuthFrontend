import 'package:biometric_auth_frontend/locator.dart';
import 'package:biometric_auth_frontend/providers/auth_provider.dart';
import 'package:biometric_auth_frontend/providers/biometric_provider.dart';
import 'package:biometric_auth_frontend/providers/language_provider.dart';
import 'package:biometric_auth_frontend/providers/theme_provider.dart';
import 'package:biometric_auth_frontend/routes.dart';
import 'package:biometric_auth_frontend/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    hide ChangeNotifierProvider, Consumer, Provider;
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLazySingletons();
  SizeConfig().init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider = AuthProvider();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => ThemeProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => LanguageProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => authProvider),
        ChangeNotifierProvider(lazy: false, create: (_) => BiometricProvider()),
        Provider<MainRouterProvider>(
          lazy: false,
          create: (BuildContext createContext) =>
              MainRouterProvider(authProvider),
        ),
      ],
      child: Consumer4(builder: (context,
          ThemeProvider themeProvider,
          LanguageProvider languageProvider,
          AuthProvider authProvider,
          MainRouterProvider mainRouterProvider,
          child) {
        return MaterialApp.router(
          title: 'Biometric Auth Frontend',
          routerConfig: mainRouterProvider.goRouter,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.blue,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
              brightness: Brightness.dark,
              useMaterial3: true,
              colorSchemeSeed: Colors.blue),
          themeMode: themeProvider.themeMode,
          locale: languageProvider.locale,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            LocaleNamesLocalizationsDelegate(),
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      }),
    );
  }
}

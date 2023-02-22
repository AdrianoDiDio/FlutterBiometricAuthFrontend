import 'dart:io';

import 'package:biometric_auth_frontend/biometrics/biometric_utils.dart';
import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/locator.dart';
import 'package:biometric_auth_frontend/providers/theme_provider.dart';
import 'package:biometric_auth_frontend/views/settings/biometric_settings_view.dart';
import 'package:biometric_auth_frontend/views/settings/language_settings_view.dart';
import 'package:biometric_auth_frontend/views/settings/theme_settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsView extends StatelessWidget {
  static String routeName = "settings";
  static String routePath = "/home/settings";

  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).settingsScreenTitle,
          ),
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
                title: Text(S.of(context).settingsScreenCommonEntry),
                tiles: [
                  SettingsTile.navigation(
                    leading: const Icon(Icons.language_rounded),
                    title: Text(S.of(context).settingsScreenLanguageEntry),
                    value: Text(LocaleNames.of(context)!
                        .nameOf(Localizations.localeOf(context).toString())
                        .toString()),
                    onPressed: (context) {
                      context.pushNamed(LanguageSettingsView.routeName);
                    },
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.format_paint_rounded),
                    title: Text(S.of(context).settingsScreenThemeEntry),
                    value:
                        Text(Provider.of<ThemeProvider>(context).themeModeName),
                    onPressed: (context) {
                      context.pushNamed(ThemeSettingsView.routeName);
                    },
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.lock),
                    enabled: serviceLocator
                        .get<FlutterBiometricsImplementation>()
                        .biometricSupported,
                    title: Text(S.of(context).settingsScreenBiometricEntry),
                    onPressed: (context) {
                      context.pushNamed(BiometricSettingsView.routeName);
                    },
                  )
                ])
          ],
        ));
  }
}

import 'dart:io';

import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/providers/theme_provider.dart';
import 'package:biometric_auth_frontend/views/settings/language_settings_view.dart';
import 'package:biometric_auth_frontend/views/settings/theme_settings_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsList(
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
                  Navigator.pushNamed(context, LanguageSettingsView.routeName);
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.format_paint_rounded),
                title: Text(S.of(context).settingsScreenThemeEntry),
                value: Text(Provider.of<ThemeProvider>(context).themeModeName),
                onPressed: (context) {
                  Navigator.pushNamed(context, ThemeSettingsView.routeName);
                },
              )
            ])
      ],
    );
  }
}

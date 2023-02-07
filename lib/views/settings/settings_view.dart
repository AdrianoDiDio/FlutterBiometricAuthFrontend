import 'dart:io';

import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/views/settings/language_setting_view.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(title: Text("Common"), tiles: [
          SettingsTile.navigation(
            leading: Icon(Icons.language),
            title: Text("Language"),
            value: Text(LocaleNames.of(context)!
                .nameOf(Localizations.localeOf(context).toString())
                .toString()),
            onPressed: (context) {
              Navigator.pushNamed(context, LanguageSettingsView.routeName);
            },
          ),
          SettingsTile.navigation(title: Text("Theme"))
        ])
      ],
    );
  }
}

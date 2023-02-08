import 'package:biometric_auth_frontend/extensions/string_extension.dart';
import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/main.dart';
import 'package:biometric_auth_frontend/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:provider/provider.dart';

class LanguageSettingsView extends StatefulWidget {
  static String routeName = "/settings/language";

  const LanguageSettingsView({super.key});

  @override
  State<StatefulWidget> createState() {
    return LanguageSettingsViewState();
  }
}

class LanguageSettingsViewState extends State<LanguageSettingsView> {
  String? _selectedLanguage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).settingsScreenLanguageEntry),
        ),
        body: SafeArea(child: Column(children: _initLanguageTiles())));
  }

  List<Widget> _initLanguageTiles() {
    List<Widget> radioTiles = [];
    _selectedLanguage ??= Localizations.localeOf(context).languageCode;
    for (var element in S.delegate.supportedLocales) {
      logger.d(element.languageCode);
      radioTiles.add(RadioListTile(
          value: element.languageCode,
          groupValue: _selectedLanguage,
          controlAffinity: ListTileControlAffinity.trailing,
          title: Text(LocaleNames.of(context)!
              .nameOf(element.languageCode)
              .toString()
              .capitalize()),
          onChanged: (value) {
            logger.d("onChanged $value");
            Provider.of<LanguageProvider>(context, listen: false).locale =
                Locale(value!);
            setState(() {
              _selectedLanguage = value;
            });
          }));
    }
    return radioTiles;
  }
}

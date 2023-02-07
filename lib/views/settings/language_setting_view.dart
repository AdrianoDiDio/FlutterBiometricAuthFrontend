import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

class LanguageSettingsView extends StatefulWidget {
  static String routeName = "/settings/language";

  const LanguageSettingsView({super.key});

  @override
  State<StatefulWidget> createState() {
    return LanguageSettingsViewState();
  }
}

class LanguageSettingsViewState extends State<LanguageSettingsView> {
  String _selectedLanguage = "";
  @override
  void initState() {
    super.initState();
    logger.d("Init locale list...");
    logger.d(S.delegate.supportedLocales);
    Future.delayed(Duration.zero, () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Language"),
        ),
        body: SafeArea(child: Column(children: _initLanguageTiles())));
  }

  List<Widget> _initLanguageTiles() {
    List<Widget> radioTiles = [];
    _selectedLanguage = Localizations.localeOf(context).toString();
    for (var element in S.delegate.supportedLocales) {
      radioTiles.add(RadioListTile(
          value: _selectedLanguage,
          groupValue: element.languageCode,
          title: Text(
              LocaleNames.of(context)!.nameOf(element.languageCode).toString()),
          onChanged: (value) {}));
    }
    return radioTiles;
  }
}

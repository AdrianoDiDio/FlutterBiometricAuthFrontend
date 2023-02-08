import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSettingsView extends StatefulWidget {
  static String routeName = "/settings/theme";

  const ThemeSettingsView({super.key});

  @override
  State<StatefulWidget> createState() {
    return ThemeSettingsViewState();
  }
}

class ThemeSettingsViewState extends State<ThemeSettingsView> {
  String? _selectedThemeMode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).settingsScreenThemeEntry),
        ),
        body: SafeArea(child: Column(children: _initThemeTiles())));
  }

  List<Widget> _initThemeTiles() {
    List<Widget> radioTiles = [];
    _selectedThemeMode ??= Provider.of<ThemeProvider>(context).themeMode.name;
    for (var element in ThemeMode.values) {
      radioTiles.add(RadioListTile(
          value: element.name,
          groupValue: _selectedThemeMode,
          controlAffinity: ListTileControlAffinity.trailing,
          title: Text(ThemeProvider.themModeToName(element)),
          onChanged: (value) {
            ThemeMode themeMode = ThemeMode.values.byName(value!);
            Provider.of<ThemeProvider>(context, listen: false).themeMode =
                themeMode;
            setState(() {
              _selectedThemeMode = value;
            });
          }));
    }
    return radioTiles;
  }
}

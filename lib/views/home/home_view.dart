import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/views/home/home_body.dart';
import 'package:biometric_auth_frontend/views/settings/settings_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

/*
  TODO:
  Setting Screen using settings_ui

  Language    => Open a new window containing the available languages
  Theme       => Open a new window containing three radio buttons (System,Light,Dark).

  System UI => Add two navigation tiles.
 */
class HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;
  String _currentPageTitle = S.current.homeScreenTitle;
  static final Map<String, Widget> _pages = {
    S.current.homeScreenTitle: const HomeBody(),
    S.current.settingsScreenTitle: const SettingsView()
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentPageTitle,
        ),
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pages.values.toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.person_rounded),
                label: S.of(context).homeScreenUserInfoEntry),
            BottomNavigationBarItem(
                icon: const Icon(Icons.settings_rounded),
                label: S.of(context).homeScreenSettingsEntry)
          ]),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
      _currentPageTitle = _pages.keys.elementAt(index);
    });
  }
}

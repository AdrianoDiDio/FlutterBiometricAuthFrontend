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
  String _currentPageTitle = "User Info";
  static final Map<String, Widget> _pages = {
    "User Info": HomeBody(),
    "Settings": SettingsView()
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
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded), label: "User"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded), label: "Settings")
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

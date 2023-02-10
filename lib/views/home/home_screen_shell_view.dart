import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/views/home/home_screen_item.dart';
import 'package:biometric_auth_frontend/views/home/home_view.dart';
import 'package:biometric_auth_frontend/views/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreenShellView extends StatefulWidget {
  final Widget child;

  const HomeScreenShellView({super.key, required this.child});

  @override
  State<StatefulWidget> createState() {
    return HomeScreenShellViewState();
  }
}

class HomeScreenShellViewState extends State<HomeScreenShellView> {
  int _currentPageIndex = 0;
  String _currentPageTitle = S.current.homeScreenTitle;
  static final List<HomeScreenItem> _pages = [
    HomeScreenItem(
        title: S.current.homeScreenTitle,
        widget: const HomeView(),
        route: HomeView.routeName),
    HomeScreenItem(
        title: S.current.settingsScreenTitle,
        widget: const SettingsView(),
        route: SettingsView.routeName),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentPageTitle,
        ),
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          onTap: (value) => _onItemTapped(context, value),
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

  void _onItemTapped(BuildContext context, int index) {
    setState(() {
      _currentPageIndex = index;
      _currentPageTitle = _pages.elementAt(index).title;
    });
    logger.d("Going to ${_pages.elementAt(index).route}");
    context.push(_pages.elementAt(index).route);
  }
}

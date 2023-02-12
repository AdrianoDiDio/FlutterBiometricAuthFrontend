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
  static final List<HomeScreenItem> _pages = [
    HomeScreenItem(
        widget: const HomeView(),
        routeName: HomeView.routeName,
        bottomNavigationBarItem: BottomNavigationBarItem(
            icon: const Icon(Icons.person_rounded),
            label: S.current.homeScreenUserInfoEntry)),
    HomeScreenItem(
        widget: const SettingsView(),
        routeName: SettingsView.routeName,
        bottomNavigationBarItem: BottomNavigationBarItem(
            icon: const Icon(Icons.settings_rounded),
            label: S.current.homeScreenSettingsEntry)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          onTap: (value) => _onItemTapped(context, value),
          items: _pages.map((e) => e.bottomNavigationBarItem).toList()),
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    if (index == _currentPageIndex) {
      return;
    }
    setState(() {
      _currentPageIndex = index;
    });
    logger.d("Going to ${_pages.elementAt(index).routeName}");
    //NOTE(Adriano): We need to use go since we don't want to push it onto the
    // stack...however we need a way to preserve the state of the page because
    // right now every time we tap on a item it will cause a rebuild.
    // Issue tracking: https://github.com/flutter/flutter/issues/99124
    context.goNamed(_pages.elementAt(index).routeName);
  }
}

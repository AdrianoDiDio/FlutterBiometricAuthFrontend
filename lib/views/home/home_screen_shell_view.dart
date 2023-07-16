import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/providers/language_provider.dart';
import 'package:biometric_auth_frontend/views/home/home_screen_item.dart';
import 'package:biometric_auth_frontend/views/home/home_view.dart';
import 'package:biometric_auth_frontend/views/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreenShellView extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const HomeScreenShellView({super.key, required this.navigationShell});

  @override
  State<StatefulWidget> createState() {
    return HomeScreenShellViewState();
  }
}

class HomeScreenShellViewState extends State<HomeScreenShellView> {
  List<HomeScreenItem> _pages = [
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
            label: S.current.homeScreenSettingsEntry))
  ];
  late LanguageProvider _languageProvider;
  @override
  void initState() {
    super.initState();

    _languageProvider = context.read<LanguageProvider>();

    _languageProvider.addListener(_onLanguageChange);
  }

  bool _localeDirty = false;
  @override
  void dispose() {
    super.dispose();
    _languageProvider.removeListener(_onLanguageChange);
  }

  void _onLanguageChange() {
    _localeDirty = true;
  }

  @override
  Widget build(BuildContext context) {
    if (_localeDirty) {
      _pages = [
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
                label: S.current.homeScreenSettingsEntry))
      ];
      _localeDirty = false;
    }
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.navigationShell.currentIndex,
          onTap: (value) => _onItemTapped(context, value),
          items: _pages.map((e) => e.bottomNavigationBarItem).toList()),
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    logger.d("Going to ${_pages.elementAt(index).routeName}");
    widget.navigationShell.goBranch(index,initialLocation:index ==
        widget.navigationShell.currentIndex,);
  }
}

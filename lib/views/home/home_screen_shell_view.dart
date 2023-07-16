import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreenShellView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomeScreenShellView({super.key, required this.navigationShell});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (value) => _onItemTapped(context, value),
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.person_rounded),
              label: S.of(context).homeScreenUserInfoEntry),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings_rounded),
              label: S.of(context).homeScreenSettingsEntry)
        ],
    ));
  }

  void _onItemTapped(BuildContext context, int index) {
    logger.d("Going to ${navigationShell.route.branches[index].toString()}");
    navigationShell.goBranch(index,initialLocation:index == navigationShell.currentIndex);
  }
}

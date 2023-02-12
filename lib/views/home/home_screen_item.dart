import 'package:flutter/material.dart';

class HomeScreenItem {
  Widget widget;
  String routeName;
  BottomNavigationBarItem bottomNavigationBarItem;

  HomeScreenItem(
      {required this.widget,
      required this.routeName,
      required this.bottomNavigationBarItem});
}

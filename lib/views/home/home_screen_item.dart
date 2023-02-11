import 'package:flutter/material.dart';

class HomeScreenItem {
  String title;
  Widget widget;
  String routeName;

  HomeScreenItem(
      {required this.title, required this.widget, required this.routeName});
}

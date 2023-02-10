import 'package:flutter/material.dart';

class HomeScreenItem {
  String title;
  Widget widget;
  String route;

  HomeScreenItem(
      {required this.title, required this.widget, required this.route});
}

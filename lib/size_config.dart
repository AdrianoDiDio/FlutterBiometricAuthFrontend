import 'dart:ui';

import 'package:biometric_auth_frontend/logger.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static Future<void> ensureScreenSize([WidgetsBinding? binding]) async {
    if (window.viewConfiguration.geometry.isEmpty) {
      return Future.delayed(const Duration(milliseconds: 10), () async {
        binding!.deferFirstFrame();
        await ensureScreenSize(binding);
        return binding.allowFirstFrame();
      });
    }
  }

  void init() {
    var logicalScreenSize = WidgetsBinding.instance.window.physicalSize /
        WidgetsBinding.instance.window.devicePixelRatio;
    screenWidth = logicalScreenSize.width;
    screenHeight = logicalScreenSize.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    logger.d("screenWidth: $screenWidth screenHeight: $screenHeight");
    logger.d(
        "blockSizeHorizontal: $blockSizeHorizontal blockSizeVertical: $blockSizeVertical");
  }
}

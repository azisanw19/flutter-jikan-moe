import 'package:anime_list/src/utils/error/window_size_class_exception.dart';
import 'package:anime_list/src/utils/windowSize/window_class.dart';
import 'package:flutter/material.dart';

class WindowSizeClass {
  final BuildContext context;

  WindowSizeClass(this.context);

  WindowClass get getWindowClass {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return WindowClass.Compact;
    }
    else if (width >= 600 && width < 840) {
      return WindowClass.Medium;
    }
    else if (width >= 840) {
      return WindowClass.Expanded;
    }
    
    throw WindowSizeClassException('This Should Never Happened');
  }
}
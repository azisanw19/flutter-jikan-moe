import 'package:anime_list/src/utils/error/window_size_class_exception.dart';
import 'package:anime_list/src/utils/window_size/window_class.dart';
import 'package:flutter/material.dart';

class WindowSizeClass {
  final BuildContext context;

  WindowSizeClass(this.context);

  WindowClass get windowClass {
    double width = MediaQuery.of(context).size.width;
    return windowSizeClass(width);
  }

  WindowClass windowSizeClass(double width) {
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
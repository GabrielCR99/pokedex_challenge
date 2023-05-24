import 'package:flutter/material.dart';

import '../extensions/as_html_color_to_color.dart';

final class AppColors {
  static AppColors? _instance;

  AppColors._();

  static AppColors get instance {
    _instance ??= AppColors._();

    return _instance!;
  }

  Color get primaryColor => '#DC0A2D'.htmlColorToColor();

  Color get grayscaleDark => '#212121'.htmlColorToColor();
  Color get grayscaleMedium => '#666666'.htmlColorToColor();
  Color get grayscaleLight => '#E0E0E0'.htmlColorToColor();
  Color get grayscaleBackground => '#EFEFEF'.htmlColorToColor();
  Color get grayscaleWhite => '#FFFFFF'.htmlColorToColor();
}

extension AppColorsExtension on BuildContext {
  AppColors get appColors => AppColors.instance;
}

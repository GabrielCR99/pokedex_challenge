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

  Color get bugTypeColor => '#A7B723'.htmlColorToColor();
  Color get darkTypeColor => '#75574C'.htmlColorToColor();
  Color get dragonTypeColor => '#7037FF'.htmlColorToColor();
  Color get electricTypeColor => '#F9CF30'.htmlColorToColor();
  Color get fairyTypeColor => '#E69EAC'.htmlColorToColor();
  Color get fightingTypeColor => '#C12239'.htmlColorToColor();
  Color get fireTypeColor => '#F57D31'.htmlColorToColor();
  Color get flyingTypeColor => '#A891EC'.htmlColorToColor();
  Color get ghostTypeColor => '#70559B'.htmlColorToColor();
  Color get normalTypeColor => '#AAA67F'.htmlColorToColor();
  Color get grassTypeColor => '#74CB48'.htmlColorToColor();
  Color get groundTypeColor => '#DEC16B'.htmlColorToColor();
  Color get iceTypeColor => '#9AD6DF'.htmlColorToColor();
  Color get poisonTypeColor => '#A43E9E'.htmlColorToColor();
  Color get psychicTypeColor => '#FB5584'.htmlColorToColor();
  Color get rockTypeColor => '#B69E31'.htmlColorToColor();
  Color get steelTypeColor => '#B7B9D0'.htmlColorToColor();
  Color get waterTypeColor => '#6493EB'.htmlColorToColor();
}

extension AppColorsExtension on BuildContext {
  AppColors get appColors => AppColors.instance;
}

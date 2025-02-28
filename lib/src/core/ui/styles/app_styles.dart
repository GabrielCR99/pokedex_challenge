import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'text_styles.dart';

final class AppStyles {
  static AppStyles? _instance;
  AppStyles._();

  static AppStyles get instance {
    _instance ??= AppStyles._();

    return _instance!;
  }

  ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: AppColors.instance.primaryColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(7)),
    ),
    textStyle: TextStyles.i.textButtonLabel,
    foregroundColor: Colors.white,
  );
}

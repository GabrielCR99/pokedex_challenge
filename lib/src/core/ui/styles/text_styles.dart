import 'package:flutter/material.dart';

final class TextStyles {
  static TextStyles? _instance;

  TextStyles._();

  static TextStyles get i {
    _instance ??= TextStyles._();

    return _instance!;
  }

  String get _fontFamily => 'Poppins';

  TextStyle get textRegular =>
      TextStyle(fontWeight: FontWeight.w400, fontFamily: _fontFamily);
  TextStyle get textMedium =>
      TextStyle(fontWeight: FontWeight.w500, fontFamily: _fontFamily);
  TextStyle get textSemiBold =>
      TextStyle(fontWeight: FontWeight.w600, fontFamily: _fontFamily);
  TextStyle get textBold =>
      TextStyle(fontWeight: FontWeight.bold, fontFamily: _fontFamily);

  TextStyle get textButtonLabel => textBold.copyWith(fontSize: 14);
}

extension TextStylesExtension on BuildContext {
  TextStyles get textStyles => TextStyles.i;
}

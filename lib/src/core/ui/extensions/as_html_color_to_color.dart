import 'package:flutter/material.dart';

import 'remove_all.dart';

extension AsHtmlColorToColor on String {
  /// Returns the color represented by this string.
  ///
  /// The string must be in the format of a standard HTML color code. For
  /// example: '#ff00ff'.
  Color htmlColorToColor() =>
      Color(int.parse(removeAll(['0x', '#']).padLeft(8, 'FF'), radix: 16));
}

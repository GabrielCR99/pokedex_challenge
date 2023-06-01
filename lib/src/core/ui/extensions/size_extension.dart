import 'package:flutter/cupertino.dart';

extension SizeExtension on BuildContext {
  Size get _size => MediaQuery.sizeOf(this);

  double get width => _size.width;
  double get height => _size.height;
  double get shortestSide => _size.shortestSide;
  double get longestSide => _size.longestSide;

  double percentWidth(double percent) {
    assert(
      percent >= 0.0 && percent <= 1,
      'Percent must be between 0.0 and 1.0',
    );

    return width * percent;
  }

  double percentHeight(double percent) {
    assert(
      percent >= 0.0 && percent <= 1,
      'Percent must be between 0.0 and 1.0',
    );

    return height * percent;
  }
}

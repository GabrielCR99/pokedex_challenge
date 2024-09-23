import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(
    this.path, {
    this.colorFilter,
    this.width,
    this.height,
    super.key,
  });

  final String path;
  final ColorFilter? colorFilter;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter: colorFilter,
    );
  }
}

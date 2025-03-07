import 'dart:math';

import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import 'svg_icon.dart';

final class SpinningPokeballAnimation extends StatefulWidget {
  const SpinningPokeballAnimation({super.key});

  @override
  State<SpinningPokeballAnimation> createState() =>
      _SpinningPokeballAnimationState();
}

final class _SpinningPokeballAnimationState
    extends State<SpinningPokeballAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..forward()
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.repeat();
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder:
          (_, child) =>
              Transform.rotate(angle: _controller.value * 2 * pi, child: child),
      child: SvgIcon(
        'assets/images/pokeball.svg',
        width: 208,
        height: 208,
        colorFilter: ColorFilter.mode(
          context.appColors.primaryColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

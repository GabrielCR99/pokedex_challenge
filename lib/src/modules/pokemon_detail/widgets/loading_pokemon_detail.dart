import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';

class LoadingPokemonDetail extends StatefulWidget {
  const LoadingPokemonDetail({super.key});

  @override
  State<LoadingPokemonDetail> createState() => _LoadingPokemonDetailState();
}

class _LoadingPokemonDetailState extends State<LoadingPokemonDetail>
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (_, child) => Transform.rotate(
                angle: _controller.value * 2 * 3.14,
                child: child,
              ),
              child: SvgPicture.asset(
                'assets/images/pokeball.svg',
                width: 208,
                height: 208,
                colorFilter: ColorFilter.mode(
                  context.appColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Loading Pokémon',
              style: context.textStyles.textRegular.copyWith(
                color: context.appColors.grayscaleDark,
                fontSize: 24,
              ),
            ),
          ],
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

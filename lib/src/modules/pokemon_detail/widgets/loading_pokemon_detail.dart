import 'package:flutter/material.dart';

import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../core/ui/widgets/spinning_pokeball_animation.dart';

final class LoadingPokemonDetail extends StatelessWidget {
  const LoadingPokemonDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinningPokeballAnimation(),
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
}

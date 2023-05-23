import 'package:flutter/material.dart';

import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';

class PokemonTypeChip extends StatelessWidget {
  const PokemonTypeChip({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(
          'Fire',
          style: context.textStyles.textBold
              .copyWith(fontSize: 10, color: context.appColors.grayscaleWhite),
        ),
      ),
    );
  }
}

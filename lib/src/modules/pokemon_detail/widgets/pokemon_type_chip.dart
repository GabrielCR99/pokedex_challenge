import 'package:flutter/material.dart';

import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';

final class PokemonTypeChip extends StatelessWidget {
  final String type;
  final Color color;

  const PokemonTypeChip({required this.type, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(
          type,
          style: context.textStyles.textBold
              .copyWith(fontSize: 10, color: context.appColors.grayscaleWhite),
        ),
      ),
    );
  }
}

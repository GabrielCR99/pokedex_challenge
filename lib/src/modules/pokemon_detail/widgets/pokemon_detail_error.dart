import 'package:flutter/material.dart';

import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';

class PokemonDetailError extends StatelessWidget {
  final String? errorMessage;

  const PokemonDetailError({this.errorMessage, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage ?? 'Internal error',
        style: context.textStyles.textBold
            .copyWith(color: context.appColors.grayscaleDark),
      ),
    );
  }
}

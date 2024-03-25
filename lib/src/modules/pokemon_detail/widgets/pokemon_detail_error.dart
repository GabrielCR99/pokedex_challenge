import 'package:flutter/material.dart';

import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';

final class PokemonDetailError extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onRetry;

  const PokemonDetailError({
    required this.onRetry,
    this.errorMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage ?? 'Internal error',
              style: context.textStyles.textBold
                  .copyWith(color: context.appColors.grayscaleDark),
            ),
            const SizedBox(height: 8),
            TextButton(
              key: const Key('retry_button'),
              onPressed: onRetry,
              child: Text(
                'Retry',
                style: context.textStyles.textBold
                    .copyWith(color: context.appColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

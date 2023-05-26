import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';

class PokemonAttributeInfo extends StatelessWidget {
  final String name;
  final String assetName;
  final String postFix;
  final double value;
  final bool rotate;

  const PokemonAttributeInfo({
    required this.name,
    required this.assetName,
    required this.postFix,
    required this.value,
    this.rotate = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Transform.rotate(
              angle: rotate ? pi / 2 : 0,
              child: SvgPicture.asset(
                'assets/images/icons/$assetName.svg',
                width: 16,
                height: 16,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${value.toStringAsFixed(1).replaceAll('.', ',')} $postFix',
              style: context.textStyles.textRegular.copyWith(
                fontSize: 10,
                color: context.appColors.grayscaleDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: context.textStyles.textRegular.copyWith(
            fontSize: 8,
            color: context.appColors.grayscaleMedium,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

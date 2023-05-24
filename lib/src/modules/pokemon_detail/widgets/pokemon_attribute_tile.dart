import 'package:flutter/material.dart';

import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../models/pokemon_detail.dart';
import 'pokemon_attribute_info.dart';

class PokemonAttributeTile extends StatelessWidget {
  final PokemonDetail pokemonDetail;

  const PokemonAttributeTile({required this.pokemonDetail, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PokemonAttributeInfo(
          name: 'Weight',
          assetName: 'weight',
          value: pokemonDetail.weight,
        ),
        SizedBox(
          height: 48,
          child: VerticalDivider(
            width: 1,
            color: context.appColors.grayscaleLight,
          ),
        ),
        PokemonAttributeInfo(
          name: 'Height',
          assetName: 'straighten',
          value: pokemonDetail.height,
          rotate: true,
        ),
        SizedBox(
          height: 48,
          child: VerticalDivider(
            width: 1,
            color: context.appColors.grayscaleLight,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                pokemonDetail.abilities.join('\n').split('-').join(' '),
                style: context.textStyles.textRegular.copyWith(
                  fontSize: 10,
                  color: context.appColors.grayscaleDark,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Moves',
              style: context.textStyles.textRegular.copyWith(
                fontSize: 8,
                color: context.appColors.grayscaleMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

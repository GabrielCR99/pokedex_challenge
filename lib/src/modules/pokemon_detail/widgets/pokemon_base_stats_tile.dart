import 'package:flutter/material.dart';

import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../models/pokemon_detail.dart';

class PokemonBaseStatsTile extends StatelessWidget {
  final PokemonDetail pokemonDetail;

  const PokemonBaseStatsTile({required this.pokemonDetail, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: pokemonDetail.stats
              .map(
                (stat) => Text(
                  stat.name.toUpperCase().replaceAll('-', ' '),
                  style: context.textStyles.textRegular.copyWith(
                    fontSize: 10,
                    color: context.appColors.grayscaleDark,
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: 96,
          child: VerticalDivider(
            width: 1,
            color: context.appColors.grayscaleLight,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: pokemonDetail.stats
              .map(
                (stat) => Text(
                  stat.value.toString(),
                  style: context.textStyles.textRegular.copyWith(
                    fontSize: 10,
                    color: context.appColors.grayscaleDark,
                  ),
                ),
              )
              .toList(),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: pokemonDetail.stats
                .map(
                  (stat) => Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: LinearProgressIndicator(
                      value: stat.value / 100,
                      backgroundColor: context.appColors.grayscaleLight,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        context.appColors.primaryColor,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

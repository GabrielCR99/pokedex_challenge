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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: pokemonDetail.stats
              .map(
                (stat) => Text(
                  stat.name.toUpperCase().replaceAll('-', ' '),
                  style: context.textStyles.textBold.copyWith(
                    fontSize: 10,
                    color: pokemonDetail.types.first.color,
                  ),
                ),
              )
              .toList(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            height: 96,
            child: VerticalDivider(
              width: 1,
              color: context.appColors.grayscaleLight,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: pokemonDetail.stats
              .map(
                (stat) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    stat.value.toString().padLeft(3, '0'),
                    style: context.textStyles.textRegular.copyWith(
                      fontSize: 10,
                      color: context.appColors.grayscaleDark,
                    ),
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
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      child: LinearProgressIndicator(
                        value: stat.value / 100,
                        backgroundColor: context.appColors.grayscaleLight,
                        valueColor: AlwaysStoppedAnimation(
                          pokemonDetail.types.first.color,
                        ),
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

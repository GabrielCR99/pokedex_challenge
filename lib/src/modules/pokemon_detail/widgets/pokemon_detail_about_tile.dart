import 'package:flutter/material.dart';

import '../../../adapters/pokemon_detail_adapter.dart';
import '../../../core/ui/extensions/screen_size_extension.dart';
import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../models/pokemon_detail.dart';
import '../../../models/pokemon_type.dart';
import 'pokemon_attribute_tile.dart';

class PokemonDetailAboutTile extends StatelessWidget {
  const PokemonDetailAboutTile({required this.pokemonDetail, super.key});

  final PokemonDetail pokemonDetail;

  @override
  Widget build(BuildContext context) {
    final PokemonDetailAdapter(
      types: Iterable(first: PokemonType(:color)),
      :stats,
      :sanitizedDescription,
    ) = pokemonDetail as PokemonDetailAdapter;

    return Expanded(
      child: ListView(
        children: [
          Text(
            'About',
            style: context.textStyles.textBold.copyWith(
              fontSize: 14.sp,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          PokemonAttributeTile(pokemonDetail: pokemonDetail),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Text(
                sanitizedDescription,
                style: context.textStyles.textRegular.copyWith(
                  fontSize: 10.sp,
                  color: context.appColors.grayscaleDark,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Text(
            'Base stats',
            style: context.textStyles.textBold.copyWith(
              fontSize: 14.sp,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          for (final stat in stats)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      stat.name.toUpperCase().replaceAll('-', ' '),
                      style: context.textStyles.textBold.copyWith(
                        fontSize: 10,
                        color: color,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  VerticalDivider(color: context.appColors.primaryColor),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        stat.value.toString().padLeft(3, '0'),
                        style: context.textStyles.textRegular.copyWith(
                          fontSize: 10,
                          color: context.appColors.grayscaleDark,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      child: LinearProgressIndicator(
                        value: stat.value / 100,
                        backgroundColor: context.appColors.grayscaleLight,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

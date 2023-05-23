import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../models/pokemon_detail.dart';

class PokemonAttributeTile extends StatelessWidget {
  final PokemonDetail pokemonDetail;

  const PokemonAttributeTile({required this.pokemonDetail, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          'assets/images/icons/weight.svg',
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 10),
        Text(
          '${pokemonDetail.weight} kg',
          style: context.textStyles.textRegular
              .copyWith(fontSize: 10, color: context.appColors.grayscaleDark),
        ),
        SizedBox(
          height: 48,
          child: VerticalDivider(
            width: 1,
            color: context.appColors.grayscaleLight,
          ),
        ),
        Transform.rotate(
          angle: pi / 2,
          child: SvgPicture.asset(
            'assets/images/icons/straighten.svg',
            width: 16,
            height: 16,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '${pokemonDetail.height} m',
          style: context.textStyles.textRegular
              .copyWith(fontSize: 10, color: context.appColors.grayscaleDark),
        ),
        SizedBox(
          height: 48,
          child: VerticalDivider(
            width: 1,
            color: context.appColors.grayscaleLight,
          ),
        ),
        Text(
          pokemonDetail.moves.join('\n').split('-').join(' '),
          style: context.textStyles.textRegular
              .copyWith(fontSize: 10, color: context.appColors.grayscaleDark),
        ),
      ],
    );
  }
}

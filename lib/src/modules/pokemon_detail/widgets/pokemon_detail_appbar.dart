import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/ui/extensions/navigator_extension.dart';
import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../models/pokemon_detail.dart';

class PokemonDetailAppbar extends StatelessWidget {
  final PokemonDetail pokemon;

  const PokemonDetailAppbar({required this.pokemon, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      right: 0,
      child: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: SvgPicture.asset(
            'assets/images/icons/arrow_back.svg',
            colorFilter: ColorFilter.mode(
              context.appColors.grayscaleWhite,
              BlendMode.srcIn,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Text(
          pokemon.sanitzedName,
          style: context.textStyles.textBold.copyWith(
            fontSize: 24,
            color: context.appColors.grayscaleWhite,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Text(
              pokemon.sanitizedId,
              style: context.textStyles.textBold.copyWith(
                fontSize: 12,
                color: context.appColors.grayscaleWhite,
              ),
            ),
          ),
        ],
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

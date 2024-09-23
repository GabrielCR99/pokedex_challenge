import 'package:flutter/material.dart';

import '../../../core/ui/extensions/navigator_extension.dart';
import '../../../core/ui/extensions/screen_size_extension.dart';
import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../core/ui/widgets/svg_icon.dart';
import '../../../models/pokemon_detail.dart';

final class PokemonDetailAppbar extends StatelessWidget {
  final PokemonDetail pokemon;

  const PokemonDetailAppbar({required this.pokemon, super.key});

  @override
  Widget build(BuildContext context) {
    final PokemonDetail(:sanitzedName, :sanitizedId) = pokemon;

    return Positioned(
      left: 0,
      top: 0,
      right: 0,
      child: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: SizedBox(
            width: 32.w,
            height: 32.h,
            child: SvgIcon(
              'assets/images/icons/arrow_back.svg',
              colorFilter: ColorFilter.mode(
                context.appColors.grayscaleWhite,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Text(
          sanitzedName,
          style: context.textStyles.textBold.copyWith(
            fontSize: 24.sp,
            color: context.appColors.grayscaleWhite,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Text(
              sanitizedId,
              style: context.textStyles.textBold.copyWith(
                fontSize: 12.sp,
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

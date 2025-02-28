import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/ui/extensions/screen_size_extension.dart';
import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/widgets/svg_icon.dart';
import '../../../models/pokemon_detail.dart';
import '../controller/pokemon_detail_controller.dart';
import 'pokemon_detail_about_tile.dart';
import 'pokemon_detail_appbar.dart';
import 'pokemon_type_chip.dart';

final class LoadedPokemonDetail extends StatelessWidget {
  const LoadedPokemonDetail({
    required this.pokemonDetail,
    required this.pokemonDetailController,
    super.key,
  });

  final PokemonDetailController pokemonDetailController;
  final PokemonDetail pokemonDetail;

  @override
  Widget build(BuildContext context) {
    final PokemonDetail(:id, :imageUrl, :types) = pokemonDetail;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: context.appColors.grayscaleWhite,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                height: 412.h,
                margin: const EdgeInsets.all(4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Align(
                alignment: Alignment.topRight,
                child: SvgIcon(
                  'assets/images/pokeball.svg',
                  width: 208.w,
                  height: 208.h,
                  colorFilter: ColorFilter.mode(
                    context.appColors.grayscaleWhite.withValues(alpha: 0.1),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: kToolbarHeight.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (id == 1)
                          SizedBox(width: 24.w)
                        else
                          IconButton(
                            onPressed:
                                pokemonDetailController.fetchPreviousPokemon,
                            icon: SvgIcon(
                              'assets/images/icons/chevron_left.svg',
                              width: 24.w,
                              height: 24.h,
                              colorFilter: ColorFilter.mode(
                                context.appColors.grayscaleWhite,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        CachedNetworkImage(
                          imageUrl: imageUrl,
                          width: 200.w,
                          height: 200.h,
                        ),
                        IconButton(
                          onPressed: pokemonDetailController.fetchNextPokemon,
                          icon: SvgIcon(
                            'assets/images/icons/chevron_right.svg',
                            width: 24.w,
                            height: 24.h,
                            colorFilter: ColorFilter.mode(
                              context.appColors.grayscaleWhite,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (types.length > 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PokemonTypeChip(
                            type: types.first.capitalizedName,
                            color: types.first.color,
                          ),
                          const SizedBox(width: 10),
                          PokemonTypeChip(
                            type: types.last.capitalizedName,
                            color: types.last.color,
                          ),
                        ],
                      )
                    else
                      PokemonTypeChip(
                        type: types.first.capitalizedName,
                        color: types.first.color,
                      ),
                    const SizedBox(height: 16),
                    PokemonDetailAboutTile(pokemonDetail: pokemonDetail),
                  ],
                ),
              ),
            ),
            PokemonDetailAppbar(pokemon: pokemonDetail),
          ],
        ),
      ),
      backgroundColor: types.first.color,
    );
  }
}

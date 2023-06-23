import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/ui/extensions/screen_size_extension.dart';
import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../models/pokemon_detail.dart';
import '../controller/pokemon_detail_controller.dart';
import 'pokemon_attribute_tile.dart';
import 'pokemon_detail_appbar.dart';
import 'pokemon_type_chip.dart';

class LoadedPokemonDetail extends StatelessWidget {
  final PokemonDetail pokemonDetail;

  const LoadedPokemonDetail({required this.pokemonDetail, super.key});

  @override
  Widget build(BuildContext context) {
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
                child: SvgPicture.asset(
                  'assets/images/pokeball.svg',
                  width: 208.w,
                  height: 208.h,
                  colorFilter: ColorFilter.mode(
                    context.appColors.grayscaleWhite.withOpacity(0.1),
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
                        if (pokemonDetail.id == 1)
                          SizedBox(width: 24.w)
                        else
                          IconButton(
                            onPressed: () => context
                                .read<PokemonDetailController>()
                                .fetchPreviousPokemon(),
                            icon: SvgPicture.asset(
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
                          imageUrl: pokemonDetail.imageUrl,
                          width: 200.w,
                          height: 200.h,
                        ),
                        IconButton(
                          onPressed: () => context
                              .read<PokemonDetailController>()
                              .fetchNextPokemon(),
                          icon: SvgPicture.asset(
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
                    if (pokemonDetail.types.length > 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PokemonTypeChip(
                            type: pokemonDetail.types.first.capitalizedName,
                            color: pokemonDetail.types.first.color,
                          ),
                          const SizedBox(width: 10),
                          PokemonTypeChip(
                            type: pokemonDetail.types.last.capitalizedName,
                            color: pokemonDetail.types.last.color,
                          ),
                        ],
                      )
                    else
                      PokemonTypeChip(
                        type: pokemonDetail.types.first.capitalizedName,
                        color: pokemonDetail.types.first.color,
                      ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        children: [
                          Text(
                            'About',
                            style: context.textStyles.textBold.copyWith(
                              fontSize: 14.sp,
                              color: pokemonDetail.types.first.color,
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
                                pokemonDetail.sanitizedDescription,
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
                              color: pokemonDetail.types.first.color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ...pokemonDetail.stats.map(
                            (stat) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      stat.name
                                          .toUpperCase()
                                          .replaceAll('-', ' '),
                                      style:
                                          context.textStyles.textBold.copyWith(
                                        fontSize: 10,
                                        color: pokemonDetail.types.first.color,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: context.appColors.primaryColor,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Text(
                                        stat.value.toString().padLeft(3, '0'),
                                        style: context.textStyles.textRegular
                                            .copyWith(
                                          fontSize: 10,
                                          color:
                                              context.appColors.grayscaleDark,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(4),
                                      ),
                                      child: LinearProgressIndicator(
                                        value: stat.value / 100,
                                        backgroundColor:
                                            context.appColors.grayscaleLight,
                                        color: pokemonDetail.types.first.color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PokemonDetailAppbar(pokemon: pokemonDetail),
          ],
        ),
      ),
      backgroundColor: pokemonDetail.types.first.color,
    );
  }
}

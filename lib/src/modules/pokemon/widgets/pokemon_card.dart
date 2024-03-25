import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/ui/extensions/navigator_extension.dart';
import '../../../core/ui/extensions/screen_size_extension.dart';
import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../models/pokemon.dart';

final class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({required this.pokemon, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed('/pokemon', arguments: pokemon),
      child: Card(
        color: context.appColors.grayscaleWhite,
        shadowColor: context.appColors.grayscaleWhite,
        surfaceTintColor: context.appColors.grayscaleWhite,
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4, right: 8),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  pokemon.sanitizedId,
                  style:
                      context.textStyles.textRegular.copyWith(fontSize: 8.sp),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: context.appColors.grayscaleBackground,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(7),
                    topRight: Radius.circular(7),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                height: 50,
              ),
            ),
            Positioned.fill(
              top: 10,
              child: Column(
                children: [
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: CachedNetworkImage(imageUrl: pokemon.imageUrl),
                  ),
                  Text(
                    pokemon.sanitzedName,
                    style: context.textStyles.textRegular.copyWith(
                      fontSize: 10.sp,
                      color: context.appColors.grayscaleDark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/ui/extensions/navigator_extension.dart';
import '../../core/ui/extensions/size_extension.dart';
import '../../core/ui/styles/app_colors.dart';
import '../../core/ui/styles/text_styles.dart';
import '../../models/pokemon.dart';
import 'controller/pokemon_detail_controller.dart';
import 'widgets/pokemon_attribute_tile.dart';
import 'widgets/pokemon_base_stats_tile.dart';
import 'widgets/pokemon_type_chip.dart';

class PokemonDetailPage extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailPage({required this.pokemon, super.key});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  PokemonDetailController get _controller =>
      context.read<PokemonDetailController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _controller.fetchPokemonDetail(widget.pokemon.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          widget.pokemon.sanitzedName,
          style: context.textStyles.textBold.copyWith(
            fontSize: 24,
            color: context.appColors.grayscaleWhite,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Text(
              widget.pokemon.sanitizedId,
              style: context.textStyles.textBold.copyWith(
                fontSize: 12,
                color: context.appColors.grayscaleWhite,
              ),
            ),
          ),
        ],
        backgroundColor: context.appColors.grassTypeColor,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: context.appColors.grayscaleWhite,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              height: context.height * 0.6,
              margin: const EdgeInsets.all(4),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 208,
              height: 208,
              child: SvgPicture.asset(
                'assets/images/pokeball.svg',
                width: 208,
                height: 208,
                colorFilter: ColorFilter.mode(
                  context.appColors.grayscaleWhite.withOpacity(0.1),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: context.percentHeight(0.1),
            child: Column(
              children: [
                Hero(
                  tag: widget.pokemon.imageUrl,
                  child: CachedNetworkImage(
                    imageUrl: widget.pokemon.imageUrl,
                    width: 200,
                    height: 200,
                  ),
                ),
                const PokemonTypeChip(),
                Text(
                  'About',
                  style: context.textStyles.textBold.copyWith(
                    fontSize: 14,
                    color: context.appColors.grassTypeColor,
                  ),
                ),
                BlocBuilder<PokemonDetailController, PokemonDetailState>(
                  builder: (_, state) => switch (state.status) {
                    PokemonDetailStatus.loading =>
                      const Center(child: CircularProgressIndicator()),
                    PokemonDetailStatus.loaded =>
                      PokemonAttributeTile(pokemonDetail: state.pokemonDetail),
                    _ => const SizedBox.shrink(),
                  },
                ),
                BlocBuilder<PokemonDetailController, PokemonDetailState>(
                  builder: (_, state) => switch (state.status) {
                    PokemonDetailStatus.loading =>
                      const Center(child: CircularProgressIndicator()),
                    PokemonDetailStatus.loaded => Text(
                        state.pokemonDetail.speciesDescription
                            .replaceAll('\n', ' '),
                        style: context.textStyles.textRegular.copyWith(
                          fontSize: 10,
                          color: context.appColors.grayscaleDark,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    _ => const SizedBox.shrink(),
                  },
                ),
                Text(
                  'Base stats',
                  style: context.textStyles.textBold.copyWith(
                    fontSize: 14,
                    color: context.appColors.grassTypeColor,
                  ),
                ),
                BlocBuilder<PokemonDetailController, PokemonDetailState>(
                  builder: (_, state) => switch (state.status) {
                    PokemonDetailStatus.loading =>
                      const Center(child: CircularProgressIndicator()),
                    PokemonDetailStatus.loaded =>
                      PokemonBaseStatsTile(pokemonDetail: state.pokemonDetail),
                    _ => const SizedBox.shrink(),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: context.appColors.grassTypeColor,
    );
  }
}

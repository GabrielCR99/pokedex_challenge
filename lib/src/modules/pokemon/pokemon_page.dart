import 'package:flutter/material.dart';

import '../../core/ui/extensions/screen_size_extension.dart';
import '../../core/ui/styles/app_colors.dart';
import '../../core/ui/styles/text_styles.dart';
import '../../core/ui/widgets/spinning_pokeball_animation.dart';
import '../../core/ui/widgets/svg_icon.dart';
import 'controllers/pokemon_controller.dart';
import 'widgets/pokemon_list.dart';
import 'widgets/search_text_field.dart';
import 'widgets/sort_card.dart';

final class PokemonPage extends StatefulWidget {
  const PokemonPage({required this.controller, super.key});

  final PokemonController controller;

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

final class _PokemonPageState extends State<PokemonPage> {
  final _searchEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgIcon(
              'assets/images/icons/pokeball.svg',
              width: 24.w,
              height: 24.h,
              colorFilter: ColorFilter.mode(
                context.appColors.grayscaleWhite,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'Pokédex',
              style: context.textStyles.textBold.copyWith(
                fontSize: 24.sp,
                color: context.appColors.grayscaleWhite,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: SearchTextField(
                    textEditingController: _searchEC,
                    controller: widget.controller,
                  ),
                ),
                const SizedBox(width: 16),
                SortCard(controller: widget.controller),
              ],
            ),
          ),
        ),
        elevation: 0,
        shadowColor: context.appColors.primaryColor,
        surfaceTintColor: context.appColors.grayscaleWhite,
        backgroundColor: context.appColors.primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: context.appColors.grayscaleWhite,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        margin: const EdgeInsets.only(left: 4, top: 24, right: 4, bottom: 4),
        child: ValueListenableBuilder(
          valueListenable: widget.controller,
          builder: (_, state, __) => switch (state.status) {
            PokemonStatus.loading => const Center(
                child:
                    SpinningPokeballAnimation(key: Key('loading_pokemon_list')),
              ),
            PokemonStatus.loaded when state.pokemonList.isEmpty =>
              const Center(child: Text('No pokémon found')),
            PokemonStatus.loaded => PokemonList(
                controller: widget.controller,
                pokemonList: state.pokemonList,
                key: const Key('loaded_pokemon_list'),
              ),
            PokemonStatus.error => Center(
                key: const Key('pokemon_list_error'),
                child: Text(state.errorMessage ?? 'Internal error'),
              ),
            _ => const SizedBox.shrink()
          },
        ),
      ),
      backgroundColor: context.appColors.primaryColor,
      resizeToAvoidBottomInset: false,
    );
  }

  @override
  void dispose() {
    _searchEC.dispose();
    super.dispose();
  }
}

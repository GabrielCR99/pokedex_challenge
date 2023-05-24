import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../controllers/pokemon_controller.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;

  const SearchTextField({required this.controller, super.key});

  static const _defaultBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );

  void _clearSearchQuery(PokemonController pokemonController) {
    controller.clear();
    pokemonController.filterPokemon('');
  }

  @override
  Widget build(BuildContext context) {
    final pokemonController = context.read<PokemonController>();

    return SizedBox(
      height: 32,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: context.textStyles.textRegular.copyWith(fontSize: 10),
          prefixIcon: SvgPicture.asset(
            'assets/images/icons/search.svg',
            width: 16,
            height: 16,
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(
              context.appColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          suffixIcon: BlocSelector<PokemonController, PokemonState, bool>(
            selector: (state) => switch (state.status) {
              PokemonStatus.loaded => state.searchQuery.isNotEmpty,
              _ => false,
            },
            builder: (_, hasText) => hasText
                ? IconButton(
                    onPressed: () => _clearSearchQuery(pokemonController),
                    icon: Icon(
                      Icons.clear,
                      size: 16,
                      color: context.appColors.primaryColor,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          filled: true,
          fillColor: context.appColors.grayscaleWhite,
          focusedBorder: _defaultBorder,
          enabledBorder: _defaultBorder,
          border: _defaultBorder,
        ),
        onChanged: pokemonController.filterPokemon,
      ),
    );
  }
}

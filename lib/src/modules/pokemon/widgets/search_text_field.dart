import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/ui/styles/app_colors.dart';
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

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: const Text('Search'),
        isDense: true,
        prefixIcon: SvgPicture.asset(
          'assets/images/icons/search.svg',
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
                  icon:
                      Icon(Icons.clear, color: context.appColors.primaryColor),
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
    );
  }
}

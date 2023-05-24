import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/ui/styles/app_colors.dart';
import '../../core/ui/styles/text_styles.dart';
import 'controllers/pokemon_controller.dart';
import 'widgets/pokemon_list.dart';
import 'widgets/search_text_field.dart';
import 'widgets/sort_card.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  PokemonController get _controller => context.read<PokemonController>();

  final _searchEC = TextEditingController();
  final _scrollController = ScrollController();

  bool get hasReachedEndScroll {
    if (!_scrollController.hasClients) {
      return false;
    }

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    final isScrollOutOfRange = _scrollController.position.outOfRange;

    return currentScroll >= maxScroll && !isScrollOutOfRange;
  }

  void _scrollListener() {
    if (hasReachedEndScroll) {
      _controller.fetchMorePokemon();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      const loader = SvgAssetLoader('assets/images/pokeball.svg');
      await svg.cache
          .putIfAbsent(loader.cacheKey(context), () => loader.loadBytes(null));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/images/icons/pokeball.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                context.appColors.grayscaleWhite,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'Pokédex',
              style: context.textStyles.textBold.copyWith(
                fontSize: 24,
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
                Expanded(child: SearchTextField(controller: _searchEC)),
                const SizedBox(width: 16),
                SortCard(controller: _controller),
              ],
            ),
          ),
        ),
        elevation: 0,
        shadowColor: context.appColors.primaryColor,
        backgroundColor: context.appColors.primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: context.appColors.grayscaleWhite,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        margin: const EdgeInsets.only(left: 4, top: 24, right: 4, bottom: 4),
        child: BlocBuilder<PokemonController, PokemonState>(
          builder: (_, state) => switch (state.status) {
            PokemonStatus.loading =>
              const Center(child: CircularProgressIndicator.adaptive()),
            PokemonStatus.loaded when state.pokemonList.isEmpty =>
              const Center(child: Text('No pokémon found')),
            PokemonStatus.loaded => PokemonList(
                scrollController: _scrollController,
                pokemonList: state.pokemonList,
              ),
            PokemonStatus.error =>
              Center(child: Text(state.errorMessage ?? 'Internal error')),
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
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }
}

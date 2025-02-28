import 'package:provider/provider.dart';

import 'controllers/pokemon_controller.dart';
import 'pokemon_page.dart';

final class PokemonModule extends ChangeNotifierProvider<PokemonController> {
  PokemonModule({super.key})
    : super(
        create:
            (context) =>
                PokemonController(service: context.read())..fetchPokemon(),
        lazy: true,
        builder: (context, _) => PokemonPage(controller: context.read()),
      );
}

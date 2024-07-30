import 'package:provider/provider.dart';

import 'controllers/pokemon_controller.dart';
import 'pokemon_page.dart';

class PokemonModule extends ChangeNotifierProvider<PokemonController> {
  PokemonModule({super.key})
      : super(
          create: (context) =>
              PokemonController(service: context.read())..fetchPokemon(),
          builder: (context, _) => PokemonPage(controller: context.read()),
        );
}

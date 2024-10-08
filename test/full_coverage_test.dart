// ignore_for_file: unused_import
import 'package:snapfi_mobile_challenge_pokedex_roveri/main.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/app_module.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/app_widget.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/app_config.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/constants/constants.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/exceptions/failure.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/helpers/rest_client_helper.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/logger/app_logger.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/logger/app_logger_impl.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/dio/dio_rest_client.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/dio/interceptors/rest_client_log_interceptor.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/rest_client.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/rest_client_exception.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/shared/data/rest_client/rest_client_response.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/ui/extensions/as_html_color_to_color.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/ui/extensions/navigator_extension.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/ui/extensions/remove_all.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/ui/extensions/screen_size_extension.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/ui/styles/app_colors.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/ui/styles/app_styles.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/ui/styles/text_styles.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/ui/widgets/spinning_pokeball_animation.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/ui/widgets/svg_icon.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/core/ui/widgets/value_listenable_selector.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon_detail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon_stat.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/models/pokemon_type.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/core/core_module.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon/controllers/pokemon_controller.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon/helpers/pokemon_helper.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon/pokemon_module.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon/pokemon_page.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon/widgets/pokemon_card.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon/widgets/pokemon_list.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon/widgets/search_text_field.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon/widgets/sort_card.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon_detail/controller/pokemon_detail_controller.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon_detail/pokemon_detail_module.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon_detail/pokemon_detail_page.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon_detail/widgets/loaded_pokemon_detail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon_detail/widgets/loading_pokemon_detail.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon_detail/widgets/pokemon_attribute_info.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon_detail/widgets/pokemon_attribute_tile.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon_detail/widgets/pokemon_detail_about_tile.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon_detail/widgets/pokemon_detail_appbar.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon_detail/widgets/pokemon_detail_error.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/modules/pokemon_detail/widgets/pokemon_type_chip.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/repositories/pokemon/pokemon_repository.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/repositories/pokemon/pokemon_repository_impl.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/repositories/pokemon_detail/pokemon_detail_repository.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/repositories/pokemon_detail/pokemon_detail_repository_impl.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/services/pokemon/pokemon_service.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/services/pokemon/pokemon_service_impl.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/services/pokemon_detail/pokemon_detail_service.dart';
import 'package:snapfi_mobile_challenge_pokedex_roveri/src/services/pokemon_detail/pokemon_detail_service_impl.dart';

void main() {}

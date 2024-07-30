import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/ui/extensions/screen_size_extension.dart';
import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../controllers/pokemon_controller.dart';

final class SearchTextField extends StatelessWidget {
  const SearchTextField({
    required this.controller,
    required this.textEditingController,
    super.key,
  });

  final PokemonController controller;
  final TextEditingController textEditingController;

  void _clearSearchQuery() {
    textEditingController.clear();
    controller.filterPokemon('');
  }

  @override
  Widget build(BuildContext context) {
    const defaultBorder = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(16)),
    );

    return SizedBox(
      height: 32,
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: context.textStyles.textRegular.copyWith(fontSize: 10.sp),
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
          suffixIcon: ValueListenableBuilder(
            valueListenable: textEditingController,
            builder: (_, textValue, __) => textValue.text.isNotEmpty
                ? IconButton(
                    onPressed: _clearSearchQuery,
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
          focusedBorder: defaultBorder,
          enabledBorder: defaultBorder,
          border: defaultBorder,
        ),
        onChanged: controller.filterPokemon,
      ),
    );
  }
}

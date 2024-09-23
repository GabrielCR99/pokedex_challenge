import 'package:flutter/material.dart';

import '../../../core/ui/extensions/screen_size_extension.dart';
import '../../../core/ui/styles/app_colors.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../core/ui/widgets/svg_icon.dart';
import '../../../core/ui/widgets/value_listenable_selector.dart';
import '../controllers/pokemon_controller.dart';
import '../helpers/pokemon_helper.dart';

final class SortCard extends StatelessWidget {
  const SortCard({required this.controller, super.key});

  final PokemonController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32.w,
      height: 32.h,
      child: Material(
        type: MaterialType.card,
        elevation: 4,
        shape: const CircleBorder(),
        child: PopupMenuButton<void>(
          itemBuilder: (_) => [
            PopupMenuItem(
              enabled: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, top: 16, bottom: 16),
                    child: Text(
                      'Sort by:',
                      style: context.textStyles.textBold.copyWith(
                        color: context.appColors.grayscaleWhite,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final sortBy in SortBy.values)
                          ValueListenableSelector<PokemonState, SortBy?>(
                            valueListenable: controller,
                            selector: (state) => switch (state.status) {
                              PokemonStatus.loaded => state.sortBy,
                              _ => null,
                            },
                            builder: (_, state, __) => _SortRadioTile(
                              label: sortBy.value,
                              value: sortBy,
                              groupValue: state,
                              onChanged: (value) => value != null
                                  ? controller.sortPokemon(value)
                                  : null,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          tooltip: 'Sort by',
          padding: EdgeInsets.zero,
          icon: ValueListenableSelector<PokemonState, bool>(
            valueListenable: controller,
            selector: (state) => state.sortBy == SortBy.number,
            builder: (_, sortBy, __) => SvgIcon(
              'assets/images/icons/${sortBy ? 'tag' : 'text_format'}.svg',
              width: 16.w,
              height: 16.h,
              colorFilter: ColorFilter.mode(
                context.appColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          color: context.appColors.primaryColor,
          position: PopupMenuPosition.under,
        ),
      ),
    );
  }
}

final class _SortRadioTile extends StatelessWidget {
  final String label;
  final SortBy value;
  final SortBy? groupValue;
  final ValueChanged<SortBy?> onChanged;

  const _SortRadioTile({
    required this.label,
    required this.value,
    required this.onChanged,
    this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              label,
              style: context.textStyles.textRegular.copyWith(
                fontSize: 10.sp,
                color: context.appColors.grayscaleDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

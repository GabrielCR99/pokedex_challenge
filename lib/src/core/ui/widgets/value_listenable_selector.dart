import 'package:flutter/material.dart';

final class ValueListenableSelector<S, T> extends StatelessWidget {
  final ValueNotifier<S> valueListenable;
  final T Function(S state) selector;
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Widget? child;

  const ValueListenableSelector({
    required this.valueListenable,
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<S>(
      valueListenable: valueListenable,
      builder: (context, state, child) {
        final selectedValue = selector(state);

        return builder(context, selectedValue, child);
      },
      child: child,
    );
  }
}

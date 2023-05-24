import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  NavigatorState get _navigator => Navigator.of(this);

  void pop<T extends Object?>([T? result]) => _navigator.pop(result);

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) =>
      _navigator.pushNamed<T>(routeName, arguments: arguments);
}

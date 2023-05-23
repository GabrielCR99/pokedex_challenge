import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  NavigatorState get _navigator => Navigator.of(this);

  void pop<T extends Object?>([T? result]) => _navigator.pop(result);

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) =>
      _navigator.pushNamed<T>(routeName, arguments: arguments);

  Future<T?> push<T extends Object?>(Widget widget) =>
      _navigator.push<T>(MaterialPageRoute<T>(builder: (_) => widget));

  Future<T?> navigateNamed<T extends Object?>(
    String newRouteName, {
    Object? arguments,
  }) =>
      _navigator.pushNamedAndRemoveUntil<T>(
        newRouteName,
        (_) => false,
        arguments: arguments,
      );

  Future<T?> navigate<T extends Object?>(Widget widget) =>
      _navigator.pushAndRemoveUntil<T>(
        MaterialPageRoute<T>(builder: (_) => widget),
        (_) => false,
      );
}

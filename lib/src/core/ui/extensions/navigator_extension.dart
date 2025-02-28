import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  NavigatorState get _navigator => Navigator.of(this);

  void pop<T extends Object?>([T? result]) => _navigator.pop<T>(result);

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    required Object arguments,
  }) => _navigator.pushNamed<T>(routeName, arguments: arguments);
}

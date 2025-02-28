part of '../../../app_widget.dart';

final _lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _lightColorScheme,
  scaffoldBackgroundColor: _lightColorScheme.onPrimary,
  appBarTheme: AppBarTheme(
    color: _lightColorScheme.onPrimary,
    foregroundColor: _lightColorScheme.onPrimary,
    elevation: 0,
    shadowColor: _lightColorScheme.onPrimary,
    surfaceTintColor: _lightColorScheme.onPrimary,
    iconTheme: IconThemeData(color: _lightColorScheme.primary),
    centerTitle: false,
    titleTextStyle: TextStyles.i.textBold.copyWith(
      fontSize: 16,
      color: Colors.black,
    ),
  ),
);

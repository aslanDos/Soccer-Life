import 'package:flutter/material.dart';
import 'package:soccer_life/core/constants/app_constants.dart';
import 'package:soccer_life/core/shared/theme/app_color_scheme.dart';
import 'package:soccer_life/core/shared/theme/app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static const fontFamily = AppConstants.fontFamilyPrimary;

  static final ThemeData light = _buildTheme(AppColorScheme.light);
  static final ThemeData dark = _buildTheme(AppColorScheme.dark);

  static ThemeData _buildTheme(ColorScheme colorScheme) {
    final bool isDark = colorScheme.brightness == Brightness.dark;

    final TextTheme textTheme = appTextTheme.apply(
      fontFamily: fontFamily,
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
      decorationColor: colorScheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      textTheme: textTheme,
      colorScheme: colorScheme,
      brightness: colorScheme.brightness,
    );
  }
}

import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // ---------------------------------------------------------------------------
  // Core color tokens used across the app (7 colors)
  // ---------------------------------------------------------------------------
  static const Color green = Color(0xFF00594F);
  static const Color gold = Color(0xFFad9e6e);
  static const Color redPrimary = Color(0xFF420023);
  static const Color redSecondary = Color(0xFF672146);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF021526);
  static const Color hintGrey = Color(0xFFC5CBC8);

  // Supporting tones for accessible light/dark ColorScheme mapping.
  static const Color _greenLight = Color(0xFF006e5c);
  static const Color _greenDark = Color(0xFF279e91);
  static const Color _goldDark = Color(0xFFd9c89e);
  static const Color _lightSurfaceAlt = Color(0xFFe3ddd2);
  static const Color _darkSurfaceAlt = Color(0xFF021526);
  static const Color _darkSurfaceHigh = Color(0xFF021526);
  static const Color _darkOutline = Color(0xFF9AA0A6);

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: green,
    onPrimary: white,
    primaryContainer: _greenLight,
    onPrimaryContainer: white,
    secondary: gold,
    onSecondary: black,
    secondaryContainer: Color(0xFFF0E8D2),
    onSecondaryContainer: black,
    tertiary: redPrimary,
    onTertiary: white,
    tertiaryContainer: redSecondary,
    onTertiaryContainer: white,
    error: redPrimary,
    onError: white,
    errorContainer: redSecondary,
    onErrorContainer: white,
    surface: white,
    onSurface: black,
    surfaceDim: _lightSurfaceAlt,
    surfaceBright: white,
    surfaceContainerLowest: white,
    surfaceContainerLow: Color(0xFFFBFBFB),
    surfaceContainer: _lightSurfaceAlt,
    surfaceContainerHigh: Color(0xFFF1F1F1),
    surfaceContainerHighest: Color(0xFFE9E9E9),
    onSurfaceVariant: black,
    outline: hintGrey,
    outlineVariant: Color(0xFFE0E2E4),
    shadow: black,
    scrim: black,
    inverseSurface: black,
    onInverseSurface: white,
    inversePrimary: _greenDark,
    surfaceTint: green,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: _greenDark,
    onPrimary: black,
    primaryContainer: green,
    onPrimaryContainer: white,
    secondary: _goldDark,
    onSecondary: black,
    secondaryContainer: Color(0xFF6F643F),
    onSecondaryContainer: white,
    tertiary: Color(0xFFCB8CA3),
    onTertiary: black,
    tertiaryContainer: redPrimary,
    onTertiaryContainer: white,
    error: Color(0xFFCB8CA3),
    onError: black,
    errorContainer: redPrimary,
    onErrorContainer: white,
    surface: black,
    onSurface: white,
    surfaceDim: black,
    surfaceBright: _darkSurfaceAlt,
    surfaceContainerLowest: black,
    surfaceContainerLow: Color(0xFF0E0E0E),
    surfaceContainer: _darkSurfaceAlt,
    surfaceContainerHigh: _darkSurfaceHigh,
    surfaceContainerHighest: Color(0xFF2A2A2A),
    onSurfaceVariant: white,
    outline: _darkOutline,
    outlineVariant: Color(0xFF3A3F44),
    shadow: black,
    scrim: black,
    inverseSurface: white,
    onInverseSurface: black,
    inversePrimary: green,
    surfaceTint: _greenDark,
  );
}

extension AppColorSchemeX on ColorScheme {
  Color get brandGreen => primary;
  Color get brandGold => secondary;
  Color get brandRed => error;
  Color get brandRedAlt => errorContainer;
  Color get appBackground => surface;
  Color get appForeground => onSurface;
  Color get hintText => outline;
}

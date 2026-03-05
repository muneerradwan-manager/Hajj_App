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

  /// Semi-transparent overlay used behind content areas below hero sections.
  static const Color overlay = Color(0xFFE5E0D6);

  // Supporting tones for accessible light/dark ColorScheme mapping.
  static const Color _greenLight = Color(0xFF006e5c);
  static const Color _greenDark = Color(0xFF279e91);
  static const Color _lightSurfaceAlt = Color(0xFFe3ddd2);

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

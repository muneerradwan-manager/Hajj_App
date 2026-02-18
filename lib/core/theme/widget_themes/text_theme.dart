import 'package:flutter/material.dart';

TextTheme buildAppTextTheme(ColorScheme cs) {
  final TextTheme base = Typography.material2021().black;

  return base.copyWith(
    // Display
    displayLarge: base.displayLarge?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w700,
      fontSize: 57,
      height: 64 / 57,
      letterSpacing: -0.25,
    ),
    displayMedium: base.displayMedium?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w700,
      fontSize: 45,
      height: 52 / 45,
      letterSpacing: 0,
    ),
    displaySmall: base.displaySmall?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w700,
      fontSize: 36,
      height: 44 / 36,
      letterSpacing: 0,
    ),

    // Headline
    headlineLarge: base.headlineLarge?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w700,
      fontSize: 32,
      height: 40 / 32,
      letterSpacing: 0,
    ),
    headlineMedium: base.headlineMedium?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w700,
      fontSize: 28,
      height: 36 / 28,
      letterSpacing: 0,
    ),
    headlineSmall: base.headlineSmall?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 24,
      height: 32 / 24,
      letterSpacing: 0,
    ),

    // Title
    titleLarge: base.titleLarge?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 22,
      height: 28 / 22,
      letterSpacing: 0,
    ),
    titleMedium: base.titleMedium?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.15,
    ),
    titleSmall: base.titleSmall?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
    ),

    // Body
    bodyLarge: base.bodyLarge?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.5,
    ),
    bodyMedium: base.bodyMedium?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.25,
    ),
    bodySmall: base.bodySmall?.copyWith(
      color: cs.onSurface.withValues(alpha: 0.8),
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.4,
    ),

    // Label
    labelLarge: base.labelLarge?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
    ),
    labelMedium: base.labelMedium?.copyWith(
      color: cs.onSurface.withValues(alpha: 0.9),
      fontWeight: FontWeight.w600,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.5,
    ),
    labelSmall: base.labelSmall?.copyWith(
      color: cs.onSurface.withValues(alpha: 0.8),
      fontWeight: FontWeight.w600,
      fontSize: 11,
      height: 16 / 11,
      letterSpacing: 0.5,
    ),
  );
}

import 'package:flutter/material.dart';

TextTheme buildAppTextTheme(ColorScheme cs) {
  final TextTheme base = Typography.material2021().black;

  return base.copyWith(
    displayLarge: base.displayLarge?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: base.displayMedium?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: base.displaySmall?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w700,
    ),
    headlineLarge: base.headlineLarge?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: base.headlineMedium?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: base.headlineSmall?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: base.titleLarge?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: base.titleMedium?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: base.titleSmall?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: base.bodyLarge?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: base.bodyMedium?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: base.bodySmall?.copyWith(
      color: cs.onSurface.withValues(alpha: 0.8),
      fontWeight: FontWeight.w400,
    ),
    labelLarge: base.labelLarge?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: base.labelMedium?.copyWith(
      color: cs.onSurface.withValues(alpha: 0.9),
      fontWeight: FontWeight.w600,
    ),
    labelSmall: base.labelSmall?.copyWith(
      color: cs.onSurface.withValues(alpha: 0.8),
      fontWeight: FontWeight.w600,
    ),
  );
}

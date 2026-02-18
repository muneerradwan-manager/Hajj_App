import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

InputDecorationTheme buildAppInputDecorationTheme(ColorScheme cs) {
  return InputDecorationTheme(
    filled: true,
    fillColor: cs.surfaceContainer,
    hintStyle: TextStyle(color: cs.outline),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSizes.spacingMd,
      vertical: AppSizes.spacingMd,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      borderSide: BorderSide(color: cs.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      borderSide: BorderSide(color: cs.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      borderSide: BorderSide(color: cs.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      borderSide: BorderSide(color: cs.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      borderSide: BorderSide(color: cs.error, width: 2),
    ),
  );
}

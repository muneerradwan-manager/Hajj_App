import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

ElevatedButtonThemeData buildAppElevatedButtonTheme(ColorScheme cs) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacingLg,
        vertical: AppSizes.spacingMd,
      ),
      minimumSize: const Size(double.infinity, 50),
      elevation: 0,
      backgroundColor: cs.primary,
      foregroundColor: cs.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );
}

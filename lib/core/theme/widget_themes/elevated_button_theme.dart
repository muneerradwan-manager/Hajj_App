import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

ElevatedButtonThemeData buildAppElevatedButtonTheme(ColorScheme cs) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: AppSizes.elevationSm,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacingLg,
        vertical: AppSizes.spacingMd,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      ),
      minimumSize: const Size(64, 48),
    ),
  );
}

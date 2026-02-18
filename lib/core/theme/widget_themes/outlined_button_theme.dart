import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

OutlinedButtonThemeData buildAppOutlinedButtonTheme(ColorScheme cs) {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacingLg,
        vertical: AppSizes.spacingMd,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      ),
      side: BorderSide(color: cs.outline),
      minimumSize: const Size(64, 48),
    ),
  );
}

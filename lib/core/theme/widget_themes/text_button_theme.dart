import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

TextButtonThemeData buildAppTextButtonTheme(ColorScheme cs) {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
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

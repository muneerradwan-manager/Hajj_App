import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

OutlinedButtonThemeData buildAppOutlinedButtonTheme(ColorScheme cs) {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacingLg,
        vertical: AppSizes.spacingMd,
      ),
      minimumSize: const Size(double.infinity, 50),
      foregroundColor: cs.secondary,
      side: BorderSide(color: cs.secondary, width: 1.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}

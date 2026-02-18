import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

CardThemeData buildAppCardTheme(ColorScheme cs) {
  return CardThemeData(
    elevation: AppSizes.elevationSm,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
    ),
    color: cs.surface,
    surfaceTintColor: cs.surfaceTint,
  );
}

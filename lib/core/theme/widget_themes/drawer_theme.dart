import 'package:flutter/material.dart';

import 'package:bawabatelhajj/core/constants/app_sizes.dart';

DrawerThemeData buildAppDrawerTheme(ColorScheme cs) {
  return DrawerThemeData(
    elevation: AppSizes.elevationXl,
    backgroundColor: cs.surface,
    surfaceTintColor: cs.surfaceTint,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(
        right: Radius.circular(AppSizes.borderRadiusXl),
      ),
    ),
  );
}

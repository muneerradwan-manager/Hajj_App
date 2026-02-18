import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

DialogThemeData buildAppDialogTheme(ColorScheme cs) {
  return DialogThemeData(
    elevation: AppSizes.elevationLg,
    backgroundColor: cs.surface,
    surfaceTintColor: cs.surfaceTint,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
    ),
  );
}

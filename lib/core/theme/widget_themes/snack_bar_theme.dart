import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

SnackBarThemeData buildAppSnackBarTheme(ColorScheme cs) {
  return SnackBarThemeData(
    backgroundColor: cs.inverseSurface,
    contentTextStyle: TextStyle(color: cs.onInverseSurface),
    actionTextColor: cs.secondary,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
    ),
    elevation: AppSizes.elevationMd,
  );
}

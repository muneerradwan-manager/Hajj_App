import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

FloatingActionButtonThemeData buildAppFloatingActionButtonTheme(
  ColorScheme cs,
) {
  return FloatingActionButtonThemeData(
    elevation: AppSizes.elevationMd,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl),
    ),
  );
}

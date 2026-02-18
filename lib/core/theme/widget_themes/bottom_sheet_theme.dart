import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

BottomSheetThemeData buildAppBottomSheetTheme(ColorScheme cs) {
  return BottomSheetThemeData(
    elevation: AppSizes.elevationXl,
    backgroundColor: cs.surface,
    surfaceTintColor: cs.surfaceTint,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSizes.borderRadiusXl),
      ),
    ),
  );
}
